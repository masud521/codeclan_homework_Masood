library(shiny)
library(dplyr)
library(ggplot2)
library(CodeClanData)


ui <- fluidPage(
    
    titlePanel("Five countries medal in Olympic Games"),
    
    tabsetPanel(
        tabPanel("Plot",
    
        plotOutput("medal_plot"))
        
        ),
    
    fluidRow(
        
        tabPanel("Which season",
        
        column(6,
        
             radioButtons("season", 
             tags$i("Winter or summer olympics?"),
                         choices = c("Summer", "Winter"))
            
            ),
            
            column(6,
                   
            radioButtons("medal",
                    tags$i("Which medals?"),
                        choices = c("Gold", "Silver", "Bronze"))
        ),
        
    
        )
    )
)
server <- function(input, output){
    
    output$medal_plot <- renderPlot({ 
        
        olympics_overall_medals %>%
            filter(team %in% c("United States",
                               "Soviet Union",
                               "Germany",
                               "Italy",
                               "Great Britain")) %>%
            filter(medal == input$medal) %>%
            filter(season == input$season) %>%
            ggplot() +
            aes(x = team, y = count, fill = team) +
            geom_col()
    })
    
}
shinyApp(ui = ui, server = server)


