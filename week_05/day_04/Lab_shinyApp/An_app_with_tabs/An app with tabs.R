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
            
            selectInput("gender",
                         "Gender",
                         choices = c(Male = "M", Female = "F")),
            
            
            selectInput("region",
                        "Region",
                         choices = unique(students_big$region)
                    
                  ),
            
            # Action buttons and data
            
            actionButton("update", "Generate Plots and Table")
            
             ),
        
            mainPanel(
             tabsetPanel(
               tabPanel("Plots",
             
                fluidRow(
                  
                     column(6,
                              
                    plotOutput("internet_access_histogram")),
                       
                      column(6,
                    
                    plotOutput("reducing_pollution_histogram"))
                
              )
          ),
          
        tabPanel("Data",
                 
                dataTableOutput("tableoutput"))
        
             )
          ) 
        )
      )
          
  

server <- function(input, output) {
    
    filtered_data <- eventReactive(input$update, {
        students_big %>%
             filter(gender == input$gender) %>%
             filter(region == input$region) %>%
        select(
          region,gender,
          importance_internet_access,importance_reducing_pollution)
      
    })
    
    output$internet_access_histogram <- renderPlot({
        
        filtered_data() %>%
            ggplot() +
            aes(x = importance_internet_access) +
            geom_histogram()
    })
    
    output$reducing_pollution_histogram <- renderPlot({
        
        filtered_data() %>%
            ggplot() +
            aes(x = importance_reducing_pollution) +
            geom_histogram()
    })
    
    output$tableoutput <- renderDataTable({
        filtered_data()
    })
    
  }

shinyApp(ui = ui, server = server)




















