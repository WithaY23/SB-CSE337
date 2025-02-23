
"""
```
Instructor Notes:
Linear regression model for a fish market
You will create a linear regression model for data about a fish market.
You can use the code from the class lectures on Pandas and Linear Regression,
especially to clean the data and identify the correlations.




"""

from google.colab import drive
drive.mount('/gdrive')

HW4_ROOT_PATH = '/gdrive/MyDrive/' + 'Fall 2024/CSE337/Assignment4/'

"""## Import Packages

Following packages are what we will use throughout this exercise.
"""

import pandas as pd
import seaborn as sns
from sklearn.linear_model import LinearRegression
from sklearn.model_selection import train_test_split

"""## Observe Raw Data
Let's look into what our raw data looks like. Open `Fish.csv` as dataframe and printout its head.

"""

####################
#### TODO: Load DataFrame and printout its head
fish= pd.read_csv(HW4_ROOT_PATH + "Fish.csv")
fish.head() #display first 5 entries

####################

"""## Clean the Raw Data

The following features, `Length1`, `Length2`, and `Length3` are ambiguous. Rename the `Length1` column to `VerticalLength`, `Length2` to `DiagonalLength`, and `Length3` to `CrossLength`.
"""

####################
# TODO: Rename the Length columns so they're more descriptive
fish.rename(columns={
    'Length1':'VerticaLength',
    'Length2':'DiagonalLength',
    'Length3':'CrossLength' #choose specific columns to rename
}, inplace=True) #label over itself, 'inplace'
fish.head()

####################

"""## Identify a Correlation 

Use the [`corr()`](https://pandas.pydata.org/docs/reference/api/pandas.DataFrame.corr.html) method to look at the correlation data for the Weight column.

Then, create a heatmap for the correlation data to identify three most informative variables
"""

####################
#### TODO: get the correlation data for the Weight column
numFish = fish.select_dtypes(include=['number'])
correlationFish = numFish.corr()
correlationFish

sns.heatmap(correlationFish, annot=True, cmap='Blues', fmt = '.2f') #annot displays numbers

#The VerticalLength, HorizontalLength,
#and CrossLength are the most informative variables

####################

"""## Regression Dataset for Bream

Before we try to learn a model that predicts the weight of a fish type bream,
let's filter the DataFrame so that it only contains the values for the Bream species and assigns the resulting DataFrame to a variable named `bream`.

"""

####################
#### TODO: filter the data so it only contains the values for the Bream species
bream= fish[(fish['Species'] == 'Bream')] #filter by bream
####################


print(bream.head())

"""Then, we will splilt the bream species DataFrame into train and test sets. The size of the test set should be 20% of the entire dataset.

Remember, we are predicting weight of the bream species given other features.

"""

####################
#### TODO: split the training and test data


X=bream[['VerticaLength', 'DiagonalLength', 'CrossLength']]# tested by these col
y=bream[['Weight']] #looking for weight
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=42)


####################
X_train, X_test, y_train, y_test

"""## Train and Evaluate Model 

Now we are ready to train our model. We will use `LinearRegression` from sklearn.

In the cell below, let's train the model on training set and evaluate it on the test set.
"""

####################
#### TODO: create the model and fit the training data
lm = LinearRegression()
lm.fit(X_train, y_train)
lm.coef_


#The coefficients are stored as 1 row 3 columns, switch to 3 rows 1 column
cdf = pd.DataFrame(lm.coef_.T, X.columns, columns=['Coef'])
cdf

####################

####################
#### TODO: score the testing data
score = lm.score(X_test, y_test)




####################
print(f"R-squared score: {score}")

"""## Make Prediction

With the trained model, let's make prediction on our dataset. We want to see how our model generalize to other data and other types of fish as well, so make prediction on every fish in `Fish.csv`.

Then, join the predicted data, whose column is named `Predicted Weight`, with the actual data and assign the resulting DataFrame to a variable named `final`.
"""

####################
#### TODO: make the predictions

predictions = lm.predict(fish[['VerticaLength', 'DiagonalLength', 'CrossLength']])

####################

####################
#### TODO: join the column and set variable named final

predictionsdf = pd.DataFrame({'Predicted Weight': predictions.flatten()})

final = fish.join(predictionsdf)

####################
print(final.head())

"""## Plot the Residuals

To visualize how good our prediction is in comparison to the actual data, we need to plot residuals.

Calculate the residuals and use the [`displot()`](https://seaborn.pydata.org/generated/seaborn.displot.html) method to create a displacement plot that plots the residuals.
"""

####################
#### TODO: calculate the residuals and plot the displacement.

#use y_test to calculate residuals, small data set as opposed to alternative fish.
#could be seen as inaccurate as we tested it on the fish data set initially
predictions = lm.predict(X_test)
residuals = y_test - predictions
sns.displot(residuals, bins=30, kde=True)

####################
