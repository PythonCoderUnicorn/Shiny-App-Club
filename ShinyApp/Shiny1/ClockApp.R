


library(shiny)
library(sysfonts)
library(bslib)
library(thematic)
library(tidyverse)
library(palmerpenguins)

library(DT)

library(fivethirtyeight)
bechdel = fivethirtyeight::bechdel
penguins = palmerpenguins::penguins
diamonds = diamonds

# Define UI for displaying current time ----
ui <- fluidPage(
  
  # --------------------------- theme
  theme = bslib::bs_theme(
    version = 4,
    base_font = font_google("Poppins", local=TRUE),
    bg = "#282727", # soft black
    fg = "#E0B9FD", # purple
    font_scale = NULL,
    bootswatch = "spacelab"),
  # ---------------------------

  #******************************* ESSENTIAL FOR DARK THEME PLOTS
  thematic::thematic_shiny(),
  #*******************************
  
  
  h2(textOutput("currentTime")),
  
  # App title ----
  titlePanel("Shiny Text"),
  
)#fluidpage

# Define server logic to show current time, update every second ----
server <- function(input, output, session) {
  
  output$currentTime <- renderText({
    invalidateLater(3000, session)
    paste("The current time is", Sys.time())
  })
  
  
 


}#function





# Create Shiny app ----
shinyApp(ui, server)