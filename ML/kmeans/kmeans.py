#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Wed Apr 24 00:51:07 2019

@author: r4#51c0debl00d3d
"""
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import collections
from sklearn.cluster import KMeans

data = pd.read_csv("data.csv")
x = data.iloc[:,0].values
y = data.iloc[:,1].values

init_centroid = np.array([[0.1, 0.6], [0.3, 0.2]])
print("\nInitial Centroids:- \n",init_centroid)

model = KMeans(n_clusters=2, init= init_centroid)
model.fit(data)

centroid = model.cluster_centers_
print("\nFinal Centroids:- ",centroid)

print("\nPoint P6 belongs to cluster: ",model.labels_[5])

population= collections.Counter(model.labels_)
print("\nPopulation of cluster m1: ",population[0])
print("\nPopulation of cluster m2: ",population[1])
print("\n")

plt.scatter(x, y, c= model.labels_)
plt.scatter(model.cluster_centers_[:,0], model.cluster_centers_[:,1], c='red')
