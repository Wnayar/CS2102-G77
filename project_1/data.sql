BEGIN;
DROP TABLE IF EXISTS stg_menu, stg_registration, stg_staff, stg_order, cuisine, menu, registration, staff, staff_cuisine, total_order, order_details CASCADE;

CREATE TABLE stg_menu (
  item text,
  price text,
  cuisine text
);

CREATE TABLE stg_registration (
  reg_date text,
  reg_time text,
  phone text,
  firstname text,
  lastname text
);

CREATE TABLE stg_staff (
  staff_id text,
  staff_name text,
  cuisine text
);

CREATE TABLE stg_order (
  ord_date text,
  ord_time text,
  order_id text,
  payment text,
  card_number text,
  card_type text,
  item text,
  total_price text,
  phone text,
  firstname text,
  lastname text,
  staff_id text,
  lineno BIGSERIAL
);

-- Load CSVs (psql-only)
\copy stg_menu        FROM 'menu.csv'        WITH (FORMAT csv, HEADER true);
\copy stg_registration FROM 'registration.csv' WITH (FORMAT csv, HEADER true);
\copy stg_staff       FROM 'staff.csv'       WITH (FORMAT csv, HEADER true);
\copy stg_order       FROM 'order.csv'       WITH (FORMAT csv, HEADER true);


-- populate cuisine table with distinct values 
INSERT INTO cuisine (cuisine_name)
SELECT DISTINCT cuisine
FROM stg_menu;

-- populate menu
INSERT INTO menu (item_name, price, cuisine_name)
SELECT item, price::NUMERIC(8,2), cuisine
FROM stg_menu;

-- populate registration (members)
INSERT INTO registration (reg_date, reg_time, member_phone,
    member_firstname, member_lastname)
SELECT reg_date::DATE, reg_time::TIME, phone,
    firstname, lastname
FROM stg_registration;

-- populate staff
INSERT INTO staff (staff_id, staff_name)
SELECT DISTINCT ON (staff_id) staff_id, staff_name
FROM stg_staff
ORDER BY staff_id, staff_name;

-- populate staff_cuisine
INSERT INTO staff_cuisine (staff_id, cuisine_name)
SELECT DISTINCT staff_id, cuisine
FROM stg_staff;

-- populate total_order (first 100 rows of order.csv)
INSERT INTO total_order (order_id, order_date, order_time,
    payment, card_number, card_type, total_price,
    member_phone)
SELECT DISTINCT ON (s.order_id) 
    s.order_id, s.ord_date::DATE, s.ord_time::TIME, 
    s.payment, NULLIF(s.card_number, ''), NULLIF(s.card_type, ''), 
    s.total_price::NUMERIC(8,2), NULLIF(s.phone, '')
FROM (
    SELECT *, ROW_NUMBER() OVER () AS lineno
    FROM stg_order
) AS s
WHERE s.lineno <= 100
ORDER BY s.order_id, s.lineno;

-- populate order_details (first 100 rows of order.csv)
INSERT INTO order_details (item_name, staff_id, parent_order_id, quantity)
SELECT s.item, s.staff_id, s.order_id, COUNT(*)::int
FROM (
    SELECT *, ROW_NUMBER() OVER () AS lineno
    FROM stg_order
) AS s
WHERE s.lineno <= 100
GROUP BY s.order_id, s.item, s.staff_id;


-- drop staging tables 
DROP TABLE stg_menu;
DROP TABLE stg_registration;
DROP TABLE stg_staff;
DROP TABLE stg_order;

-- query number of rows from total_order 
SELECT COUNT(*) AS TOTAL_ORDERS
FROM total_order;