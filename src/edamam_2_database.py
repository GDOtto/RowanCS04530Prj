# -*- coding: utf-8 -*-
"""
Created on Thu Oct 25 18:00:42 2018

@author: Greg Devine

Start of a basic Edamam interface library.... 

"""
import configparser
import requests
import os
import io
from pathlib import Path
import json
import mysql.connector

#Open config file with app details
home = str(Path.home())
edamam_config_file = "c:\edamam.ini"
edamam_config = configparser.RawConfigParser()

print("path is "+edamam_config_file)
if not os.path.isfile(edamam_config_file):
    edamam_config_file = '../config/edamam.ini'

edamam_config.read(edamam_config_file)

config_recipe_api = edamam_config['RecipeAPI']
config_food_api = edamam_config['FoodAPI']

def searchForRecipes(keyword):
    print("calling")
    #create request payload that includes the app id and key.
    # this is a search and reference the Search call 
    # more details here https://developer.edamam.com/edamam-docs-recipe-api
    payload = {'q'       : keyword, 
               'app_id'  : config_recipe_api['app_id'], 
               'app_key' : config_recipe_api['app_key']}
    
    #use requests library
    r = requests.get('https://api.edamam.com/search', params=payload)

    #dump to file to look at
    f=io.open( "../data/sample_RecipeAPISearchResults.txt", "a+", encoding="utf-8")
#    f=open("../data/sample_RecipeAPISearchResults.txt", "a+")
    try:
        f.write("#######\r\n")
        f.write(r.text)
    finally:
        f.close()
    

    return json.loads(r.text)

def searchForFood(keyword):
    print("Calling Food API")
    #create request payload that includes the app id and key.
    # this is a search and reference the Search call 
    # more details here https://developer.edamam.com/edamam-docs-recipe-api
    payload = {'ingr'           : keyword, 
               'app_id'         : config_food_api['app_id'], 
               'app_key'        : config_food_api['app_key']}
    
    #use requests library
    r = requests.get('https://api.edamam.com/api/food-database/parser', params=payload)
    print("HTTP Call Status: ",r.status_code,"\n")

    #dump to file to look at
#    f=io.open( "../data/sample_FoodAPIParseResults.txt", "a+", encoding="utf-8")
#    f=open("../data/sample_RecipeAPISearchResults.txt", "a+")
#    try:
#        f.write("#######\r\n")
#        f.write(r.text)
#    finally:
#        f.close()
    
    return json.loads(r.text)

def insertdatabase(jsonResult,apiType):
    db_config = configparser.RawConfigParser()
    db_config.read('../config/db.ini')

    config_db_user = db_config['DB user']
    config_db_con  = db_config['DB Connection']

    cnx = mysql.connector.connect(user=config_db_user['username'], 
                                  password=config_db_user['password'],
                                  host=config_db_con['host'],
                                  database=config_db_con['database'])
    if apiType == "food":
        for items in jsonResult['parsed']:
            print(items['food']['label'])
            print(items['food']['nutrients'])
            ENERC_KCAL = 0
            CHOCDF = 0
            FAT = 0
            FIBTG = 0
            PROCNT = 0
            for nutrients in items['food']['nutrients']:
                if nutrients == 'ENERC_KCAL':
                    print("Energy : ", items['food']['nutrients']['ENERC_KCAL'])
                    ENERC_KCAL = items['food']['nutrients']['ENERC_KCAL']
                elif nutrients == 'CHOCDF':
                    print("Carbs : ", items['food']['nutrients']['CHOCDF'])
                    CHOCDF = items['food']['nutrients']['CHOCDF']
                elif nutrients == 'FAT':
                    print("Fat : ", items['food']['nutrients']['FAT'])
                    FAT = items['food']['nutrients']['FAT']
                elif nutrients == 'FIBTG':
                    print("Fiber : ", items['food']['nutrients']['FIBTG'])
                    FIBTG = items['food']['nutrients']['FIBTG']
                elif nutrients == 'PROCNT':
                    print("Protien : ", items['food']['nutrients']['PROCNT'])
                    PROCNT = items['food']['nutrients']['PROCNT']
                else:
                    print("Nutrient Missing: ", nutrients)
            print(" ")
            try:
                print("Inserting to ingredients Database")
                cursor = cnx.cursor()
                str = 
                cursor.execute("",str """)
#        try:
#            print("Food API Call")
#            cursor = cnx.cursor()
#            cursor.execute("""
#                           select * from nutrition
#                           """)
#            result = cursor.fetchall()
#            print (result)
#        finally:
    cnx.close()
                

if __name__ == "__main__":
    #Test module
    
    #searchForRecipes("duck")
    foodJSON = searchForFood("chocolate")
    insertdatabase(foodJSON,"food")

