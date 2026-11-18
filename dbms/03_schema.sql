
-- =====================================================
-- MealBridge Database Schema
-- DBMS Project | PostgreSQL
-- =====================================================

-- 1. USERS TABLE
-- Stores user profile information.
-- Authentication is handled separately by Firebase.

CREATE TABLE users (
    email VARCHAR(255) PRIMARY KEY,
    display_name VARCHAR(150) NOT NULL,
    photo_url TEXT
);


-- 2. FOODS TABLE
-- Stores food donations posted by users.

CREATE TABLE foods (
    food_id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,

    donor_email VARCHAR(255) NOT NULL,

    food_name VARCHAR(150) NOT NULL,
    food_image TEXT,

    quantity INTEGER NOT NULL CHECK (quantity > 0),

    location VARCHAR(255) NOT NULL,
    expiry_date DATE NOT NULL,

    notes TEXT,

    status VARCHAR(30) NOT NULL DEFAULT 'available'
        CHECK (status IN ('available', 'requested', 'completed')),

    CONSTRAINT fk_food_donor
        FOREIGN KEY (donor_email)
        REFERENCES users(email)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);


-- 3. FOOD_REQUESTS TABLE
-- Stores requests submitted by users for donated food.

CREATE TABLE food_requests (
    request_id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,

    food_id BIGINT NOT NULL,

    requester_email VARCHAR(255) NOT NULL,

    requested_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    notes TEXT,

    status VARCHAR(30) NOT NULL DEFAULT 'requested'
        CHECK (status IN ('requested', 'approved', 'rejected', 'completed')),

    CONSTRAINT fk_request_food
        FOREIGN KEY (food_id)
        REFERENCES foods(food_id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,

    CONSTRAINT fk_request_user
        FOREIGN KEY (requester_email)
        REFERENCES users(email)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);

