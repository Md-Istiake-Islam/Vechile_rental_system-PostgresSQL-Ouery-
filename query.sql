--Query 1 Join

SELECT 
  b.booking_id,
  u.name AS customer_name,
  v.name AS vehicle_name
FROM bookings b
INNER JOIN users u
  ON b.user_id = u.user_id
INNER JOIN vehicles v
  ON b.vehicle_id = v.vehicle_id;


-- Query 2 

SELECT
  v.vehicle_id,
  v.name
FROM vehicles v
WHERE NOT EXISTS (
  SELECT 1
  FROM bookings b
  WHERE b.vehicle_id = v.vehicle_id
);


--query 3 where filter

SELECT
  vehicle_id,
  name,
  type,
  rental_price_per_day
FROM vehicles
WHERE availability_status = 'available'
  AND type = 'car';

--query 4 group by and having

SELECT
  v.vehicle_id,
  v.name,
  COUNT(b.booking_id) AS total_bookings
FROM vehicles v
LEFT JOIN bookings b
  ON v.vehicle_id = b.vehicle_id
GROUP BY
  v.vehicle_id,
  v.name
HAVING
  COUNT(b.booking_id) > 2;

