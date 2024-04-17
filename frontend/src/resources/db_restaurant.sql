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
VALUES("dulet", "160.00", "0.00", "03 pieces per serving", "best seller", "meat", "breakfast", "breakfast/taco-1.png"),
("tibs","180.00", "3.00", "03 pieces per serving", "best seller", "meat", "breakfast", "breakfast/taco-2.png"),
("tibs-ferfer","150.00","0.00","03 pieces per serving","best seller","meat","breakfast","breakfast/taco-3.png"),
("enkulal-ferfer","80.00","2.00","03 pieces per serving","best seller","meat","breakfast","breakfast/taco-4.png"),
("chechebsa","90.00","0.00","03 pieces per serving","normal","meat","breakfast","breakfast/taco-5.png"),
("enkulal-sandwich","95.00","1.00","03 pieces per serving","new dishes","meat","breakfast","breakfast/taco-6.png"),
("chechebsa-special","100.00","2.00","03 pieces per serving","seasonal dishes online only","meat","breakfast","breakfast/taco-7.png"),
("tematem-silse","75.00","2.00","03 pieces per serving","new dishes","vegan","breakfast","breakfast/taco-8.png"),
("special","400.00","0.00","01 roll per serving","new dishes","meat","lunch","lunch/burrito-1.png"),
("bozena-shiro","180.00","3.00","01 roll per serving","best seller","meat","lunch","lunch/burrito-2.png"),
("fast shiro","80.00","0.00","01 roll per serving","best seller","vegan","lunch","lunch/burrito-3.png"),
("special-shiro","150.00","2.00","01 roll per serving","new dishes","meat","lunch","lunch/burrito-4.png"),
("burger","140.00","0.00","01 roll per serving","best seller","meat","lunch","lunch/burrito-5.png"),
("cheese-burger","170.00","2.00","01 roll per serving","seasonal dishes","meat","lunch","lunch/burrito-6.png"),
("pasta-besega","110.00","2.00","01 tray per serving","best seller","meat","dinner","dinner/nachos-1.png"),
("pasta-enkulal","100.00","0.00","01 tray per serving","best seller","meat","dinner","dinner/nachos-2.png"),
("shiro","150.00","2.00","01 tray per serving","best seller","meat","dinner","dinner/nachos-3.png"),
("chicken nachos","11.00","0.00","01 tray per serving","best seller","meat","dinner","dinner/nachos-4.png"),
("only nachos","7.00","2.00","01 tray per serving","normal","vegan","dinner","dinner/nachos-5.png"),
("pico de gallo","5.00","2.00","01 bowl per serving","best seller","vegan","dinner","dinner/salsa-1.png"),
("salsa guille","5.00","2.00","01 bowl per serving","best seller","vegan","dinner","dinner/salsa-2.png"),
("tomatillo salsa","5.00","2.00","01 bowl per serving","seasonal dishes","vegan","dinner","dinner/salsa-3.png"),
("roasted tomato salsa","5.00","2.00","01 bowl per serving","best seller","vegan","dinner","dinner/salsa-4.png"),
("guacamole","5.00","2.00","01 bowl per serving","best seller","vegan","dinner","dinner/salsa-5.png"),
("corn salad","5.00","1.00","01 bowl per serving","new dishes seasonal dishes","vegan","hot-drink","hot-drink/side-1.png"),
("keto taquitos","9.00","0.00","05 pieces per serving","best seller","meat","hot-drink","hot-drink/side-2.png"),
("mexican rice","5.00","0.00","01 bowl per serving","normal","vegan","hot-drink","hot-drink/side-3.png"),
("cilantro lime rice","5.00","0.00","01 bowl per serving","new dishes","vegan","hot-drink","hot-drink/side-4.png"),
("chicken tortilla soup","10.00","2.00","01 bowl per serving","new dishes","meat","hot-drink","hot-drink/side-5.png"),
("Churros","7.00","0.00","05 pieces per serving","best seller","vegan","dessert","dessert/dessert-1.png"),
("Fried Ice Cream","5.00","1.00","01 piece per serving","best seller","vegan","dessert","dessert/dessert-2.png"),
("Dulce de Leche","4.00","0.00","01 bowl per serving","new dishes","vegan","dessert","dessert/dessert-3.png"),
("Sweet Corn Cake","4.00","1.00","02 pieces per serving","seasonal dishes online only","vegan","dessert","dessert/dessert-4.png"),
("Sopapillas","4.00","0.00","10 pieces per serving","normal","vegan","dessert","dessert/dessert-5.png"),
("Conchas","5.00","0.00","10 pieces per serving","normal","vegan","dessert","dessert/dessert-6.png"),
("Horchata","4.00","0.00","01 glass per serving","normal","vegan","dessert","dessert/dessert-7.png"),
("Margarita","5.00","0.00","01 glass per serving","best seller","vegan","soft-drink","soft-drink/drink-1.png"),
("Michelada","5.00","0.00","01 glass per serving","best seller","vegan","soft-drink","soft-drink/drink-2.png"),
("paloma","5.00","0.00","01 glass per serving","new dishes seasonal dishes","vegan","soft-drink","soft-drink/drink-3.png"),
("Atole","5.00","1.00","01 glass per serving","best seller","vegan","soft-drink","soft-drink/drink-4.png"),
("fruit detox","3.00","0.00","01 glass per serving","seasonal dishes best seller","vegan","soft-drink","soft-drink/drink-5.png"),
("Coca cola","3.00","0.00","01 glass per serving","best seller","vegan","soft-drink","soft-drink/drink-6.png"); 


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

