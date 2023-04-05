import pandas as pd
from sklearn.model_selection import train_test_split
from sklearn.linear_model import LinearRegression

# Load data
data = pd.read_csv('data.csv')

# Split data into training and testing sets
X_train, X_test, y_train, y_test = train_test_split(data[['input']], data['output'], test_size=0.2)

# Create linear regression model and fit to training data
model = LinearRegression()
model.fit(X_train, y_train)

# Evaluate model on testing data
accuracy = model.score(X_test, y_test)

# Make predictions on new data
new_data = pd.DataFrame({'input': [1, 2, 3, 4, 5]})
predictions = model.predict(new_data)

print('Accuracy: {}'.format(accuracy))
print('Predictions: {}'.format(predictions))