
#Recipe API DB
#CS-4530

#DROP database Food;
#CREATE database food;


USE food;

DROP TABLE IF EXISTS `shopping` ;
DROP TABLE IF EXISTS `ingredients` ;
DROP TABLE IF EXISTS `nutrition` ;
DROP TABLE IF EXISTS `directions` ;
DROP TABLE IF EXISTS `recipes` ;


CREATE TABLE recipes
(
  recipeID	INT	PRIMARY KEY   AUTO_INCREMENT,
  name		VARCHAR(50)     NOT NULL,
  servings	VARCHAR(50)     NOT NULL,
  category	VARCHAR(50)     NOT NULL,
  style		VARCHAR(50)     NOT NULL,
  time		INT
);

CREATE TABLE nutrition
(
  ingredientID	INT PRIMARY KEY AUTO_INCREMENT,
  name			VARCHAR(75)	NOT NULL,
  Energy_kcal	DOUBLE,
  Carbs_g		DOUBLE,
  Fat_g			DOUBLE,
  Fiber_g		DOUBLE,
  Protien_g		DOUBLE
);

CREATE TABLE ingredients
(
  ingredientID	INT,
  recipeID		INT,
  qty			FLOAT,
  CONSTRAINT `RecipeID`
    FOREIGN KEY (`RecipeID`)
    REFERENCES `recipes` (`RecipeID`),
  CONSTRAINT `ingredientID`
    FOREIGN KEY (`ingredientID`)
    REFERENCES `nutrition` (`ingredientID`)
);

CREATE TABLE directions
(
  recipeID	INT,
  step		INT,
  direction	VARCHAR(200)	NOT NULL,
  CONSTRAINT `RecipeID2`
    FOREIGN KEY (`RecipeID`)
    REFERENCES `recipes` (`RecipeID`)
);


CREATE TABLE shopping
(
  ingredientID	INT,
  qty			INT,
  store			VARCHAR(0)	NOT NULL,
  price			DOUBLE,
  CONSTRAINT `ingredientID2`
    FOREIGN KEY (`ingredientID`)
    REFERENCES `ingredients` (`ingredientID`)
);