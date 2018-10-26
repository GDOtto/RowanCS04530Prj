# -*- coding: utf-8 -*-
"""
Created on Thu Oct 25 18:00:42 2018

@author: Greg Devine

scratch file that will likely change offten.....  

"""
import configparser
import requests


edamam_config = configparser.RawConfigParser()
edamam_config.read('../config/edamam.ini')

config_recipe_api = edamam_config['RecipeAPI']

print("calling")
payload = {'q'       : 'duck', 
           'app_id'  : config_recipe_api['app_id'], 
           'app_key' : config_recipe_api['app_key']}
r = requests.get('https://api.edamam.com/search', params=payload)
print(r.status_code)
print(r.headers['content-type'])
print(r.encoding)
#print(r.text)
#print(r.json())

f=open("../data/sample_RecipeAPISearchResults.txt", "a+")
try:
    f.write("#######\r\n")
    f.write(r.text)
finally:
    f.close()


