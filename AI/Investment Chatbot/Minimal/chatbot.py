#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Sun Oct 28 17:13:30 2018

@author: h4x3d
"""

import aiml

k=aiml.Kernel()

k.bootstrap(learnFiles='investment.aiml' )

while True:
    i = input('> ')
    response = k.respond(i)
    print(response)