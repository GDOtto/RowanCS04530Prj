
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
  RecName		VARCHAR(50)     NOT NULL,
  servings	VARCHAR(50)     NOT NULL,
  diet	VARCHAR(50)     NOT NULL
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
<<<<<<< HEAD
  ingredientID	INT,
  recipeID		INT,
  qty			FLOAT,
  CONSTRAINT `RecipeID`
    FOREIGN KEY (`RecipeID`)
    REFERENCES `recipes` (`RecipeID`),
  CONSTRAINT `ingredientID`
    FOREIGN KEY (`ingredientID`)
    REFERENCES `nutrition` (`ingredientID`)
=======
  nutritiantID		INT,
  recipeID		INT,
  qty			double
>>>>>>> 84acf03b933baaf98e1f7a21a3f62e1e4d38f90c
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

<<<<<<< HEAD

CREATE TABLE shopping
(
  ingredientID	INT,
  qty			INT,
  store			VARCHAR(0)	NOT NULL,
  price			DOUBLE,
  CONSTRAINT `ingredientID2`
    FOREIGN KEY (`ingredientID`)
    REFERENCES `ingredients` (`ingredientID`)
=======
CREATE TABLE shopping
(
  UPC		varchar(12) PRIMARY KEY,
  qty		double,
  price		double
>>>>>>> 84acf03b933baaf98e1f7a21a3f62e1e4d38f90c
);