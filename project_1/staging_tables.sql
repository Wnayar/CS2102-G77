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
  staff_id text
);

-- Load CSVs (psql-only)
\copy stg_menu        FROM 'menu.csv'        WITH (FORMAT csv, HEADER true);
\copy stg_registration FROM 'registration.csv' WITH (FORMAT csv, HEADER true);
\copy stg_staff       FROM 'staff.csv'       WITH (FORMAT csv, HEADER true);
\copy stg_order       FROM 'order.csv'       WITH (FORMAT csv, HEADER true);