library(shiny)
library(ggplot2)
library(curl)

# load data
data("diamonds")

# Defining server logic for initial plot
shinyServer(function(input, output) {
    
    
    model1pred <- reactive({
        # subset the data based on the inputs
        diamonds_sub <- subset(diamonds, cut == input$cut &
                                   color == input$color &
                                   clarity == input$clarity)
        model1 <- lm(price~carat,data=diamonds_sub)
        
        
        predict(model1, newdata = data.frame(carat = input$lm))
    })
    
    output$distPlot <- renderPlot({
        diamonds_sub <- subset(diamonds, cut == input$cut &
                                   color == input$color &
                                   clarity == input$clarity)
        # plot the diamond data with carat and price
        p <- ggplot(data = diamonds_sub, aes(x = carat, y = price)) + geom_point()
        p <- p + geom_smooth(method = "lm") + xlab("Carat") + ylab("Price")
        p <- p + xlim(0, 4) + ylim (0, 20000)
        p
    }, height = 400)
    
    output$pred1 <- renderText({
        model1pred()
    })
    })