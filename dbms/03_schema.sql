DROP SCHEMA IF EXISTS mealbridge_ap CASCADE;
CREATE SCHEMA mealbridge_ap;
SET search_path TO mealbridge_ap;

CREATE TABLE users (
    user_id SERIAL PRIMARY KEY,
    full_name VARCHAR(120) NOT NULL,
    email VARCHAR(150) UNIQUE NOT NULL,
    role VARCHAR(20) NOT NULL CHECK (role IN ('DONOR', 'RECIPIENT', 'ADMIN')),
    city VARCHAR(80) NOT NULL,
    capacity INT DEFAULT 0,
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
    expires_at TIMESTAMPTZ NOT NULL
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

CREATE INDEX idx_listings_city_status ON food_listings (status, created_at DESC);
CREATE INDEX idx_listings_donor ON food_listings (donor_id);
CREATE INDEX idx_claims_recipient ON claims (recipient_id, claimed_at DESC);
