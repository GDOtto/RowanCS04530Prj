
#Recipe API DB
#CS-4CREATE DATABASE `food` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */;

#DROP database Food;
#CREATE database food;

USE food;

DROP TABLE IF EXISTS `shopping` ;
DROP TABLE IF EXISTS `ingredients` ;
DROP TABLE IF EXISTS `nutrients` ;
DROP TABLE IF EXISTS `recipes` ;

CREATE TABLE recipes
(
  recipeID		INT	PRIMARY KEY AUTO_INCREMENT,
  recipeName	VARCHAR(50) NOT NULL,
  servings		VARCHAR(50) NOT NULL,
  diet			VARCHAR(50) NOT NULL
);

CREATE TABLE ingredients
(
  nutrientID  	INT REFERENCES nutrients(nutrientID),
  recipeID	  	INT REFERENCES recipes(recipeID),
  foodQty     	DOUBLE
);

CREATE TABLE nutrients
(
  nutrientID	INT	PRIMARY KEY	AUTO_INCREMENT,
  foodName		VARCHAR(75)	NOT NULL,
  calories		DOUBLE,
  fat			DOUBLE,
  carbs			DOUBLE,
  fiber			DOUBLE,
  protein		DOUBLE,
  UPC			VARCHAR(12)
);

CREATE TABLE shopping
(
  UPC   VARCHAR(12) PRIMARY KEY,
  size  DOUBLE,
  price	DOUBLE
);
