# -*- coding: utf-8 -*-
"""
Created on Thu Oct 25 18:00:42 2018

@author: Greg Devine

Basic start to looking up a UPC price. 

"""
import configparser
import requests
import os
from pathlib import Path

#Open config file with app details
home = str(Path.home())
walmart_config_file = "c:\walmart.ini"
walmart_config = configparser.RawConfigParser()

print("path is "+walmart_config_file)
if not os.path.isfile(walmart_config_file):
    walmart_config_file = '../config/walmart.ini'

walmart_config.read(walmart_config_file)

walmart_pricelookup_api = walmart_config['PriceLookup']

#done grabbing edamam keys

print("calling")
payload = {'upc'       : '035000521019', 
           'apiKey' : walmart_pricelookup_api['app_key']}
r = requests.get('http://api.walmartlabs.com/v1/items', params=payload)
print(r.status_code)
print(r.headers['content-type'])
print(r.encoding)
#print(r.text)
print(r.json())

f=open("../data/sample_PriceLookupAPIResults.txt", "a+")
try:
    f.write("#######\r\n")
    f.write(r.text)
finally:
    f.close()


