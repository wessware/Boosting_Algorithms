# Statement Problem

Allocating loans to customers with an assurance that they will payback is serious problem for many seasoned and upcoming 
fintech companies. This machine learning approach intends to predict [classify] customers as credit worth or not by assigning them a credit score
between 0 and 1 and a payback probability. With a proper tuning, this model could be the awaited solution to help companies avoid losses in money lending. 
# Boosting_Algorithms

Algorithms that use boosting techniques to minimize the loss function for both classification and regression problems.

## Algorithm technique

This repo focuses on the two major and best performing boosting algorithms - CatBoost and XGBoost [Xtreme Gradient Boost]
This algorithms minimize the loss functions but calculating the gradient at each model iteration training  and minimizing the error in 
subsequent model trainings.
These algorithms, contrary ensemble algorithms that vote on a particular class, they calculate the weighted mean for each class and use it to generate 
a class accuracy. Hence, they are more accurate compared to ensemble methods. They as well are fast and can work with non-numerical data.

## Performance

The CatBoost algorithm [rmse - 0.3] outperforms the XGB algorithm [rmse - 0.5]
The CatBoost algorithm as well outperforms on the runtime.
