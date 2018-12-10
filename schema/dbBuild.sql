/*
Recipe API DB
CS-4530

DROP database Food;
CREATE database food;

*/
use food;


DROP TABLE IF EXISTS `recipes` ;
DROP TABLE IF EXISTS `ingredients` ;
DROP TABLE IF EXISTS `nutrition` ;
DROP TABLE IF EXISTS `shopping` ;


CREATE TABLE recipes
(
  recipeID	INT	PRIMARY KEY   AUTO_INCREMENT,
  RecName		VARCHAR(50)     NOT NULL,
  servings	VARCHAR(50)     NOT NULL,
  diet	VARCHAR(50)     NOT NULL
);

CREATE TABLE ingredients
(
  nutritiantID		INT,
  recipeID		INT,
  qty			double
);

CREATE TABLE nutritiant
(
  nutritiantID	INT	PRIMARY KEY	AUTO_INCREMENT,
  FoodName		VARCHAR(75)	NOT NULL,
  calories	double,
  fat		double,
  carb		double,
  fiber		double,
  protein	double,
  UPC		varchar(12)
);

CREATE TABLE shopping
(
  UPC		varchar(12) PRIMARY KEY,
  qty		double,
  price		double
);