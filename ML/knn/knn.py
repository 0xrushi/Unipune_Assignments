#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Tue Apr 23 23:23:26 2019
@author: r4#51c0debl00d3d
"""
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
from matplotlib.colors import ListedColormap
from sklearn.neighbors import KNeighborsClassifier

data = pd.read_csv("data.csv")
X = data.iloc[:,:-1].values
y = data.iloc[:,2].values


Knn = KNeighborsClassifier(n_neighbors= 3)
Knn.fit(X, y)

X_pred = np.array([6,6])
Y_pred = Knn.predict(X_pred.reshape(1,-1))
print("\nClass of [6,6] using KNN:- ", Y_pred[0])

#Weighted KNN
Knn = KNeighborsClassifier(n_neighbors= 3, weights='distance')
Knn.fit(X, y)

Y_pred = Knn.predict(X_pred.reshape(1,-1))

h=0.02
clf = Knn
cmap_light = ListedColormap(['lightgreen', 'yellow'])
cmap_bold = ListedColormap(['b', 'r'])

# calculate min, max and limits
x_min, x_max = X[:, 0].min() - 1, X[:, 0].max() + 1
y_min, y_max = X[:, 1].min() - 1, X[:, 1].max() + 1
xx, yy = np.meshgrid(np.arange(x_min, x_max, h),
np.arange(y_min, y_max, h))

Z = clf.predict(np.c_[xx.ravel(), yy.ravel()])
#again 1d to 2d 
Z = Z.reshape(xx.shape)
# Put the result into a color plot
plt.pcolormesh(xx, yy, Z, cmap=cmap_light)
 
# Plot also the training points
plt.scatter(X[:, 0], X[:, 1], c=y, cmap=cmap_bold)
plt.xlim(xx.min(), xx.max())
plt.ylim(yy.min(), yy.max())
plt.title("2-Class classification (k = %i)" % (3))
if (Y_pred==0):
    color = 'orange'
    marker = 's'
else:
    color = 'blue'
    marker = '.'
    
plt.scatter(X_pred[0], X_pred[1], c=color, marker=marker, s=1000)#s size
plt.show()