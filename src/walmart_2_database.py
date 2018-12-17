# -*- coding: utf-8 -*-
"""
Created on Mon Dec 17 15:33:21 2018

@author: Paolo
"""


    
import configparser
import requests
import os
import json
import mysql.connector
import time


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

def upcPriceLookUp(upc_code):    
    print("calling")
    payload = {'upc'       : upc_code, 
               'apiKey' : walmart_pricelookup_api['app_key']}
    r = requests.get('http://api.walmartlabs.com/v1/items', params=payload)
    return json.loads(r.text)
  
def insertshopping(upc,price):
    print("Opening MySQL Connection to Food Database...")
    db_config = configparser.RawConfigParser()
    db_config.read('../config/db.ini')
    
    config_db_user = db_config['DB user']
    config_db_con  = db_config['DB Connection']
    
    cnx = mysql.connector.connect(user=config_db_user['username'], 
                                  password=config_db_user['password'],
                                  host=config_db_con['host'],
                                  database=config_db_con['database']) 
    try: 
        # Need to read UPC column from Nutrients table
        # Need to read size from size table
        # Loop through UPC values and look up price
        
        print("Inserting data to Shopping Table...")
        cursor = cnx.cursor()
        add_shopping = ("INSERT INTO shopping "
                      "(UPC, price) "
                      "VALUES (%s, %s)")
        data_shopping = (upc, price)
        cursor.execute(add_shopping, data_shopping)           
        cnx.commit()        
      
        print("Committed Changes to Recipe Table...")
    finally:
        cnx.close()
        
def add_price(UPC_num):          
    # Given the UPC value - Look up the price - Populate shopping table
    priceJSON = upcPriceLookUp(UPC_num)
        
    price = priceJSON["items"][0]["salePrice"]
        
    insertshopping(UPC_num,price)    
        
        
        
if __name__ == "__main__": 
    print('testing')    

    print("Cycle through UPC Codes...")
    db_config = configparser.RawConfigParser()
    db_config.read('../config/db.ini')
    
    config_db_user = db_config['DB user']
    config_db_con  = db_config['DB Connection']
    
    cnx = mysql.connector.connect(user=config_db_user['username'], 
                                  password=config_db_user['password'],
                                  host=config_db_con['host'],
                                  database=config_db_con['database']) 
    UPC_rows = None
    try: 
        # Need to read UPC column from Nutrients table
        # Need to read size from size table
        # Loop through UPC values and look up price
        
        print("Inserting data to Shopping Table...")
        cursor = cnx.cursor()
        UPCcodes = ("SELECT UPC FROM nutrients")
        cursor.execute(UPCcodes)
        UPC_rows = cursor.fetchall()
      
        print("Committed Changes to Recipe Table...")
    finally:
        cnx.close()
        
    for row in UPC_rows:
        if row[0] != "NULL":
            print(row[0])
#            priceJSON = upcPriceLookUp(row[0])
#            price = priceJSON["items"][0]["salePrice"]
            add_price(row[0])
            
            
        