# Project Requirements Document

## Tables
1. menu 
    - item_name: VARCHAR (PK)
    - price: DECIMAL(8,2) (NOT NULL)
    - cuisine_name (FK -> CUISINE)

2. registration
    - reg_date: DATE
    - reg_time: TIME
    - member_phone: VARCHAR (PK)
    - member_firstname: VARCHAR 
    - member_lastname: VARCHAR

3. staff
    - staff_id: VARCHAR (PK)
    - staff_name: VARCHAR

4. order
    - order_id: VARCHAR (PK)
    - date: DATE
    - time: TIME
    - payment: VARCHAR ('card','cash')
    - card: VARCHAR
    - card_type: VARCHAR (ONLY CERTAIN ORGANIZATIONS?) (If payment='card': card and card_type NOT NULL. If payment='cash': both NULL.)
    - total_price: DECIMAL(8,2) (CHECKS if member and item_count ≥ 4, $2 off total vs menu sum) (NOT NULL)
    - member_phone: VARCHAR (nullable FK -> REGISTRATION)

5. order_details:
    - order_detail_id (PK)
    - order_id (FK -> ORDER)
    - item (FK -> MENU)
    - staff_id (FK -> STAFF) ((staff_id, Menu.cuisine_name) must exist in StaffCuisine)
    - quantity: INT (quantity >= 1)

6. cuisine:
    - cuisine_name: VARCHAR (PK)

7. staff_cuisine:
    - staff_id (FK -> STAFF)
    - cuisine_name: (FK -> CUISINE)
    PRIMARY KEY (staff_id, cuisine_name)