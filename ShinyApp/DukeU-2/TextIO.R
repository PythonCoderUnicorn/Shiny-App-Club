

library(shiny)
library(sysfonts)
library(bslib)
library(thematic)
library(tidyverse)
library(ggplot2)

# have file in local folder directory
load("movies.RData")



ui <- fluidPage(
  theme = bslib::bs_theme(
    version = 4,
    base_font = font_google("Poppins", local=TRUE),
    bg = "#282727", # soft black
    fg = "#E0B9FD", # purple
    font_scale = NULL, 
    bootswatch = "spacelab",
    
  ),
  
  # bs_theme_preview(),
  
  #******************************* ESSENTIAL FOR DARK THEME PLOTS
  thematic::thematic_shiny(),
  #*******************************
  
  titlePanel("Text Input"),
  
  textInput(
    inputId = "custom_text",
    label = "input text"
  ),
  
  strong("Text is shown below:"),
  
  paste(outputId = "output text")
  
)


server <- function(input, output, session){
  
  output$user_text <- renderText({ input$custom_text} )
  
}

shinyApp(ui = ui, server = server)




















