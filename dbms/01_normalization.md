# MealBridge Database Normalization (1NF to 3NF) - CP1

## 1. Functional Dependencies & Decomposition
- **1NF**: Eliminated multi-valued food attributes and ensured atomic fields across `users`, `food_listings`, `claims`, and `delivery_logs`.
- **2NF**: Removed partial dependencies by separating donor/recipient profile attributes (`full_name`, `email`, `city`, `capacity`) into `users` (`user_id` PK) rather than repeating them in `food_listings` or `claims`.
- **3NF**: Removed transitive dependencies (`claim_id -> listing_id -> donor_id -> city`) so every non-key attribute depends solely on its table's primary key.

## 2. Normalized Tables (3NF)
1. `users(user_id PK, full_name, email UNIQUE, role, city, capacity, created_at)`
2. `food_listings(listing_id PK, donor_id FK, food_item, category, quantity_kg, status, created_at, expires_at)`
3. `claims(claim_id PK, listing_id FK UNIQUE, recipient_id FK, claimed_at, pickup_status)`
4. `delivery_logs(log_id PK, claim_id FK UNIQUE, verified_by, delivered_at, notes)`
