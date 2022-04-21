



library(shiny)
library(sysfonts)
library(bslib)
library(thematic)
library(NHANES) # National Health & Nutrition Exam Survey
library(tidyverse)
library(ggplot2)


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
  
  # Application title
  titlePanel("National Health & Nutrition Exam Survey"),
  
  # Sidebar layout with a input and output definitions --------------
  sidebarLayout(
    
    # Inputs: Select variables to plot ------------------------------
    sidebarPanel(
      
      # Select education levels -------------------------------------
      # checkboxGroupInput(inputId = "education",
      #                    label = "Select education level(s):",
      #                    choices = levels(NHANES$Education),
      #                    selected = "College Grad"),
      # 
      # hr(),
      # 
      # Select variable for y-axis ----------------------------------
      selectInput(inputId = "y", 
                  label = "Y-axis:",
                  choices = c("Age", "Poverty", "Pulse", "AlcoholYear", "BPSysAve"), 
                  selected = "BPSysAve"),
      
      # Select variable for x-axis ----------------------------------
      selectInput(inputId = "x", 
                  label = "X-axis:",
                  choices = c("Age", "Poverty", "Pulse", "AlcoholYear", "BPDiaAve"), 
                  selected = "BPDiaAve"),
      
      # Select variable for color -----------------------------------
      selectInput(inputId = "z", 
                  label = "Color by:",
                  choices = c("Gender", "Depressed", "SleepTrouble", "SmokeNow", "Marijuana"),
                  selected = "SleepTrouble"),
      
      # Set alpha level ---------------------------------------------
      sliderInput(inputId = "alpha", 
                  label = "Alpha:", 
                  min = 0,
                  max = 1, 
                  value = 0.5),
      
      # Add checkbox
      checkboxInput(inputId = "showdata",
                    label = "Show data table",
                    value = TRUE)
      
    ),#panel
    
    # Output: Show scatterplot --------------------------------------
    mainPanel(
      paste("Scatterplot"),
      plotOutput(outputId = "scatterplot"),
      br(),
      
      # Print number of obs plotted ---------------------------------
      uiOutput(outputId = "n"),
      br(), br(),    # a little bit of visual separation
      
      #  show table
      DT::dataTableOutput(outputId = "healthTable", height = 500)
    )
  )
)





# Define server function required to create the scatterplot ---------
server <- function(input, output) {
  
  # Create a subset of data filtering for selected title types ------
  NHANES_subset <- reactive({
    req(input$education) # ensure availablity of value before proceeding
    filter(NHANES, Education %in% input$education)
  })
  
  # Create scatterplot object the plotOutput function is expecting --
  output$scatterplot <- renderPlot({
    ggplot(data = NHANES, 
           aes_string(x = input$x, 
                      y = input$y,
                      color= input$z)) +
      geom_point(alpha= input$alpha)+
      theme(axis.text.x = element_text(size=16),
            axis.text.y = element_text(size=16),
            axis.title = element_text(size = 13),
            legend.title = element_text(size = 14),
            legend.text = element_text(size = 13)
            )
    
    # Print number of participants plotted ----------------------------------
    # output$n <- renderUI({
    #   types <- NHANES_subset()$Education %>% 
    #     factor(levels = input$education) 
    #   counts <- table(types)
    #   
    #   HTML(paste("There are", counts, "participants with",
    #              input$education, "degree in this dataset. <br>"))
    # })
    
  #   # print data table
  #   output$healthTable = DT::renderDataTable({
  #     if(input$showdata){
  #       DT::datatable(data = NHANES[,1:7],
  #                     options = list(pageLength= 10,
  #                                    rownames= FALSE))
  #     }
  #   })#DT table
    
    

  })
}






# Create the Shiny app object ---------------------------------------
shinyApp(ui = ui, server = server)



























