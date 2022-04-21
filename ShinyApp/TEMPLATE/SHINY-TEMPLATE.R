

# SHINY APP SKELETON TEMPLATE

# ============ LIBRARIES
library(shiny)
library(shinythemes)
library(sysfonts)
library(bslib)
library(thematic)
library(ggplot2)
library(tidyverse)
library(plotly)
library(shinyWidgets)

library(NHANES)
starwars = starwars


# ============ UI
ui = fluidPage(
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

  #----- APP TITLE
  titlePanel("Shiny Title")
  # ------------------------------ WIDGETS
  
  
)#fluidPage




# ============ SERVER
server = function(input, output){
  
  # functions inside app
  # Return the requested dataset ----

  
  # Generate a summary of the dataset ----

  # Show the first "n" observations ----

  
}#function









# ============ SHINY APP CALL
shinyApp(ui = ui, server= server)




