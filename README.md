# Statement Problem

Allocating loans to customers with an assurance that they will payback is serious problem for many seasoned and upcoming
fintech companies. This machine learning approach intends to predict [classify] customers as credit worth or not by assigning them a credit score
between 0 and 1 and a payback probability. With a proper tuning, this model could be the awaited solution to help companies avoid losses in money lending.

## Boosting_Algorithms

Algorithms that use boosting techniques to minimize the loss function for both classification and regression problems.

Attention will be paid to the training time and loss minimization for the models

## Models

For this project, we will primarily focus on two boosting algorithm; CatBoost and Extreme Gradient Boosting algorithm.

### Extreme Gradient Boosting Algorithm

Trained on 80% of the dataset.

#### Performance

##### xgb

Initial rmse scored                 0.5179          [using binary:logistic loss function]
Score after Hyperparameter          0.4685          [using binary:logistic loss function]
Score using hyperopt tuner rmse     0.4349          [using binary:logistic loss function]

score using synthetic data ===> 0.2872281323269014  [binary:logistic loss function]
score using synthetic data ===> 0.2806243040080456  [multi:softmax loss function]

score; hyperopt + synthetic data ===> 0.2645751311064591 [binary:logistic loss function]
