library(shiny)
library(ggplot2)
library(caret)
library(randomForest)

#
# Defines the Random Forest model and predictors for city and high way mileage in the 'mpg' dataset.
#
source(file = "rfModel.R")

#
# Setting up Shiny Server
#
shinyServer(
  
  function(input, output, session) {
    
    # To show new lines in the browser
    decoratedDataDesc <- paste0(dataDesc, collapse = "<br/>")
    output$dataDesc <- renderText({decoratedDataDesc})
    
    # Train city mileage model once 
    rfCtyModel <- rfCtyModelFit()
    
    # Train Highway mileage model once
    rfHwyModel <- rfHwyModelFit()

    # prediction for city mileage
    predictCityMpg <- reactive({
      
      carToPredict <- data.frame(
        manufacturer = input$manufacturer, 
        model = input$model, 
        displ = as.numeric(input$displ), 
        year = as.integer(input$year), 
        cyl = as.integer(input$cyl), 
        trans = input$transmission,  
        drv = input$driveType, 
        fl = input$fuelType,
        class = input$carClass)
      
      rfCtyPrediction(rfCtyModel, carToPredict)
      
    })
    
    # prediction for highway mileage
    predictHwyMpg <- reactive({
      
      carToPredict <- data.frame(
        manufacturer = input$manufacturer, 
        model = input$model, 
        displ = as.numeric(input$displ), 
        year = as.integer(input$year), 
        cyl = as.integer(input$cyl), 
        trans = input$transmission, 
        drv = input$driveType, 
        fl = input$fuelType,
        class = input$carClass)
      
      rfHwyPrediction(rfHwyModel, carToPredict)
      
    })
    
    # render results
    output$cityPrediction <- renderTable({
      predictCityMpg()
    })
    
    # render results
    output$hwyPrediction <- renderTable({
      predictHwyMpg()
    })
    
  }
  
)