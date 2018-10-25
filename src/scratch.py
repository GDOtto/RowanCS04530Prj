# -*- coding: utf-8 -*-
"""
Created on Thu Oct 25 18:00:42 2018

@author: Greg Devine

scratch file that will likely change offten.....  

"""
import mysql.connector
import configparser

db_config = configparser.RawConfigParser()
db_config.read('../config/db.ini')

config_db_user = db_config['DB user']
config_db_con  = db_config['DB Connection']

cnx = mysql.connector.connect(user=config_db_user['username'], 
                              password=config_db_user['password'],
                              host=config_db_con['host'],
                              database=config_db_con['database'])

try:
   cursor = cnx.cursor()
   cursor.execute("""
      select * from invoices
   """)
   result = cursor.fetchall()
   print (result)
finally:
    cnx.close()

