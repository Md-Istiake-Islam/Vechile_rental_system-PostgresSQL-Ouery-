# 🚗 Vehicle Rental System – PostgreSQL SQL Queries

## Project Overview
The Vehicle Rental System manages users, vehicles, and bookings.  
It ensures **data integrity** using primary keys, foreign keys, and proper relationships.

Key features:

- Users (customers) management  
- Vehicles inventory management  
- Bookings management  

Each booking **logically connects exactly one user and one vehicle**.

---

## Database Schema

**Tables:**

1. **users** – stores customer information  
   - Primary Key: `user_id`

2. **vehicles** – stores vehicle details  
   - Primary Key: `vehicle_id`  
   - Column `name` stores vehicle name

3. **bookings** – stores rental bookings  
   - Primary Key: `booking_id`  
   - Foreign Keys:  
     - `user_id` → `users(user_id)`  
     - `vehicle_id` → `vehicles(vehicle_id)`  
   - Columns: `date`, `booking_status`

**Relationships:**

- Users → Bookings = One to Many  
- Vehicles → Bookings = One to Many  
- Logical One-to-One per booking: each booking row connects exactly one user and one vehicle

- Here is All Queries with Detailed Explanations


**Query 1: Bookings with Customer & Vehicle Names**

-SELECT 
  -b.booking_id,
  -u.name AS customer_name,
  -v.name AS vehicle_name
-FROM bookings b
-INNER JOIN users u
  -ON b.user_id = u.user_id
-INNER JOIN vehicles v
  -ON b.vehicle_id = v.vehicle_id;

- Explanation:
- This query retrieves all bookings with readable information about the customer and vehicle.
- 1. 'b.booking_id' comes from the bookings table to identify each booking.
- 2. 'u.name AS customer_name' retrieves the customer's name from the users table by matching b.user_id = u.user_id.
- 3. 'v.name AS vehicle_name' retrieves the vehicle's name from the vehicles table by matching b.vehicle_id = v.vehicle_id.
- Purpose: Instead of showing only IDs, this query provides meaningful names for reporting or display.


** Query 2: Vehicles Never Booked

-SELECT
  -v.vehicle_id,
  -v.name AS vehicle_name
-FROM vehicles v
-WHERE NOT EXISTS (
  -SELECT 1
  -FROM bookings b
  -WHERE b.vehicle_id = v.vehicle_id
-);

- Explanation:
- This query identifies vehicles that have never been booked.
- 1. The subquery checks the bookings table for any booking with the current vehicle_id.
- 2. 'NOT EXISTS' ensures that only vehicles with no corresponding booking are returned.
- Purpose: Useful for finding unused vehicles or vehicles that may need promotion or maintenance.


** Query 3: Available Vehicles of a Specific Type

-SELECT
  -vehicle_id,
  -name AS vehicle_name,
  -vehicle_type,
  -rental_price
-FROM vehicles
-WHERE availability_status = 'available'
  -AND vehicle_type = 'car';

- Explanation:
- This query filters vehicles based on availability and type.
- 1. 'availability_status = available' ensures that only vehicles ready for rent are included.
- 2. 'vehicle_type = car' further filters for a specific category.
- Purpose: Allows customers or staff to find vehicles of a specific type that are currently available for rental.


** Query 4: Vehicles with More Than 2 Bookings

-SELECT
  -v.vehicle_id,
  -v.name AS vehicle_name,
  -COUNT(b.booking_id) AS total_bookings
-FROM vehicles v
-LEFT JOIN bookings b
  -ON v.vehicle_id = b.vehicle_id
-GROUP BY
  -v.vehicle_id,
  -v.name
-HAVING
  -COUNT(b.booking_id) > 2;

- Explanation:
- This query identifies vehicles that have been booked more than twice.
- 1. 'LEFT JOIN' ensures that all vehicles are included, even if they have zero bookings.
- 2. 'COUNT(b.booking_id)' counts how many bookings each vehicle has.
- 3. 'GROUP BY' groups the results by vehicle to calculate counts correctly.
- 4. 'HAVING COUNT(...) > 2' filters only vehicles with more than 2 bookings.
- Purpose: Useful for analytics, reporting popular vehicles, or making business decisions about inventory.
