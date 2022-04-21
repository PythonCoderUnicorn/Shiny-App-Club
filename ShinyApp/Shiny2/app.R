#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(shinythemes)
library(sysfonts)
library(bslib)
library(thematic)
library(ggplot2)
library(tidyverse)
library(plotly)
library(shinyWidgets)


# Define UI for application that draws a histogram
ui <- fluidPage(
    # ------------------------------ theme
    # choose color themes, 
    # then place code in bs_theme()
    # bs_theme_preview(),
    theme = bslib::bs_theme(
        version = 4,
    bg = "#28303B",
    fg = "#ACA8A8",
    font_scale = NULL,
    bootswatch = "cosmo"
        # ------------------------------
    ),
    
    #******************************* ESSENTIAL FOR DARK THEME PLOTS
    thematic::thematic_shiny(),
    #*******************************
   
    
    # Application title
    titlePanel("Old Faithful Geyser Data"),

    # Sidebar with a slider input for number of bins 
    sidebarLayout(
        sidebarPanel(
            sliderInput("bins",
                        "Number of bins:",
                        min = 1,
                        max = 50,
                        value = 30)
        ),

        # Show a plot of the generated distribution
        mainPanel(
           plotOutput("distPlot")
        )
    ),
)

# Define server logic required to draw a histogram
server <- function(input, output) {

    output$distPlot <- renderPlot({
        # generate bins based on input$bins from ui.R
        x    <- faithful[, 2]
        bins <- seq(min(x), max(x), length.out = input$bins + 1)

        # draw the histogram with the specified number of bins
        hist(x, breaks = bins, col = 'darkgray', border = 'white')
    })
}

# Run the application 
shinyApp(ui = ui, server = server)
