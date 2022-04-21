
library(shiny)
library(shinycssloaders)
library(bslib)
library(thematic)
library(ggplot2)

#******************************* ESSENTIAL FOR DARK THEME PLOTS
thematic::thematic_shiny(font="auto")
#*******************************




ui <- fluidPage(
  # ------------------------------
  theme = bslib::bs_theme(
    version = 4,
    bg = "#28303B", 
    fg = "#ACA8A8", 
    font_scale = NULL, 
    bootswatch = "cosmo"
  ),
  # ------------------------------
  
  
  h2('Chapter 8 - spinners'),
  h3('shinycssloaders'),
  actionButton("go", "go"),
  withSpinner(plotOutput("plot")),
)
server <- function(input, output, session) {
  data <- eventReactive(input$go, {
    Sys.sleep(3)
    data.frame(x = runif(50), y = runif(50))
  })
  
  output$plot <- renderPlot(plot(data()), res = 96)
}


shinyApp(ui, server)