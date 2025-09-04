CREATE TABLE cuisine (
    cuisine_name VARCHAR(20) PRIMARY KEY
);

CREATE TABLE menu (
    item_name VARCHAR(20) PRIMARY KEY,
    price NUMERIC(8,2) NOT NULL CHECK (price >= 0),
    cuisine_name VARCHAR(20) NOT NULL,
    FOREIGN KEY (cuisine_name) REFERENCES cuisine(cuisine_name) ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE registration (
    reg_date DATE NOT NULL,
    reg_time TIME NOT NULL,
    member_phone VARCHAR(32) PRIMARY KEY,
    member_firstname VARCHAR(20) NOT NULL,
    member_lastname VARCHAR(20) NOT NULL
);

CREATE TABLE staff (
    staff_id VARCHAR(20) PRIMARY KEY,
    staff_name VARCHAR(20) NOT NULL
);

CREATE TABLE total_order (
    order_id VARCHAR(20) PRIMARY KEY,
    order_date DATE NOT NULL,
    order_time TIME NOT NULL,
    payment VARCHAR(20) NOT NULL CHECK (payment in ('card', 'cash')),
    card_number VARCHAR(20),
    card_type VARCHAR(20),
    member_phone VARCHAR(32),
    total_price NUMERIC(8,2) NOT NULL CHECK (total_price > 0),
    FOREIGN KEY (member_phone) REFERENCES registration(member_phone) ON DELETE RESTRICT ON UPDATE CASCADE,
    CHECK (
        (payment='cash'  AND card_number IS NULL AND card_type IS NULL) OR
        (payment='card'  AND card_number IS NOT NULL AND card_type IS NOT NULL)
    )
);

CREATE TABLE order_details (
    order_detail_id SERIAL PRIMARY KEY,
    parent_order_id VARCHAR(20) NOT NULL,
    item_name VARCHAR(20) NOT NULL,
    staff_id VARCHAR(20) NOT NULL,
    quantity INT NOT NULL CHECK (quantity >= 1),
    FOREIGN KEY (parent_order_id) REFERENCES total_order(order_id) ON DELETE CASCADE,
    FOREIGN KEY (item_name) REFERENCES menu(item_name) ON UPDATE CASCADE,
    FOREIGN KEY (staff_id) REFERENCES staff(staff_id)
);

CREATE TABLE staff_cuisine (
    staff_id VARCHAR(20) NOT NULL,
    cuisine_name VARCHAR(20) NOT NULL,
    FOREIGN KEY (staff_id) REFERENCES staff(staff_id) ON DELETE CASCADE,
    FOREIGN KEY (cuisine_name) REFERENCES cuisine(cuisine_name) ON DELETE CASCADE ON UPDATE CASCADE,
    PRIMARY KEY (staff_id, cuisine_name)
);


