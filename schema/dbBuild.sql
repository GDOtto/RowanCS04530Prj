
#Recipe API DB
#CS-4530

#DROP database Food;
#CREATE database food;

USE food;

DROP TABLE IF EXISTS `shopping` ;
DROP TABLE IF EXISTS `ingredients` ;
DROP TABLE IF EXISTS `nutrients` ;
DROP TABLE IF EXISTS `recipes` ;

CREATE TABLE recipes
(
  recipeID	  INT	PRIMARY KEY AUTO_INCREMENT,
  recipeName	VARCHAR(50) NOT NULL,
  servings	  VARCHAR(50) NOT NULL,
  diet	      VARCHAR(50) NOT NULL
);

CREATE TABLE ingredients
(
  nutrientID  INT,
  recipeID	  INT,
  foodQty     DOUBLE
);

CREATE TABLE nutrients
(
  nutrientID  	INT	PRIMARY KEY	AUTO_INCREMENT,
  foodName		  VARCHAR(75)	NOT NULL,
  calories	    DOUBLE,
  fat		        DOUBLE,
  carbs		      DOUBLE,
  fiber		      DOUBLE,
  protein	      DOUBLE,
  UPC		        VARCHAR(12)
);

CREATE TABLE shopping
(
  UPC   VARCHAR(12) PRIMARY KEY,
  size  DOUBLE,
  price	DOUBLE
);
