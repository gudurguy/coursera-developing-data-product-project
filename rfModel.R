library(caret)
library(randomForest)

#set seed
set.seed(5432)

# Dataset mpg for predicting city and high way mileages
data("mpg")

# To show structure in UI
dataDesc <- capture.output(str(mpg))

#just copy mpg data so as not to mess the original dataset, remove hwy column
cityTrainingData <- mpg[,-9]

# remove cty column
hwyTrainingData <- mpg[,-8]

# Train Random Forest model for predicting "cty" mileage given all other variables in the dataset. 
rfCtyModelFit <- function() {  
  return(
    train(cty ~ ., data = cityTrainingData, method = "rf", trControl = trainControl(method = "cv", 5), ntree = 250)
  )
}

# Train Random Forest model for predicting "hwy" mileage given all other variables in the dataset. 
rfHwyModelFit <- function() {
  return(
    train(hwy ~ ., data = hwyTrainingData, method = "rf", trControl = trainControl(method = "cv", 5), ntree = 250)  
  )
}

# "cty" mileage prediction function given user selected variables
rfCtyPrediction <- function(modelFit, predictors) {
  return(
    predict( modelFit, newdata = predictors)  
  )
}

# "hwy" mileage prediction function given user selected variables
rfHwyPrediction <- function(modelFit, predictors) {
  return(
    predict( modelFit, newdata = predictors)  
  )
}

