CREATE OR REPLACE VIEW  `food`.`recipe_costs` AS
	SELECT
		`recipeName`,
        CONCAT("$",CAST(FORMAT(`_recipe_costs`.`price`, 2) AS CHAR)) AS `price`
    FROM
    (SELECT 
        `r`.`recipeName` AS `recipeName`,
        SUM(`s`.`price`) AS `price`
     FROM
            (((`food`.`recipes` `r`
        JOIN `food`.`ingredients` `i`)
        JOIN `food`.`nutrients` `n`)
        JOIN `food`.`shopping` `s`)
        WHERE
            ((`r`.`recipeID` = `i`.`recipeID`)
                AND (`i`.`nutrientID` = `n`.`nutrientID`) 
                AND (`s`.`UPC` = `n`.`UPC`)) 
                group by `r`.`recipeName`) `_recipe_costs`;
                

select * from `food`.`recipe_costs`;