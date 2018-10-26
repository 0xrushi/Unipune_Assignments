import pandas as pd
import numpy as np
from sklearn.preprocessing import StandardScaler
from sklearn.metrics import accuracy_score
data = pd.read_csv("diabetes.csv")

X = data.ix[:,:-1]
y = data.ix[:,-1]


from sklearn.model_selection import train_test_split
X_train, X_test, y_train, y_test = train_test_split(X,y,test_size=0.3,random_state=0)

scaler = StandardScaler()
X_train = scaler.fit_transform(X_train)

from sklearn.naive_bayes import GaussianNB
model = GaussianNB()
model.fit(X_train,y_train)

X_test = scaler.transform(X_test)

y_pred = model.predict(X_test)
y_pred_prob = model.predict_proba(X_test)

acc = accuracy_score(np.array(y_pred).reshape(-1,1), np.array(y_test).reshape(-1,1))

print(acc)