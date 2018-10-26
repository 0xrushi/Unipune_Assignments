# -*- coding: utf-8 -*-

import statistics as st
import pandas as pd
import matplotlib.pyplot as plt

data=pd.read_csv("iris.csv",header=1)

data.columns = ["SL","SW","PL","PW","CLASS"]

print("Data types of coloum:")
print(data.dtypes)

print("Summary Statistics:")
print(data.describe())

print("Range of SL coloum:")
print(  max(data["SL"])-min(data["SL"]))

print("varience of SL coloum:")
print(st.stdev(data["SL"])**2)

print("percentile/quantile of SL coloum:")
print(data["SL"].quantile(0.5))

print("mean of SL coloum:")
print(st.mean(data["SL"]))

print("Histogram")
#plt.hist(data["SL"],10)
data.hist()
plt.show()

print("Boxplot:")
data.boxplot(notch=1,flierprops=dict(marker='d'))

