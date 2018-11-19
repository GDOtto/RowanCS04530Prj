/*
Recipe API DB
CS-4530
*/

DROP TABLE IF EXISTS `recipes` ;
DROP TABLE IF EXISTS `ingredients` ;
DROP TABLE IF EXISTS `directions` ;
DROP TABLE IF EXISTS `nutrition` ;
DROP TABLE IF EXISTS `shopping` ;

CREATE TABLE recipes
(
  recipeID	INT	PRIMARY KEY   AUTO_INCREMENT,
  name		VARCHAR(50)     NOT NULL,
  servings	VARCHAR(50)     NOT NULL,
  category	VARCHAR(50)     NOT NULL,
  style		VARCHAR(50)     NOT NULL,
  time		INT	0
);

CREATE TABLE ingredients
(
  ingredientID		INT	PRIMARY KEY	AUTO_INCREMENT,
  recipeID		INT,
  qty			INT,
  CONSTRAINT `RecipeID`
    FOREIGN KEY (`RecipeID`)
    REFERENCES `recipes` (`RecipeID`)
);

CREATE TABLE directions
(
  recipeID	INT,
  step		INT		1,
  direction	VARCHAR(200)	NOT NULL,
  CONSTRAINT `RecipeID`
    FOREIGN KEY (`RecipeID`)
    REFERENCES `recipes` (`RecipeID`)
);

CREATE TABLE nutrition
(
  ingredientID	INT,
  name		VARCHAR(75)	NOT NULL,
  qty		INT	0,
  calories	INT	0,
  fat		INT	0,
  carb		INT	0,
  fiber		INT	0,
  sugar		INT	0,
  CONSTRAINT `ingredientID`
    FOREIGN KEY (`ingredientID`)
    REFERENCES `ingredients` (`ingredientID`)
);

CREATE TABLE shoppinh
(
  ingredientID	INT,
  qty		INT	0,
  store		VARCHAR(0)	NOT NULL,
  price		DOUBLE	0,
  CONSTRAINT `ingredientID`
    FOREIGN KEY (`ingredientID`)
    REFERENCES `ingredients` (`ingredientID`)
);