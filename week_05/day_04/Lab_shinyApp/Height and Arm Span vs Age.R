library(shiny)
library(dplyr)
library(ggplot2)
library(CodeClanData)
library(shinyWidgets)


ui <- fluidPage(
    
    titlePanel("The height and arm-span for children of different ages"),
    
    setBackgroundColor(
        color = c("#F7FBFF", "#2171B5"),
        gradient = "radial",
        direction = c("top", "left")
    ),

    
    fluidRow(
        
        
        column(6,
               
            radioButtons("age_input","Age",inline = TRUE,
                        choices = unique(students_big$ageyears))
               
        ) 
        
    ),
    
    fluidRow(
        column(6,
               plotOutput("height_histogram")
        ),
        
        column(6,
               plotOutput("arm_span_histogram")
        )
    )
)

server <- function(input, output) {
    
    filtered_data <- reactive({
        students_big %>%
            filter(ageyears == input$age_input) 
            
        
    })
    
    output$height_histogram <- renderPlot({
        
        filtered_data() %>%
            ggplot() +
            geom_histogram(aes(x = height)) 
    })
    
    output$arm_span_histogram <- renderPlot({
        
        filtered_data() %>%
            ggplot() +
            geom_histogram(aes(x = arm_span)) 
    })
}
shinyApp(ui = ui, server = server)

