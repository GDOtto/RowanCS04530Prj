# -*- coding: utf-8 -*-
"""
Created on Thu Oct 25 18:00:42 2018

@author: Greg Devine

Start of a basic Edamam interface library.... 

"""

def load_Recipe(Recipe_Name):   
    
    import configparser
    import requests
    import os
    import json
    import mysql.connector
    import time

    ################ BEING INTERNAL FUNCTION DEFS ################
    
    def searchForRecipes(keyword):
        print("Calling Recipe API...")
        #create request payload that includes the app id and key.
        # this is a search and reference the Search call 
        # more details here https://developer.edamam.com/edamam-docs-recipe-api
        payload = {'q'       : keyword, 
                   'app_id'  : config_recipe_api['app_id'], 
                   'app_key' : config_recipe_api['app_key']}
        
        #use requests library
        r = requests.get('https://api.edamam.com/search', params=payload)
        print("HTTP Call Status: ",r.status_code,"\n")
        return json.loads(r.text)
    #END def searchForRecipes(keyword):
    
    def searchForFood(keyword):
        print("Calling Food API...")
        #create request payload that includes the app id and key.
        # this is a search and reference the Search call 
        # more details here https://developer.edamam.com/food-database-api-docs
        payload = {'ingr'           : keyword, 
                   'app_id'         : config_food_api['app_id'], 
                   'app_key'        : config_food_api['app_key']}
        
        #use requests library
        r = requests.get('https://api.edamam.com/api/food-database/parser', params=payload)
        print("HTTP Call Status: ",r.status_code,"\n")
        return json.loads(r.text)
    #END def searchForFood(keyword):
    
    def insertdatabase(jsonResult,dbType):
        print("Opening MySQL Connection to Food Database...")
        db_config = configparser.RawConfigParser()
        db_config.read('../config/db.ini')
    
        config_db_user = db_config['DB user']
        config_db_con  = db_config['DB Connection']
    
        cnx = mysql.connector.connect(user=config_db_user['username'], 
                                      password=config_db_user['password'],
                                      host=config_db_con['host'],
                                      database=config_db_con['database']) 
            
        if dbType == 'recipe':
            print("Parsing Recipe Table...")
            recipe = jsonResult['hits'][0]['recipe']
            print("Recipe Name: ", recipe['label'])
            print("Recipe Servings: ", recipe['yield'])
            if len(recipeJSON['hits'][0]['recipe']['dietLabels']) != 0:
                print("Recipe Diet: ", recipe['dietLabels'][0])
                DIETLABEL = recipe['dietLabels'][0]
            else:
                DIETLABEL = "NULL"
            # Make sure recipe is not already in database, if not add to database
            cursor = cnx.cursor()
            cursor.execute("SELECT COUNT(*) FROM recipes WHERE recipeName = \"" + recipe['label'] + "\";")
            num_results = cursor.fetchall()
            if num_results[0][0] > 0:
                print("Duplicate Recipe, not inserting data to Recipe Table...")
                lastrowid = 0
            else:
                print("Inserting data to Recipes Table...")
                cursor = cnx.cursor()
                lastrowid = cursor.lastrowid
                add_recipe = ("INSERT INTO recipes "
                              "(recipeID, recipeName, servings, diet) "
                              "VALUES (%s, %s, %s, %s)")
                data_recipe = (lastrowid, (recipe['label']), (recipe['yield']), DIETLABEL)
                cursor.execute(add_recipe, data_recipe)           
                cnx.commit()        
                lastrowid = cursor.lastrowid
                print("Committed Changes to Recipe Table...")
            #END if num_results[0][0] > 0:
        #END if dbType == 'recipe':
        elif dbType == "nutrient":
            print("Parsing Nutrition Table...")
            for items in jsonResult['parsed']:
                print("Food: " + items['food']['label'])
                ENERC_KCAL = 0
                CHOCDF = 0
                FAT = 0
                FIBTG = 0
                PROCNT = 0
                for nutrients in items['food']['nutrients']:
                    if nutrients == 'ENERC_KCAL':
                        print("  Energy : ", items['food']['nutrients']['ENERC_KCAL'])
                        ENERC_KCAL = items['food']['nutrients']['ENERC_KCAL']
                    elif nutrients == 'CHOCDF':
                        print("  Carbs : ", items['food']['nutrients']['CHOCDF'])
                        CHOCDF = items['food']['nutrients']['CHOCDF']
                    elif nutrients == 'FAT':
                        print("  Fat : ", items['food']['nutrients']['FAT'])
                        FAT = items['food']['nutrients']['FAT']
                    elif nutrients == 'FIBTG':
                        print("  Fiber : ", items['food']['nutrients']['FIBTG'])
                        FIBTG = items['food']['nutrients']['FIBTG']
                    elif nutrients == 'PROCNT':
                        print("  Protien : ", items['food']['nutrients']['PROCNT'])
                        PROCNT = items['food']['nutrients']['PROCNT']
                    else:
                        print("Nutrient Missing: ", nutrients)
                #END for nutrients in items['food']['nutrients']:
                # Check to make sure it's not already in the database, if not add to database
                cursor = cnx.cursor()
                cursor.execute("SELECT COUNT(*) FROM nutrients WHERE foodname = \"" + items['food']['label'] + "\";")
                num_results = cursor.fetchall()
                if num_results[0][0] > 0:
                    print("Duplicate Nutrient, not inserting data to Nutrition Table...")
                    cursor.execute("SELECT nutrientID FROM nutrients WHERE foodname = \"" + items['food']['label'] + "\";")
                    id_result = cursor.fetchall()
                    lastrowid = id_result[0][0]
                    print("Dup Id: " + str(lastrowid))
                else:
                    print("Inserting data to Nutrition Table...")
                    lastrowid = cursor.lastrowid
                    add_ingred = ("INSERT INTO nutrients "
                                  "(nutrientID, foodName, calories, carbs, fat, fiber, protein, UPC) "
                                  "VALUES (%s, %s, %s, %s, %s, %s, %s, %s)")
                    data_ingred = (lastrowid, (items['food']['label']), ENERC_KCAL,CHOCDF,FAT,FIBTG,PROCNT,"NULL")
                    cursor.execute(add_ingred, data_ingred)     
                    cnx.commit()
                    lastrowid = cursor.lastrowid
                    print("Committed Changes to Nutrition Table...")
                #END if num_results[0][0] > 0:  
            #END for items in jsonResult['parsed']:                 
        #END elif dbType == "nutrient":
        elif dbType == "ingredient":
            print("Inserting data to Ingredient Table...")
            cursor = cnx.cursor()
            lastrowid = cursor.lastrowid
            add_ingred = ("INSERT INTO ingredients "
                          "(nutrientID, recipeID, foodQty) "
                          "VALUES (%s, %s, %s)")
            data_ingred = ((jsonResult['nutrientID']), (jsonResult['recipeID']), (jsonResult['qty']))
            cursor.execute(add_ingred, data_ingred)           
            cnx.commit()        
            lastrowid = cursor.lastrowid
            print("Committed Changes to Ingredient Table...")         
        #END elif dbType == "ingredient":      
        cursor.close()
        cnx.close()
        print ("Closed Database Connection to Food...")          
        return lastrowid
    #END def insertdatabase(jsonResult,dbType):
    
    ################ END INTERNAL FUNCTION DEFS ################
                
    #Open config file with app details
    #home = str(Path.home())
    edamam_config_file = "c:\edamam.ini"
    edamam_config = configparser.RawConfigParser()
    
    print("path is "+edamam_config_file)
    if not os.path.isfile(edamam_config_file):
        edamam_config_file = '../config/edamam.ini'
    
    edamam_config.read(edamam_config_file)
    
    config_recipe_api = edamam_config['RecipeAPI']
    config_food_api = edamam_config['FoodAPI']
    
    recipeJSON = searchForRecipes(Recipe_Name)
    recipeID = insertdatabase(recipeJSON,"recipe")
    if recipeID == 0:
        print("The recipe is already in the database, Skipping!!")
    else:
        listIngred = recipeJSON['hits'][0]['recipe']['ingredients']
        for ingred in listIngred:
            foodJSON = searchForFood(ingred['text'])
            nutrientID = insertdatabase(foodJSON,"nutrient")    
            IngredDict = {"recipeID" : recipeID, "nutrientID" : nutrientID, "qty" : ingred['weight']}
            insertdatabase(IngredDict,"ingredient")  
            time.sleep(2)  
        print("!!!Done!!!")
    

