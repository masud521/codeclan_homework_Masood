library(shiny)
library(dplyr)
library(ggplot2)
library(CodeClanData)
library(shinyWidgets)


ui <- fluidPage(
    
    titlePanel("Comparing Importance of Internet Access vs. Reducing Pollution"),
    
    
    # use a gradient in background
    setBackgroundColor(
        color = c("#F7FBFF", "#2171B5"),
        gradient = "radial",
        direction = c("top", "left")
    ),
    
    
    sidebarLayout( 
        sidebarPanel(
            
            selectInput("Gender",
                         "Gender",
                         choices = c("Male", "Female")),
            
            
            selectInput("Region",
                        "Region",
                         choices = unique(students_big$region)),
            
            actionButton("Update", "Generate Plots and Table"),
            
            tableOutput("dataTableOutput"),
            
                         
            ),
        
                   
                fluidRow(
                    
                
                column(3,
                              
                    plotOutput("internet_access_histogram")),
                       
                column(3,
                    
                    plotOutput("reducing_pollution_histogram")),
                
               
            )
        
       
       )
   )



server <- function(input, output) {
    
    filtered_data <- reactive({
        students_big %>%
            filter(region == input$Region)
        
    })
    
    output$internet_access_histogram <- renderPlot({
        
        filtered_data() %>%
            ggplot() +
            geom_histogram(aes(x = importance_internet_access)) 
    })
    
    output$reducing_pollution_histogram <- renderPlot({
        
        filtered_data() %>%
            ggplot() +
            geom_histogram(aes(x = importance_reducing_pollution)) 
    })
    
    output$dataTableOutput <- renderTable({
        filtered_data()
    })
    
    
}

shinyApp(ui = ui, server = server)




















