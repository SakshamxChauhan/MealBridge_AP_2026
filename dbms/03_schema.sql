DROP SCHEMA IF EXISTS mealbridge_ap CASCADE;
CREATE SCHEMA mealbridge_ap;
SET search_path TO mealbridge_ap;

CREATE TABLE users (
    user_id SERIAL PRIMARY KEY,
    full_name VARCHAR(120) NOT NULL,
    email VARCHAR(150) UNIQUE NOT NULL,
    role VARCHAR(20) NOT NULL CHECK (role IN ('DONOR', 'RECIPIENT', 'ADMIN')),
    city VARCHAR(80) NOT NULL,
    capacity INT NOT NULL DEFAULT 0 CHECK (capacity >= 0),
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE TABLE food_listings (
    listing_id SERIAL PRIMARY KEY,
    donor_id INT NOT NULL REFERENCES users(user_id) ON DELETE CASCADE,
    food_item VARCHAR(150) NOT NULL,
    category VARCHAR(50) NOT NULL,
    quantity_kg NUMERIC(8,2) NOT NULL CHECK (quantity_kg > 0),
    status VARCHAR(20) NOT NULL DEFAULT 'AVAILABLE' CHECK (status IN ('AVAILABLE', 'CLAIMED', 'DELIVERED', 'EXPIRED')),
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    expires_at TIMESTAMPTZ NOT NULL,
    CONSTRAINT chk_listing_expiry CHECK (expires_at > created_at)
);

CREATE TABLE claims (
    claim_id SERIAL PRIMARY KEY,
    listing_id INT UNIQUE NOT NULL REFERENCES food_listings(listing_id) ON DELETE CASCADE,
    recipient_id INT NOT NULL REFERENCES users(user_id) ON DELETE CASCADE,
    claimed_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    pickup_status VARCHAR(20) NOT NULL DEFAULT 'PENDING' CHECK (pickup_status IN ('PENDING', 'PICKED_UP', 'COMPLETED'))
);

CREATE TABLE delivery_logs (
    log_id SERIAL PRIMARY KEY,
    claim_id INT UNIQUE NOT NULL REFERENCES claims(claim_id) ON DELETE CASCADE,
    verified_by VARCHAR(100) NOT NULL,
    delivered_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    notes TEXT
);

CREATE OR REPLACE FUNCTION sync_listing_status_on_claim()
RETURNS TRIGGER AS $$
DECLARE
    current_status VARCHAR(20);
    listing_expiry TIMESTAMPTZ;
BEGIN
    SELECT status, expires_at INTO current_status, listing_expiry
    FROM mealbridge_ap.food_listings
    WHERE listing_id = NEW.listing_id
    FOR UPDATE;

    IF current_status <> 'AVAILABLE' THEN
        RAISE EXCEPTION 'Listing % is not available (current status: %)', NEW.listing_id, current_status;
    END IF;

    IF listing_expiry <= NOW() THEN
        UPDATE mealbridge_ap.food_listings SET status = 'EXPIRED' WHERE listing_id = NEW.listing_id;
        RAISE EXCEPTION 'Listing % has already expired', NEW.listing_id;
    END IF;

    UPDATE mealbridge_ap.food_listings
    SET status = 'CLAIMED'
    WHERE listing_id = NEW.listing_id;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_sync_listing_on_claim
BEFORE INSERT ON claims
FOR EACH ROW
EXECUTE FUNCTION sync_listing_status_on_claim();

CREATE INDEX idx_users_city_role ON users (city, role);
CREATE INDEX idx_listings_available ON food_listings (created_at DESC) INCLUDE (donor_id, food_item, quantity_kg) WHERE status = 'AVAILABLE';
CREATE INDEX idx_listings_donor ON food_listings (donor_id);
CREATE INDEX idx_claims_recipient ON claims (recipient_id, claimed_at DESC);
