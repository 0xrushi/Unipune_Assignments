# -*- coding: utf-8 -*-
# conda install python-graphviz
"""
conda install graphviz
conda install python3-graphviz

@author: r4#51c0debl00d3d
"""

import pandas as pd
import graphviz
data = pd.read_csv("data.csv")

from sklearn.preprocessing import LabelEncoder
lble = LabelEncoder()
data = data.apply(lble.fit_transform)

x = data.iloc[:,1:5].values
y = data.iloc[:,5].values

def ipconvert(t):
    lble = LabelEncoder()
    #print(st)
    df = pd.DataFrame({'age':[t[0]],'income':[t[1]],'gender':[t[2]],'maritial status':[t[3]]})
    df =df.apply(lble.fit_transform)
    return df

from sklearn.model_selection import train_test_split
X_train, X_test, Y_train, Y_test = train_test_split(x, y, test_size= 0.33, random_state= 1)

from sklearn.tree import DecisionTreeClassifier, export_graphviz
dtc = DecisionTreeClassifier()
dtc = dtc.fit(X_train, Y_train)
Y_pred = dtc.predict(X_test)

from sklearn.metrics import accuracy_score
print("Accuracy Score: ", accuracy_score(Y_test, Y_pred))

t=['>21','low','male','single']
kk = ipconvert(t)
numerical_op = dtc.predict(kk)
actual_op = lble.inverse_transform(numerical_op)
print(actual_op)

dot_data = export_graphviz(dtc, out_file=None, feature_names=['age', 'income ', 'gender', 'maritial status'], class_names=['yes','no'], filled=True, rounded=True, special_characters=True)
graph = graphviz.Source(dot_data)
graph