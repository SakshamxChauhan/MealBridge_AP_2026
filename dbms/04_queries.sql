SET search_path TO mealbridge_ap;

-- Q01: Available food listings filtered by city
SELECT fl.listing_id, fl.food_item, fl.quantity_kg, u.full_name AS donor, u.city
FROM food_listings fl
JOIN users u ON fl.donor_id = u.user_id
WHERE fl.status = 'AVAILABLE' AND u.city = 'Sonipat'
ORDER BY fl.created_at DESC
LIMIT 20;

-- Q02: Top donors leaderboard by total quantity donated
SELECT u.user_id, u.full_name, u.city, COUNT(fl.listing_id) AS total_donations, SUM(fl.quantity_kg) AS total_kg
FROM users u
JOIN food_listings fl ON u.user_id = fl.donor_id
WHERE fl.status IN ('CLAIMED', 'DELIVERED')
GROUP BY u.user_id, u.full_name, u.city
ORDER BY total_kg DESC
LIMIT 10;

-- Q03: Recipient claim and delivery history
SELECT c.claim_id, fl.food_item, fl.quantity_kg, c.claimed_at, c.pickup_status, dl.delivered_at
FROM claims c
JOIN food_listings fl ON c.listing_id = fl.listing_id
LEFT JOIN delivery_logs dl ON c.claim_id = dl.claim_id
WHERE c.recipient_id = 101
ORDER BY c.claimed_at DESC;

-- Q04: City-wise redistribution analytics
SELECT u.city, fl.category, COUNT(*) AS listings_count, ROUND(AVG(fl.quantity_kg), 2) AS avg_kg
FROM food_listings fl
JOIN users u ON fl.donor_id = u.user_id
GROUP BY u.city, fl.category
ORDER BY u.city, listings_count DESC;
