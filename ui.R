# Load libraries ---------------------------------------------------------------
library(shiny)
library(shinythemes)
library(ggplot2)

#Load data
data("diamonds")

# Adjustments
h3.align <- 'center'

# Define UI for application that draws a histogram
shinyUI(fluidPage(

    # Application title
    titlePanel("Diamonds - Cost depends on Carat, Cut, Color, and Clarity"),
    
    # Pick a bootstrap theme from https://rstudio.github.io/shinythemes/
    theme = shinytheme("flatly"),

    # Sidebar with a slider input for number of variables
    sidebarLayout(
        sidebarPanel(h4("Choose Diamond Factors"),
                     selectInput("cut", "Cut", (sort(unique(diamonds$cut), decreasing = T))),
                     selectInput("color", "Color", (sort(unique(diamonds$color)))),
                     selectInput("clarity", "Clarity", (sort(unique(diamonds$clarity), decreasing = T))),
                     sliderInput("lm", "Carat",
                                 min = min(diamonds$carat), max = max(diamonds$carat),
                                 value = max(diamonds$carat) / 2, step = 0.1),
                     submitButton("Submit")),
        

    # Show a plot of the carat/price relationship
        mainPanel(
            h3("Price/Carat Relationship"), 
            plotOutput("distPlot"),
    h3("Predicted price :"),
    textOutput("pred1")
           )
    
        )))