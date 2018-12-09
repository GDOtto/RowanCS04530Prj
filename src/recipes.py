# -*- coding: utf-8 -*-
"""
Created on Fri Dec  7 18:16:57 2018

@author: Family
"""

import database
import edamam
import json


#found_recipes_text = edamam.searchForRecipes('baked ziti')
found_recipes_json = edamam.searchForRecipes('baked ziti')

#found_recipes_json = json.loads(found_recipes_text)

print(found_recipes_json['q'])


