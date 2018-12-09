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
    print("calling")
    #create request payload that includes the app id and key.
    # this is a search and reference the Search call 
    # more details here https://developer.edamam.com/edamam-docs-recipe-api
    payload = {'ingr'       : keyword, 
               'app_id'  : config_food_api['app_id'], 
               'app_key' : config_food_api['app_key']}
    
    #use requests library
    r = requests.get('https://api.edamam.com/api/food-database/parser', params=payload)

    #dump to file to look at
    f=io.open( "../data/sample_FoodAPIParseResults.txt", "a+", encoding="utf-8")
#    f=open("../data/sample_RecipeAPISearchResults.txt", "a+")
    try:
        f.write("#######\r\n")
        f.write(r.text)
    finally:
        f.close()
    
    return json.loads(r.text)
    


if __name__ == "__main__":
    #Test module
    
    #searchForRecipes("duck")
    searchForFood("1 can diced tomatoes")

