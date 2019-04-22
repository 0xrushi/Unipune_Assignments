#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Mon Apr 22 22:47:53 2019
@author: r4#51c0debl00d3d
"""
import random

def private_key(p):
    return random.randint(2, p-1)

def public_key(q, a, p):
    return pow(q, a, p)

def secret(s, a, p):
    return pow(s, a, p)


p = int(input("Enter the value of p : "))
q = int(input("Enter the value of q : "))

a = random.randint(100,10000)
R = public_key(q,a,p)

b = random.randint(100,10000)
S = public_key(q,b,p)

Rk = secret(S,a,p)
Sk = secret(R,b,p)

print("public key of ramesh is :\n",R)
print("public key of suresh is :\n",S)
print("Rk ",Rk)
print("Sk", Sk)
if Rk==Sk:
    print("Rk = Sk = K = agreed key")