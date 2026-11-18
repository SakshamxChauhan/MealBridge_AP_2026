# MealBridge Database Normalization

## 1. Introduction

MealBridge is a food donation platform that connects food donors with people who need food. Donors can add food details, while other users can browse available food and submit food requests.

Database normalization is the process of organizing data into well-structured tables to reduce data redundancy and prevent insertion, update, and deletion anomalies.

For this project, we use PostgreSQL as the relational database management system.

### Objectives of Normalization

- Reduce duplicate data.
- Maintain data consistency.
- Avoid insertion anomalies.
- Avoid update anomalies.
- Avoid deletion anomalies.
- Establish relationships between tables using primary keys and foreign keys.

## 2. Understanding the Original Data

Based on the MealBridge frontend, the application handles two main types of information:

**Food information:**
- Food name
- Food image
- Quantity
- Location
- Expiry date
- Notes
- Donor information
- Food status

**Food request information:**
- Food ID
- Food name
- Food image
- Donor email
- Requesting user's email
- Request time
- Location
- Expiry date
- Notes
- Request status

If all this information is stored in one large table, donor details and food details may be repeated for multiple records.

To avoid this, we divide the data into related tables.

## 3. First Normal Form (1NF)

### Definition

A table is in First Normal Form (1NF) when:

1. Each column contains atomic (single) values.
2. Each row is uniquely identifiable.
3. There are no repeating groups or multi-valued columns.

### Example: Before 1NF

Consider an unnormalized food donation record:

| donor_email | donor_name | food_names |
|---|---|---|
| donor1@example.com | Rahul | Rice, Bread, Milk |

The `food_names` column contains multiple values in one cell. This violates the atomic-value requirement.

### Conversion into 1NF

We store each food item in a separate row.

| food_id | donor_email | donor_name | food_name |
|---|---|---|---|
| 101 | donor1@example.com | Rahul | Rice |
| 102 | donor1@example.com | Rahul | Bread |
| 103 | donor1@example.com | Rahul | Milk |

Now every cell contains a single value, and every row can be identified using `food_id`.

**Result:** The table satisfies 1NF.

## 4. Second Normal Form (2NF)

### Definition

A table is in Second Normal Form (2NF) when:

1. It is already in 1NF.
2. Every non-key attribute depends on the entire candidate key, not just a part of a composite candidate key.

This eliminates partial dependencies.

### Example: Before 2NF

Consider a food request table with a composite primary key `(food_id, requester_email)`.

| food_id | requester_email | food_name | requester_name | request_status |
|---|---|---|---|---|
| 101 | user1@example.com | Rice | Aman | requested |
| 102 | user2@example.com | Bread | Priya | requested |

Functional dependencies:

- `food_id → food_name`
- `requester_email → requester_name`
- `(food_id, requester_email) → request_status`

Here, `food_name` depends only on `food_id`, and `requester_name` depends only on `requester_email`, rather than the entire composite key.

These are partial dependencies.

### Conversion into 2NF

We separate the information into three tables.

**Foods**

| food_id | food_name |
|---|---|
| 101 | Rice |
| 102 | Bread |

**Users**

| email | name |
|---|---|
| user1@example.com | Aman |
| user2@example.com | Priya |

**Food Requests**

| request_id | food_id | requester_email | request_status |
|---|---|---|---|
| 1 | 101 | user1@example.com | requested |
| 2 | 102 | user2@example.com | requested |

Now food details depend on the food key, user details depend on the user key, and request status depends on the request record.

**Result:** The decomposition removes the partial dependencies and satisfies 2NF.

## 5. Third Normal Form (3NF)

### Definition

A table is in Third Normal Form (3NF) when:

1. It is already in 2NF.
2. No non-key attribute has a transitive dependency on the primary key through another non-key attribute.

In simple words, non-key attributes should depend on the key, the whole key, and nothing but the key.

### Example: Before 3NF

Consider the following table:

| food_id | donor_email | donor_name | donor_photo | food_name |
|---|---|---|---|---|
| 101 | donor1@example.com | Rahul | rahul.jpg | Rice |
| 102 | donor1@example.com | Rahul | rahul.jpg | Bread |

Functional dependencies:

- `food_id → donor_email, food_name`
- `donor_email → donor_name, donor_photo`

Therefore:

`food_id → donor_email → donor_name, donor_photo`

Donor details depend on `donor_email`, not directly on the food's identity. This creates a transitive dependency.

### Conversion into 3NF

We separate user information from food information.

**Users**

| email | display_name | photo_url |
|---|---|---|
| donor1@example.com | Rahul | rahul.jpg |

**Foods**

| food_id | donor_email | food_name |
|---|---|---|
| 101 | donor1@example.com | Rice |
| 102 | donor1@example.com | Bread |

**Food Requests**

| request_id | food_id | requester_email | requested_at | status |
|---|---|---|---|---|
| 1 | 101 | user1@example.com | 2026-11-18 10:00:00 | requested |

Now donor information is maintained in one place, and food records reference the donor through a foreign key.

**Result:** The transitive dependency is removed, satisfying 3NF.

## 6. Final Normalized Database Design

The proposed MealBridge database contains three main tables.

### 6.1 Users Table

Stores application user references and profile information.

| Column | Description |
|---|---|
| email (PK) | Unique user email |
| display_name | User's display name |
| photo_url | User profile image URL |

Firebase Authentication handles login and password management. This table is a relational reference to application users, not a replacement for Firebase authentication.

### 6.2 Foods Table

Stores food donation information.

| Column | Description |
|---|---|
| food_id (PK) | Unique food identifier |
| donor_email (FK) | References users.email |
| food_name | Name of donated food |
| food_image | Image URL |
| quantity | Available quantity |
| location | Food collection location |
| expiry_date | Food expiry date |
| notes | Additional information |
| status | Food availability status |

### 6.3 Food Requests Table

Stores food request information.

| Column | Description |
|---|---|
| request_id (PK) | Unique request identifier |
| food_id (FK) | References foods.food_id |
| requester_email (FK) | References users.email |
| requested_at | Date and time of request |
| notes | Requester's message |
| status | Request status |

Food name, donor email, image and other food details can be retrieved through JOIN operations instead of storing duplicate copies in every request.

## 7. Benefits of Normalization in MealBridge

1. **Reduced redundancy:** Donor information is stored once in the Users table.
2. **Better consistency:** Updating a user's profile does not require updating every food record.
3. **Data integrity:** Foreign keys maintain valid relationships between users, foods and requests.
4. **Easy maintenance:** Each table represents a specific entity.
5. **Efficient querying:** Related information can be retrieved using SQL JOIN operations.
6. **Fewer anomalies:** Separating entities reduces insertion, update and deletion anomalies.

## 8. Conclusion

The MealBridge database is designed using the principles of 1NF, 2NF and 3NF.

The proposed normalized design separates users, food donations and food requests into three related tables. This structure reduces redundant data, improves consistency and maintains referential integrity.

PostgreSQL will be used to implement the relational schema using primary keys, foreign keys, appropriate data types and constraints.

---

**Design note:** The frontend uses Firebase Authentication and sends food/request data to a separate API. The PostgreSQL schema in this assignment is a proposed relational database design based on the verified frontend requirements; it does not claim that the existing deployed API already uses PostgreSQL.