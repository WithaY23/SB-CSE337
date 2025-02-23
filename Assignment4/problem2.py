# -*- coding: utf-8 -*-
"""
Instructor Notes:

Neural Network for a car market
You will create a Neural Network using Pytorch for data about a car market.
You can use much of the code from the class lecture on PyTorch.
For this problem, you need to understand and study the model covered in the class.



"""

from google.colab import drive
drive.mount('/gdrive')

# Commented out IPython magic to ensure Python compatibility.
HW4_ROOT_PATH = '/gdrive/MyDrive/' + 'Fall 2024/CSE337/Assignment4/' # TODO: Replace PATH/TO/ASSIGNMENT4, {last name}_{first name}_{sbu id}_hw4 for example
# %cd -q $HW4_ROOT_PATH
# %ls
# At least, there should be Fish.csv, cars.csv, Problem1.ipynb and Problem2.ipynb in your root path.

"""## Import Packages

Following packages are what we will use throughout this exercise. Please do not use other packages.
"""

import torch
import numpy as np
import torch.nn as nn
import torch.nn.functional as F
import pandas as pd
import seaborn as sns
import matplotlib.pyplot as plt
from sklearn.model_selection import train_test_split
from sklearn.preprocessing import LabelEncoder

"""
"""

#########################
#### TODO: Load cars.csv into DataFrame and printout its head.

df = pd.read_csv('cars.csv')

df.head() #print first 5 entries


#########################

"""## Correlation Analysis

We plan to train our model to classify car body (e.g. convertible) of a car, given other information about it. Having a look at `cars.csv`, there are many columns. More features are generally useful, but sometimes does not help and rather harm the model training.

Let's analyze which features are useful to classify car body by looking at correlation between features and use them to train our model.


"""

# Identify categorical columns and change them to numerical value.
categorical_cols = df.select_dtypes(include=['object']).columns
le = LabelEncoder()
for col in categorical_cols:
    df[col] = le.fit_transform(df[col])

#########################
##### TODO: Draw heatmap.
correlation_df= df.corr()[['carbody']]
correlation_df.index = df.columns

sns.heatmap(correlation_df,annot = True)


# correlation_df_sorted = correlation_df.iloc[correlation_df['carbody'].abs().argsort()[::-1]]
# negative_corr_df = correlation_df_sorted[correlation_df_sorted['carbody'] < 0]
# print(negative_corr_df.head(5))


# correlation_df_sorted = correlation_df.iloc[correlation_df['carbody'].abs().argsort()[::-1]]
# positive_corr_df = correlation_df_sorted[correlation_df_sorted['carbody'] > 0]
# print(positive_corr_df.head(5)) USED the above and this commented to figure out values
#all values are not shown in heatmap, seen in print statement

#########################


#Unlabeled values found through the above print statements
#1. doornumber
#2. symboling
#3. carheight
#4. wheelbase
#5. carlength

#########################



"""## Prepare Dataset

We see from the correlation heatmap which features are useful. Pick features to get high accuracy for your classification model. There is no correct answer to this, meaning you see have different output to the provided expected output.

Split the dataset into train and test set. The size of the test set should be set to 20% of the entire dataset.

Note that pandas DataFrame needs to be converted to torch Tensor to be used for training and evaluation.



"""

#########################
#### TODO: Pick five features.
# X = df[['carheight','carlength','compressionratio','CarName','car_ID']]
# X = df[['doornumber','symboling','enginelocation','drivewheel','horsepower']]
X=df[['doornumber','symboling','carheight','wheelbase','carlength']] #strongest negative/positive correlation values
y = df['carbody'].values #test against


#########################

#########################
#### TODO: Split into train/test set.
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=42)

#########################

#########################
#### TODO: Convert train/test set to torch Tensor object.
X_train = torch.FloatTensor(X_train.values) #efficiency purposes
X_test = torch.FloatTensor(X_test.values)
y_test  = torch.LongTensor(y_test)
y_train = torch.LongTensor(y_train)

#########################

X_train.shape, X_test.shape, y_train.shape, y_test.shape

"""## Modeling

This is the highlight of the exercise. Let's create a NN model. There should be input layer, output layer, and three hidden layers. You can choose any activation, and note that layers should be interleaved with activation function to provide non-linearity to the model. The shape of input layer depend on the number of features you've selected from the data, and that of output layer depends on the number of classes in your data. Further model design is up to you.

"""

class Model(nn.Module):
    def __init__(self,in_features = 5, h1 = 32, h2=32, h3 = 32, out_features =5): #change in features, represents base input nodes
        super().__init__()
        #########################
        #### TODO: DEFINE MODEL ARCHITECTURE
        self.fc1= nn.Linear(in_features,h1)
        self.fc2 = nn.Linear(h1,h2)
        self.fc3 = nn.Linear(h2,h3)
        self.out = nn.Linear(h3,out_features)
        # self.dropout = nn.Dropout(0.1)

        #########################


    def forward(self,x):
      #########################
      #### TODO: DEFINE FORWARD PROPAGATION
      x = F.relu(self.fc1(x))
      x = F.relu(self.fc2(x))
      x= F.relu(self.fc3(x))
      x = self.out(x)

      #########################
      return x

"""## Training

Now we have all the receipe to train the model. Let's initialize the model, select criterion (loss function), select optimizer, set other hyperparameters, and train.

Within the training loop, you will forward/back propagate the model. Be careful to reset every update when updating the gradient. Also, keep the history of loss as you'll have to plot after the training.


"""

#########################
#### TODO: Initialize model, criterion, optimizer, epochs, and list to keep losses.
# torch.manual_seed(41) #randomize the weights
model = Model()


criterion = nn.CrossEntropyLoss()

optimizer = torch.optim.AdamW(model.parameters(), lr=0.0005) #changed learning rate,
# using AdamW for better data


epochs = 5000 #loops
losses = []


#########################

for i in range(epochs):
  #########################
  #### TODO: Train model.
  y_pred = model.forward(X_train)
  loss =criterion(y_pred, y_train)
  losses.append(loss.detach().numpy())



  #########################

  if i % 10 == 0:
    print(f'Epoch: {i} and loss: {loss}') #print each 10 epochs

  optimizer.zero_grad()
  loss.backward()
  optimizer.step()

print(next(model.parameters()).shape)

"""## Plot Loss Graph
Often times, we want to visualize whether our model was trained properly. One of the methods is to plot loss graph. Plot the x-y graph where x axis is `Epoch` and y axis is `Training loss`. The training loss should decrease throughout the training process.
"""

#########################
#### TODO: Plot loss history

plt.plot(range(epochs), losses)
plt.xlabel("Epoch")
plt.ylabel("Training loss")


#########################

"""## Evaluate and Save Model

We trained our model with the training set. Let's evaluate our model performance using the test set. Compute classification accuracy of our model.
You need to get above 50% classification accuracy to receive a full credit.

If we are happy about the result, let's save and name the model as `carbody_model.pt`.

"""

#########################
#### TODO: Compute accuracy.
correct = 0
with torch.no_grad():
  for i, data in enumerate(X_test):
    y_val = model.forward(data)
    # print(f'{i+1}.) {str(y_val)} \t {y_test[i]}')
    if y_val.argmax().item() == y_test[i]:
      correct +=1

accuracy = 100 * correct / len(X_test)

#########################
print(f"Accuracy: {accuracy}")

#########################
#### TODO: Save state dict of the trained model.
torch.save(model.state_dict(), 'my_337_NNmodel.pt')
#########################

