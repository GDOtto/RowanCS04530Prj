# -*- coding: utf-8 -*-
"""
Created on Thu Oct 25 18:00:42 2018

@author: Greg Devine

Start of a basic Edamam interface library.... 

"""
import configparser
import requests

#Open config file with app details
edamam_config = configparser.RawConfigParser()
edamam_config.read('../config/edamam.ini')

config_recipe_api = edamam_config['RecipeAPI']

print("calling")
#create request payload that includes the app id and key.
# this is a search and reference the Search call 
# more details here https://developer.edamam.com/edamam-docs-recipe-api
payload = {'q'       : 'duck', 
           'app_id'  : config_recipe_api['app_id'], 
           'app_key' : config_recipe_api['app_key']}

#use requests library
r = requests.get('https://api.edamam.com/search', params=payload)
print(r.status_code)
print(r.headers['content-type'])
print(r.encoding)

#print(r.json())

#dump to file to look at
f=open("../data/sample_RecipeAPISearchResults.txt", "a+")
try:
    f.write("#######\r\n")
    f.write(r.text)
finally:
    f.close()


