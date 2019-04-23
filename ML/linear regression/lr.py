import matplotlib.pyplot as plt
import pandas as pd
from math import sqrt
from sklearn.metrics import mean_squared_error,mean_absolute_error
from sklearn.model_selection import train_test_split  
from sklearn.linear_model import LinearRegression

dataset=pd.read_csv("hours.csv", header=None)
X=dataset.iloc[:,:-1].values
y=dataset.iloc[:,1].values
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.4, random_state = None)  
#set random_state = 0 for debugging

regressor=LinearRegression()
regressor.fit(X_train,y_train)
Accuracy=regressor.score(X_test, y_test)*100
print("Accuracy :",Accuracy)

y_pred=regressor.predict(X_test)
#print(y_pred)

print('Mean Absolute Error:', mean_absolute_error(y_test, y_pred))  
print('Mean Squared Error:', mean_squared_error(y_test, y_pred))  
print('Root Mean Squared Error:', sqrt(mean_squared_error(y_test, y_pred)))

hours=int(input('Enter the no of hours'))

print(regressor.predict([[hours]]))
#Y='%f*'X'+%f' %(regressor.coef_,regressor.intercept_)
print('y='),
print(regressor.coef_[0]),
print('*x + '),
print(regressor.intercept_)
plt.plot(X,y,'o')
plt.plot(X_test,y_pred);
plt.show()

