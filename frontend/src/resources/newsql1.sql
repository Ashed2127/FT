-- database name: "db_restaurant"
CREATE TABLE admin (
  admin_id INT(11) PRIMARY KEY AUTO_INCREMENT,
  admin_email varchar(255),
  admin_password VARCHAR(255)
)ENGINE=INNODB;

CREATE TABLE deliver_person (
  dp_id INT(11) PRIMARY KEY AUTO_INCREMENT,
  dp_email varchar(255),
  dp_password varchar(255)
)ENGINE=INNODB;

CREATE TABLE food( 
    food_id INT(11) PRIMARY KEY AUTO_INCREMENT, 
    food_name VARCHAR(255), 
    food_price VARCHAR(255),
    food_discount VARCHAR(255),
    food_desc VARCHAR(255),
    food_status VARCHAR(255),
    food_type VARCHAR(255),
    food_category VARCHAR(255),
    food_src VARCHAR(255)
) ENGINE=INNODB;
INSERT INTO food (food_name, food_price, food_discount, food_desc, food_status, food_type, food_category, food_src) 
VALUES 
("dulet", "165.00", "5.00", "Minced meat cooked with spices.", "Savory Tradition", "meat", "breakfast", "breakfast/taco-1.png"), 
("tibs", "185.00", "5.00", "Stir-fried meat with onions and tomatoes.", "Spice-infused Delight", "meat", "breakfast", "breakfast/taco-2.png"), 
("tibs-ferfer", "160.00", "10.00", "Spicy minced meat with onions and tomatoes.", "Savory Tradition", "meat", "breakfast", "breakfast/taco-3.png"), 
("special", "450.00", "50.00", "Custom recipe.", "Exclusively Exceptional", "meat", "lunch", "lunch/burrito-1.png"), 
("bozena-shiro", "180.00", "3.00", "Chickpea flour, onions, garlic, spices.", "Flavorful Elegance", "meat", "lunch", "lunch/burrito-2.png"), 
("fast shiro", "85.00", "5.00", "Chickpea flour, onions, garlic, spices.", "Quick and Delicious", "vegan", "lunch", "lunch/burrito-3.png"), 
("special pizza", "280.00", "10.00", "Dough, tomato sauce, cheese, toppings.", "Uniquely Irresistible", "meat", "dinner", "dinner/nachos-1.png"), 
("pasta-enkulal", "110.00", "10.00", "Pasta, garlic, olive oil, spices.", "Simply Tempting", "meat", "dinner", "dinner/nachos-2.png"), 
("shiro", "152.00", "2.00", "Chickpea flour, onions, garlic, spices.", "Ethiopian Delight", "meat", "dinner", "dinner/nachos-3.png"), 
("coffee", "24.00", "4.00", "Coffee beans, water, milk (optional), sugar.", "Awaken Your Senses", "vegan", "hot-drink", "hot-drink/side-1.png"), 
("macchiato", "35.00", "3.00", "Espresso, milk, foam.", "Indulge in Perfection", "meat", "hot-drink", "hot-drink/side-2.png"), 
("special milk", "38.00", "35.00", "Milk, flavorings.", "Creamy Delight", "vegan", "hot-drink", "hot-drink/side-3.png"), 
("Cake", "45.00", "5.00", "Flour, sugar, eggs, butter, flavorings.", "best seller", "vegan", "dessert", "dessert/dessert-1.png"), 
("bombolino", "40.00", "5.00", "Flour, sugar, yeast, oil, filling.", "A Burst of Joy", "vegan", "dessert", "dessert/dessert-2.png"), 
("Doughnut", "45.00", "5.00", "Flour, sugar, yeast, oil, glaze.","Irresistibly Sweet", "vegan", "dessert", "dessert/dessert-3.png"), 
("coca cola", "33.00", "3.00", "Carbonated water, sugar, flavorings.", "Classic Refreshment", "vegan", "soft-drink", "soft-drink/drink-1.png"), 
("ambo weeha", "33.00", "3.00", "Carbonated water, sugar, flavorings.", "Refreshing Bliss", "vegan", "soft-drink", "soft-drink/drink-2.png"), 
("pepsi", "33.00", "3.00", "Carbonated water, sugar, flavorings.", "Bold and Bubbly", "vegan", "soft-drink", "soft-drink/drink-3.png");



CREATE TABLE user( 
    user_id INT(11) PRIMARY KEY AUTO_INCREMENT, 
    user_fname VARCHAR(255),
    user_lname VARCHAR(255), 
    user_email VARCHAR(255),
    user_phone VARCHAR(255),
    user_password VARCHAR(255)
) ENGINE=INNODB;


CREATE TABLE cart (
  user_id INT,
  food_id INT,
  item_qty INT,
  primary key (user_id, food_id)
);


CREATE TABLE booktable( 
    book_id INT(11) PRIMARY KEY AUTO_INCREMENT, 
    book_name VARCHAR(255), 
    book_phone VARCHAR(255),
    book_people INT,
    book_tables INT,
    user_id INT(11) ,
    book_when VARCHAR(255),
    book_note TEXT,
    book_status int(11) 
) ENGINE=INNODB;


CREATE TABLE billdetails (
  bill_id INT,
  food_id INT,
  item_qty INT,
  primary key (bill_id, food_id)
);

CREATE TABLE billstatus (
  bill_id INT,
  user_id INT,
  deliverperson_id INT,
  bill_phone VARCHAR(255),
  bill_address TEXT,
  bill_when VARCHAR(255),
  bill_method VARCHAR(255),
  bill_discount INT,
  bill_delivery INT,
  bill_total INT,
  bill_paid VARCHAR(255),
  bill_status INT(11),
  primary key (bill_id)
);


CREATE TABLE languagestatus (
  lang_id INT(11) PRIMARY KEY AUTO_INCREMENT,
  langstatus INT CHECK (langstatus IN (0, 1))
);

INSERT INTO languagestatus (lang_id, langstatus) VALUES (1, 0);

-- ////////////////SQL////////////
-- // UPDATE YourTableName
-- // SET YourColumnName = 1
-- // WHERE YourCondition;


-- first user table modified by this sql
-- ALTER TABLE `user`
-- CHANGE COLUMN `user_name` `user_fname` VARCHAR(255),
-- ADD COLUMN `user_lname` VARCHAR(255) AFTER `user_fname`;
ALTER TABLE billstatus ADD COLUMN bill_food VARCHAR(255);

