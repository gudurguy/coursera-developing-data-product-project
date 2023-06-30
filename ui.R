library(shiny)
library(dplyr)
library(ggplot2)
library(shinycssloaders)


# Adds support for graphical tooltips and popovers, in order to enrich de UI.
library(shinyBS) 
# Adds Bootstrap themes to a Shiny app.
library(shinythemes)

# dataset for setting the various user widgets
data("mpg")
manufacturers <- unique(mpg$manufacturer)

models <- sort(unique(mpg$model))

minDisp <- min(mpg$displ)
maxDisp <- max(mpg$displ)

years <- sort(unique(mpg$year))

minCylinders <- min(mpg$cyl)
maxCylinders <- max(mpg$cyl)

transmissions <- sort(unique(mpg$trans))

driveType <- sort(unique(mpg$drv))

fuelType <- sort(unique(mpg$fl))

carClass <-sort(unique(mpg$class))



# Default hypothetical car, in order to initialize the UI widgets for the first time.
defaultCar <- data.frame(
  manufacturer = "toyota", 
  model = "camry", 
  displ = 2.2, 
  year = 1999, 
  cyl = 4, 
  trans = "auto(l4)", 
  drv = "f", 
  fl = "r", 
  class = "midsize"
)

shinyUI(
  
  navbarPage(
    
    "Hypothetical Car: City and Highway Mileage Prediction",
    
    theme = shinytheme("paper"),
    
    tabPanel(
      
      "Prediction",
      
      sidebarPanel(
        
        width = 4,
              
        selectInput("manufacturer", "Select Manufacturer", choices = manufacturers, selected=defaultCar$manufacturer),  
        selectInput("model", "Select Model", choices = models, selected=defaultCar$model),
        sliderInput("displ", "Displacement", min = minDisp, max = maxDisp, value = defaultCar$displ, step = 1),
        bsTooltip(id = "disp", title = "Engine displacement (in cu.in.)", placement = "right", options = list(container = "body")),
        selectInput("year", "Select Year", choices = years, selected=defaultCar$year),
        sliderInput("cyl", "Cylinders", min = minCylinders, max = maxCylinders, value = defaultCar$cyl, step = 1),
        bsTooltip(id = "cyl", title = "Number of cylinders in the engine", placement = "right", options = list(container = "body")),
        selectInput("transmission", "Select Transmission", choices = transmissions, selected=defaultCar$trans),
        selectInput("driveType", "Select Drive Type", choices = driveType, selected=defaultCar$drv),
        selectInput("fuelType", "Select Fuel Type", choices = fuelType, selected=defaultCar$fl),
        selectInput("carClass", "Select Car Calss", choices = carClass, selected=defaultCar$class),
        
      ),
    
      mainPanel(
        
        width = 8,
        
        h3("City and Higway Mileage Prediction"),
        br(),
        p("Your Car's City mileage will be: "),
        tableOutput("cityPrediction") %>% withSpinner(color="#0dc5c1"),
        br(),
        p("Your Car's Highway mileage will be: "),
        tableOutput("hwyPrediction") %>% withSpinner(color="#0dc5c1")
      )
    ),
    tabPanel(
      
      "Help",
      p("Two Random Forest prediction models are generated and trained for a specific dataset of cars (see below)."),
      p("Two Random Forest prediction models are needed i.e. one for City Mileage Prediction and one for Highway Mileage Prediction."),
      p("User can change freely with the UI values in order to simulate the parameters of a hypothetical car and be able to predict its mileage for both city and highway runs"),
      p("Dataset used by the application is the from ggplot2 and is called mpg. The data was extracted from the 1998 to 2008 for 38 popular models of cars."
      ),
      tags$div("The dataset description:",
               tags$ul(
                 tags$li(strong("manufacturer"), "Manufacturer Name"),
                 tags$li(strong("model"), "Model Name"),
                 tags$li(strong("displ"), "Engine Displacement, in litres"),
                 tags$li(strong("year"), "Year of Manufacture"),
                 tags$li(strong("cyl", "Number of Cylinders"),
                 tags$li(strong("trans"), "Type of Transmission"),
                 tags$li(strong("drv"), "The type of drive train, where f = front-wheel drive, r = rear wheel drive, 4 = 4wd"),
                 tags$li(strong("cty"), "City Miles per gallon"),
                 tags$li(strong("hwy"), "Highway Miles per gallon"),
                 tags$li(strong("fl"), "Fuel Type"),
                 tags$li(strong("class"), "type of car"))
               ),
               tableOutput("dataDesc")
      )
    ),
    tabPanel(
      "About",
      h3("Developing Data Products course - Assignment Week 4 - Shiny Application"),
      h3("Author: Gudur Guy - June, 2023"),     
      br(),
      p("This application shows an example of making a web application using R and ",
        a(href = "https://shiny.rstudio.com/", "Shiny library"),
        "together, corresponding to the assigment of the week 4,",
        a(href = "https://www.coursera.org/learn/data-products", "Developing Data Products course from Coursera")
      ),
      p("Source code of this application is available at",
        a(href = "https://github.com/gudurguy/coursera-developing-data-product-project",
          "https://github.com/gudurguy/coursera-developing-data-product-project")
      )
    )
  )
)
