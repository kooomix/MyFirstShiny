#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Predict a child's height using Galton Families"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
        radioButtons("measure", "Unit:", c("inches", "cm")),
       sliderInput("heightM",
                   "Mom's Height:",
                   min = 20,
                   max = 110,
                   value = 65),
       sliderInput("heightD",
                   "Dad's Height:",
                   min = 20,
                   max = 110,
                   value = 65),
       selectInput("gender","gender:",c("Male"="male", "Female"="female")),
       textInput("predictedHeight","Predicted Height:")
       
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
   
            plotOutput("HeightPlot"),
            tags$div(
                HTML("<h2>Overview</h2>"),
                HTML("This shiny app is a simple tool to predict a child's height based on parents height and
                   gender. Prediction is based on GaltonFamilies dataset coming with R."),
                HTML("<h2>Side Bar features</h2>"),
                HTML("In the side bar we can see the possible inputs in order to get our height prediction.
                     In addition, we can choose if we want to view the data in inches or in cm. The possible inputs
                     in the side bar are:<br><br>
                     <b>Unit</b> - the unit we want to see the date, cm or inches.<br>
                     <b>Mom's Height:</b> - height of the mother. <br>
                     <b>Dad's Height:</b> - height of the father. <br>
                     <b>Gender:</b> - gender of the child. <br>"),
                HTML("<h2>Plot</h2>"),
                HTML("The scatterdplot data is based on the GaltonFamilies dataset and represents the height
                     of the child as the outcome (y) and the average height of parents as income (x). The points are 
                     filtered by gender and units are shown in either cm or inches, depending on use choice."),
                HTML("<h3>Linear Model</h3>"),
                HTML("The line over the scatterplot represents a linear model based on the input of the use on the sidebar.
                     On the line there is a black dot which represents the predicted height of the child. The exact predicted
                     value can be seen at the bottom of the left sidebar.")
                
  #rsconnect::deployApp('path/to/your/app')
                  
            )
            
                    
                   
            
    )
  )
))

