# -*- coding: utf-8 -*-
"""
Created on Thu Oct 25 18:00:42 2018

@author: Greg Devine

scratch file that will likely change offten.....  

"""
import pyforms
from   pyforms.basewidget import BaseWidget
from   pyforms.controls import ControlText
from   pyforms.controls import ControlButton

#Open config file with app details
class SimpleExample1(BaseWidget):

    def __init__(self):
        super(SimpleExample1,self).__init__('Simple example 1')

        #Definition of the forms fields
        self._firstname  = ControlText('First name', 'Default value')
        self._middlename = ControlText('Middle name')
        self._lastname   = ControlText('Lastname name')
        self._fullname   = ControlText('Full name')
        self._button     = ControlButton('Press this button')

#Execute the application
if __name__ == "__main__": pyforms.start_app( SimpleExample1 )

