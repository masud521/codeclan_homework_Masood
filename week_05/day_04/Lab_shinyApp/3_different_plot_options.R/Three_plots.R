library(shiny)
library(dplyr)
library(ggplot2)
library(CodeClanData)
library(shinyWidgets)



ui <- fluidPage(
    
    titlePanel("Male and Female"),
    
    # use a gradient in background
    setBackgroundColor(
        color = c("#F7FBFF", "#2171B5"),
        gradient = "radial",
        direction = c("top", "left")
    ),
    
    fluidRow(
        column(6,
               radioButtons("Plot",
                            "Plot type",
                            choices = c("Bar", "Pie chart", "Stacked Bar"))
        )
        
       
    ),
    
    mainPanel(
       
            plotOutput("Plot"),
        
               
        )
    )
    

    server <- function(input, output) {
        
        output$Plot <- renderPlot({
            if (input$Plot == "Bar"){
                students_big %>%
                    ggplot() +
                    geom_bar(aes(x = gender, fill = gender))}
            
            if (input$Plot == "Pie chart"){
                students_big %>%
                    ggplot() +
                    geom_bar(aes(x = 1, fill = gender)) +
                    coord_polar("y")}
            
            if (input$Plot == "Stacked Bar"){
                students_big %>%
                    ggplot() +
                    geom_bar(aes(x = 1, fill = gender))}
        })
        
    }

shinyApp(ui = ui, server = server)