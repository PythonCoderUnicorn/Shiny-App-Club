


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
  titlePanel("Shiny Title"),
  # ------------------------------ WIDGETS
  
  # Sidebar layout with a input and output definitions ----
  sidebarLayout(
    
    # Sidebar panel for inputs ----
    sidebarPanel(
      
      # Input: Selector for choosing dataset ----
      selectInput(inputId = "dataset",
                  label = "Choose a dataset:",
                  choices = c("rock", "pressure", "cars")),
      
      # Input: Numeric entry for number of obs to view ----
      numericInput(inputId = "obs",
                   label = "Number of observations to view:",
                   value = 10)
    ),
    
    # Main panel for displaying outputs ----
    mainPanel(
      
      # Output: Verbatim text for data summary ----
      verbatimTextOutput("summary"),
      
      # Output: HTML table with requested number of observations ----
      tableOutput("view")
      
    ),)
  
)#fluidPage




# ============ SERVER
server = function(input, output){
  
  # functions inside app
  # Return the requested dataset ----
  datasetInput <- reactive({
    switch(input$dataset,
           "rock" = rock,
           "pressure" = pressure,
           "cars" = cars)
  })
  
  # Generate a summary of the dataset ----
  output$summary <- renderPrint({
    dataset <- datasetInput()
    summary(dataset)
  })
  
  # Show the first "n" observations ----
  output$view <- renderTable({
    head(datasetInput(), n = input$obs)
  })
  
}#function









# ============ SHINY APP CALL
shinyApp(ui = ui, server= server)




