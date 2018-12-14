CREATE OR REPLACE VIEW `food`.`recipe_nutrients` AS
    SELECT 
        `groupednutrients`.`recipeID` AS `recipeID`,
        `groupednutrients`.`recipeName` AS `recipeName`,
        FORMAT(`groupednutrients`.`calories`, 0) AS `calories per recipe`,
        FORMAT(`groupednutrients`.`caloriesperserving`,
            0) AS `calories per serving`,
        CONCAT(CAST(FORMAT(`groupednutrients`.`fat`, 2) AS CHAR CHARSET UTF8),
                'g') AS `fat per serving`,
        CONCAT(CAST(FORMAT(`groupednutrients`.`carbs`, 2) AS CHAR CHARSET UTF8),
                'g') AS `carbs per serving`,
        CONCAT(CAST(FORMAT(`groupednutrients`.`fiber`, 2) AS CHAR CHARSET UTF8),
                'g') AS `fiber per serving`,
        CONCAT(CAST(FORMAT(`groupednutrients`.`protein`, 2) AS CHAR CHARSET UTF8),
                'g') AS `protein per serving`
    FROM
        (SELECT 
            `r`.`recipeID` AS `recipeID`,
                `r`.`recipeName` AS `recipeName`,
                SUM(`n`.`calories`) AS `calories`,
                SUM((`n`.`calories` / CAST(`r`.`servings` AS DECIMAL (10 , 0 )))) AS `caloriesperserving`,
                SUM((`n`.`fat`/ CAST(`r`.`servings` AS DECIMAL (10 , 0 )))) AS `fat`,
                SUM((`n`.`carbs`/ CAST(`r`.`servings` AS DECIMAL (10 , 0 )))) AS `carbs`,
                SUM((`n`.`fiber`/ CAST(`r`.`servings` AS DECIMAL (10 , 0 )))) AS `fiber`,
                SUM((`n`.`protein`/ CAST(`r`.`servings` AS DECIMAL (10 , 0 )))) AS `protein`
        FROM
            ((`food`.`recipes` `r`
        JOIN `food`.`ingredients` `i`)
        JOIN `food`.`nutrients` `n`)
        WHERE
            ((`r`.`recipeID` = `i`.`recipeID`)
                AND (`i`.`nutrientID` = `n`.`nutrientID`))
        GROUP BY `r`.`recipeName`) `groupednutrients`;

#SELECT * FROM food.recipe_nutrients;