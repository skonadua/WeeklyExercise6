#Cumulative State Covid Data Shiny

library(shiny)
library(tidyverse)
covid19 <- read_csv("https://raw.githubusercontent.com/nytimes/covid-19-data/master/us-states.csv")

stateslist <- covid19 %>% 
  select(state) %>% 
  dplyr::distinct() %>% 
  arrange(state) %>% 
  pull(state) 

# Define UI for application that draws a histogram
ui <- fluidPage("Stephanie Konadu-Acheampong",

    # Application title
    titlePanel("Comparison of Cumulative COVID Case Numbers Over Time (by State)"),

    selectInput("state", 
                "State", 
                choices = stateslist,
                multiple = TRUE),
    submitButton(text = "Create my plot!"),
    
    plotOutput("dateplot")
    )

server <- function(input, output) {
  output$dateplot <- renderPlot({
    covid19 %>% 
      filter(cases >= 20,
             state %in% input$state) %>% 
      ggplot() +
      geom_line(aes(x = date, y = cases, color = state)) +
      theme_minimal() +
      scale_y_log10(breaks = 
                      scales::trans_breaks(
                        "log10", function(x)10^x),
                    labels = scales::comma)
  })
}

shinyApp(ui = ui, server = server)
    
  