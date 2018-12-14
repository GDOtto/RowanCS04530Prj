CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`localhost` 
    SQL SECURITY DEFINER
VIEW `food`.`recipe_nutrients` AS
    SELECT 
        `groupednutrients`.`recipeID` AS `recipeID`,
        `groupednutrients`.`recipeName` AS `recipeName`,
        FORMAT(`groupednutrients`.`calories`, 0) AS `calories`,
        FORMAT(`groupednutrients`.`caloriesperserving`,
            0) AS `calories per serving`,
        CONCAT(CAST(FORMAT(`groupednutrients`.`fat`, 2) AS CHAR CHARSET UTF8),
                'g') AS `fat`,
        CONCAT(CAST(FORMAT(`groupednutrients`.`carbs`, 2) AS CHAR CHARSET UTF8),
                'g') AS `carbs`,
        CONCAT(CAST(FORMAT(`groupednutrients`.`fiber`, 2) AS CHAR CHARSET UTF8),
                'g') AS `fiber`,
        CONCAT(CAST(FORMAT(`groupednutrients`.`protein`, 2) AS CHAR CHARSET UTF8),
                'g') AS `protein`
    FROM
        (SELECT 
            `r`.`recipeID` AS `recipeID`,
                `r`.`recipeName` AS `recipeName`,
                SUM(`n`.`calories`) AS `calories`,
                SUM((`n`.`calories` / CAST(`r`.`servings` AS DECIMAL (10 , 0 )))) AS `caloriesperserving`,
                SUM(`n`.`fat`) AS `fat`,
                SUM(`n`.`carbs`) AS `carbs`,
                SUM(`n`.`fiber`) AS `fiber`,
                SUM(`n`.`protein`) AS `protein`
        FROM
            ((`food`.`recipes` `r`
        JOIN `food`.`ingredients` `i`)
        JOIN `food`.`nutrients` `n`)
        WHERE
            ((`r`.`recipeID` = `i`.`recipeID`)
                AND (`i`.`nutrientID` = `n`.`nutrientID`))
        GROUP BY `r`.`recipeName`) `groupednutrients`