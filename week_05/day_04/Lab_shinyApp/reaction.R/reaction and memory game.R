library(shiny)
library(dplyr)
library(ggplot2)
library(CodeClanData)
library(shinyWidgets)


ui <- fluidPage(
    
    titlePanel("Reaction Time vs. Score in Memory Game"),
    
    # use a gradient in background
    setBackgroundColor(
        color = c("#F7FBFF", "#2171B5"),
        gradient = "radial",
        direction = c("top", "left")
    ),
    
    sidebarLayout( 
        sidebarPanel(
            
            radioButtons("colour",
                         "Colour of points",
                         choices = c(Blue = "#3891A6", Yellow = "#FDE74C", Red = "#E3655B")),
            
            sliderInput("bins", 
                        "Transperency of points",
                        min = 0, max = 1, value = 1),
            
            selectInput("shape",
                        "Shape of Points",
                        choices = c( Square = "15", Circle = "16", Triangle = "17")),
            
            textInput("Graph",
                    "Title of Graph","Reaction Time vs. Score in Memory Game")
                       
        ),
        
        fluidRow(
            
            column(6,
        
        
        plotOutput("scatter")
        
        )
        
        ) 
    )
)
    


    

    server <- function(input, output) {
        
        output$scatter <- renderPlot({
            
            students_big %>%
            ggplot() +
                aes(x = reaction_time, y = score_in_memory_game) +
                geom_point(alpha = input$bins, shape = as.integer(input$shape),colour = input$colour)
            
        })
    }
    
    shinyApp(ui = ui, server = server)
   
    
    
    