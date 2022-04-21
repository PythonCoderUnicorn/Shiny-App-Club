

library(shiny)
library(sysfonts)
library(bslib)
library(thematic)

library(tidyverse)

# librarians
# diamonds
# bechdel

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
  
  
  # h2(textOutput("currentTime")),
  
  # App title ----
  titlePanel("Shiny Text"),
  
  sidebarLayout(
    
    # Sidebar panel for inputs ----
    sidebarPanel(
      
      # Input: Selector for choosing dataset ----
      selectInput(inputId = "dataset",
                  label = "Choose a dataset:",
                  choices = c("penguins", "diamonds", "cars")),
      
      # Input: Numeric entry for number of obs to view ----
      numericInput(inputId = "obs",
                   label = "Number of observations to view:",
                   value = 5)
    ),
    
    # Main panel for displaying outputs ----
    mainPanel(
      
      # Output: Verbatim text for data summary ----
      # verbatimTextOutput("summary"),
      
      # Output: HTML table with requested number of observations ----
      
      tableOutput("view")
      
    )
  )
  

  
)#fluidpage




server <- function(input, output, session) {
  # Return the requested dataset ----
  datasetInput <- reactive({
    switch(input$dataset,
           "penguins" = penguins,
           "diamonds" = diamonds,
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


}






  # Create Shiny app ----
  shinyApp(ui, server)