#if __name__ == "__main__": 
#    recipeJSON = searchForRecipes("Aromatic Christmas Ham")
#    recipeID = insertdatabase(recipeJSON,"recipe")
#    if recipeID == 0:
#        print("The recipe is already in the database, Skipping!!")
#    else:
#        listIngred = recipeJSON['hits'][0]['recipe']['ingredients']
#        for ingred in listIngred:
#            foodJSON = searchForFood(ingred['text'])
#            nutrientID = insertdatabase(foodJSON,"nutrient")    
#            IngredDict = {"recipeID" : recipeID, "nutrientID" : nutrientID, "qty" : ingred['weight']}
#            IngedID = insertdatabase(IngredDict,"ingredient")  
#            time.sleep(2)  
#        print("!!!Done!!!")
    
#    recipeJSON = searchForRecipes("Figgy Pudding")
#    recipeID = insertdatabase(recipeJSON,"recipe")
#    listIngred = recipeJSON['hits'][0]['recipe']['ingredients']
#    for ingred in listIngred:
#        foodJSON = searchForFood(ingred['text'])
#        nutrientID = insertdatabase(foodJSON,"nutrient")    
#        IngredDict = {"recipeID" : recipeID, "nutrientID" : nutrientID, "qty" : ingred['weight']}
#        IngedID = insertdatabase(IngredDict,"ingredient")  
#        time.sleep(2)    
#    print("!!!Done!!!")

