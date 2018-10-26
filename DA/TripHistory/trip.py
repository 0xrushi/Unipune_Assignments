import pandas as pd
from sklearn.metrics import accuracy_score
df = pd.read_csv("tripdata.csv",usecols=['Duration','Startnumber','Endnumber','Membertype'])

df['Membertype'] = df['Membertype'].apply({'Member':0,'Casual':1}.get)

X = df.ix[:,:-1]
y = df.ix[:,-1]

print(X.describe())
print(y.describe())

from sklearn.model_selection import train_test_split
X_train, X_test, y_train, y_test = train_test_split(X,y,test_size=0.3,random_state=0)

from sklearn.preprocessing import StandardScaler
scaler = StandardScaler()
scaler.fit_transform(X_train)

from sklearn.tree import DecisionTreeRegressor
model = DecisionTreeRegressor()
model.fit(X_train, y_train)

y_pred = model.predict(X_test)
y_pred = [int(i) for i in y_pred]

import numpy as np
acc = accuracy_score(np.array(y_test).reshape(-1,1),np.array(y_pred))
