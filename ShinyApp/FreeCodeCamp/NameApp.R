
# FREECODECAMP 

# Load R packages
library(shiny)
library(shinythemes)
library(sysfonts)
library(bslib)
library(thematic)

# Define UI
ui <- fluidPage(
  # theme = shinytheme("slate"),
  theme = bslib::bs_theme(
    version = 4,
    base_font = font_google("Poppins", local=TRUE),
    bg = "#282727", 
    fg = "#E0B9FD", 
    font_scale = NULL, 
    bootswatch = "spacelab"
  ),
  
  navbarPage(
    # theme = "cerulean",  # <--- To use a theme, uncomment this
    "My first app",
    tabPanel("Navbar 1",
             # sidebarPanel
             sidebarPanel(
               tags$h3("Input:"),
               textInput("txt1", "First Name:", ""), # txt 1
               textInput("txt2", "Last name:", ""),  # txt 2  sent to server
               ),
             # mainPanel
             mainPanel(
               h1("Header 1"),
               h4("Output 1"),
               verbatimTextOutput("txtout"),
               )), 
    # Navbar 1, tabPanel
    tabPanel("Navbar 2", "This panel is intentionally left blank"),
    tabPanel("Navbar 3", "This panel is intentionally left blank")
    
) # navbarPage
) # fluidPage


#========= Define server function  
server <- function(input, output) {
  
  output$txtout <- renderText({
    paste( input$txt1, input$txt2, sep = " " )
  })
} 


#========== Create Shiny object
shinyApp(ui = ui, server = server)
