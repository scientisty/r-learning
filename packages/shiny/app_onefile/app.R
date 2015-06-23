# Basic template 01-template.R from RStudio Webinar: How to start with Shiny – Part 1
# Single files like this should be called app.R which ends with call to shinyApp,
# or split into ui.R containing shinyUI()
# and server.R containing shinyServer(function(input,output))

library(shiny)

ui <- fluidPage(
  "Hello World"
  # *Input() functions,
  # *Output() functions
)

server <- function(input, output) {}

shinyApp(ui = ui, server = server)
