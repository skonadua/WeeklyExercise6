#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(tidyverse)
covid19 <- read_csv("https://raw.githubusercontent.com/nytimes/covid-19-data/master/us-states.csv")

# Define UI for application that draws a histogram
ui <- fluidPage("A State by State Comparison of",

    # Application title
    titlePanel("Cumulative COVID Case Numbers Over Time"),

    sliderInput(inputId = "date", 
                label = "Date",
                min = 2020-01-21, 
                max = 2021-03-01, 
                value = c(2020-01-21,2021-03-01),
                sep = ""),
    selectInput("state", 
                "State", 
                choices = list()),
    submitButton(text = "Create my plot!"),
    plotOutput(outputId = "dateplot")
)

server <- function(input, output) {
  output$dateplot <- renderPlot({
    covid19 %>% 
      filter(state == input$state) %>% 
      ggplot() +
      geom_line(aes(x = date, y = cases)) +
      scale_x_continuous(limits = input$years) +
      theme_minimal()
  })
}

shinyApp(ui = ui, server = server)
    
    
#     # Sidebar with a slider input for number of bins 
#     sidebarLayout(
#         sidebarPanel(
#             sliderInput("bins",
#                         "Number of bins:",
#                         min = 1,
#                         max = 50,
#                         value = 30)
#         ),
# 
#         # Show a plot of the generated distribution
#         mainPanel(
#            plotOutput("distPlot")
#         )
#     )
# )
# 
# # Define server logic required to draw a histogram
# server <- function(input, output) {
# 
#     output$distPlot <- renderPlot({
#         # generate bins based on input$bins from ui.R
#         x    <- faithful[, 2]
#         bins <- seq(min(x), max(x), length.out = input$bins + 1)
# 
#         # draw the histogram with the specified number of bins
#         hist(x, breaks = bins, col = 'darkgray', border = 'white')
#     })
# }
# 
# # Run the application 
# shinyApp(ui = ui, server = server)
