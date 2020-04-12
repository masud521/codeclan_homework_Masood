
library(shiny)
library(dplyr)
library(ggplot2)
library(CodeClanData)
library(shinyWidgets)

ui <- fluidPage(
    
    fluidRow(
        column(3,
               radioButtons('gender',
                            'Male or Female Dogs?',
                            choices = c("Male", "Female"))
        ),
        
        column(3,
               selectInput("colour",
                           "Which colour?",
                           choices = unique(nyc_dogs$colour))
        ),
        
        column(3,
               selectInput("borough",
                           "Which Borough?",
                           choices = unique(nyc_dogs$borough))  
        ),
        
        column(3,
               selectInput("breed",
                           "Which Breed?",
                           choices = unique(nyc_dogs$breed))
        )
        
    ),
    
    actionButton("update", "Find dogs!"),
    
    tableOutput("table_output")
    
)

server <- function(input, output) {
    
    dog_data <- eventReactive(input$update,{
        
        nyc_dogs %>%
            filter(gender == input$gender)  %>%
            filter(colour == input$colour) %>%
            filter(borough == input$borough) %>%
            filter(breed == input$breed) %>%
            slice(1:10)
        
    })
    
    output$table_output <- renderTable({
        dog_data()
    })
}

shinyApp(ui = ui, server = server)

