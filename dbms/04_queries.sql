
-- =====================================================
-- MealBridge DBMS Project
-- File: 04_queries.sql
-- Database: PostgreSQL
-- =====================================================


-- =====================================================
-- READ QUERIES
-- =====================================================

-- READ 1: Display all available food donations.
SELECT *
FROM foods
WHERE status = 'available';


-- READ 2: Display food details along with donor information.
-- JOIN: foods and users
SELECT
    f.food_id,
    f.food_name,
    f.quantity,
    f.location,
    f.expiry_date,
    u.display_name AS donor_name,
    u.email AS donor_email
FROM foods AS f
INNER JOIN users AS u
    ON f.donor_email = u.email;


-- READ 3: Display all requests with food and requester details.
-- JOIN: food_requests, foods, and users
SELECT
    fr.request_id,
    f.food_name,
    u.display_name AS requester_name,
    fr.requested_at,
    fr.status AS request_status
FROM food_requests AS fr
INNER JOIN foods AS f
    ON fr.food_id = f.food_id
INNER JOIN users AS u
    ON fr.requester_email = u.email;


-- READ 4: Find all food donations posted by a particular donor.
-- Replace the email with an existing user's email.
SELECT
    food_id,
    food_name,
    quantity,
    status
FROM foods
WHERE donor_email = 'donor@example.com';


-- READ 5: Count the total number of food donations.
SELECT COUNT(*) AS total_food_donations
FROM foods;


-- READ 6: Count food requests according to their status.
SELECT
    status,
    COUNT(*) AS total_requests
FROM food_requests
GROUP BY status;


-- READ 7: Display food donations ordered by nearest expiry date.
SELECT
    food_id,
    food_name,
    expiry_date,
    quantity
FROM foods
WHERE status = 'available'
ORDER BY expiry_date ASC;


-- =====================================================
-- END OF READ QUERIES
-- =====================================================

-- =====================================================
-- WRITE QUERIES
-- =====================================================


-- WRITE 1: Insert a new user.
INSERT INTO users (email, display_name, photo_url)
VALUES (
    'donor@example.com',
    'Demo Donor',
    'https://example.com/donor.jpg'
);


-- WRITE 2: Insert a new food donation.
INSERT INTO foods (
    donor_email,
    food_name,
    food_image,
    quantity,
    location,
    expiry_date,
    notes
)
VALUES (
    'donor@example.com',
    'Fresh Vegetables',
    'https://example.com/vegetables.jpg',
    5,
    'Sonipat',
    CURRENT_DATE + INTERVAL '2 days',
    'Freshly donated vegetables'
);


-- WRITE 3: Update the quantity of a food donation.
-- Replace 1 with an existing food_id.
UPDATE foods
SET quantity = 3
WHERE food_id = 1;


-- WRITE 4: Update the status of a food donation.
UPDATE foods
SET status = 'requested'
WHERE food_id = 1;


-- WRITE 5: Insert a food request.
-- Replace requester@example.com with an existing user's email.
-- Replace 1 with an existing food_id.
INSERT INTO food_requests (
    food_id,
    requester_email,
    notes
)
VALUES (
    1,
    'requester@example.com',
    'I would like to request this food donation.'
);


-- WRITE 6: Delete a food request.
-- Replace 2 with an existing request_id when testing.
DELETE FROM food_requests
WHERE request_id = 2;cd 
-- =====================================================
-- END OF WRITE QUERIES
-- =====================================================
