#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(HistData)
# Define server logic required to draw a scatterplot
shinyServer(function(input, output, session) {
        
        
        measureMultiplier <- reactive({
                if(input$measure=="cm")
                        x<-2.54
                else
                        x<-1
                
                updateSliderInput(session,
                                  "heightM",
                                  min = 60*x,
                                  max = 110*x,
                                  value = 65*x)
                
                updateSliderInput(session,
                                  "heightD",
                                  min = 60*x,
                                  max = 110*x,
                                  value = 65*x)
                x
                

        })
   
        
  output$HeightPlot <- renderPlot({
          data(GaltonFamilies)
          GaltonFamilies$midparentHeight <- GaltonFamilies$midparentHeight*measureMultiplier()
          GaltonFamilies$childHeight <- GaltonFamilies$childHeight*measureMultiplier()
          inp_midparentheight <- (input$heightD+input$heightM*1.08)/2
          inp_gender <- input$gender
          
          newData <- subset(GaltonFamilies,gender==inp_gender)
          fit <- lm(childHeight ~ midparentHeight,data=newData)
          
         updateTextInput(session,"predictedHeight",value=as.character(fit$coefficients[1] + fit$coefficients[2]*inp_midparentheight))
          
        plot(jitter(newData$childHeight) ~ newData$midparentHeight,
             xlab="Average Height of the Parents",
             ylab="Height of the Child",
             main=paste(inp_gender, "Scatterplot of Galton Family Data with Fitted Values\n","in ",input$measure ),
             pch=19,frame.plot=FALSE,
             col=("light blue"))
        
        lines(newData$midparentHeight,fitted(fit),col="violet",lwd=2)
        points(inp_midparentheight, fit$coefficients[1] + fit$coefficients[2]*inp_midparentheight, pch=10, lwd=5)
        
    
  })
  

  
})
