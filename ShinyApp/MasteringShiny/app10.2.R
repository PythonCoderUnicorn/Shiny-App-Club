
# ================== MASTERING SHINY

library(shiny)
library(bslib)
library(thematic)
library(ggplot2)
library(tidyverse)


#  IMPERATIVE PROGRAMMING = specific commands and executed immediately
#  DECLARATIVE PROGRAMMING = express/ declare constraints on programming, decision is to be made

# Shiny app is a declarative 
# watch out for typos ! no error code returned
# make sure that reactive expressions and outputs only refer to things defined above, not below
# 

# whenever you copy and paste something once, you should consider extracting 
# the repeated code out into a reactive expression ==> efficiency & easier to read/ understand

# not using reactive functions, all variables/data is calculated only once, x1 won't know about x2

# reactiveTimer() depends on hidden input of time. inside the server function
# timer = reactiveTimer(500)    # ms is 2x per second, changes plot
#  x1 = reactive({ timer()  rpois(input$n, input$lambda1 )})

# actionButton()  deals with user constantly clicking buttons and app is running calculations
#  inside the fluidPage function   actionButton("simulate", "Simulate!") but this also leaves 
# dependencies on variables = not ideal
# **** USE eventReactive() to handle all changes and triggering of app





# debugging ---------------------------------------------------------------

# for DEBUGGING use observeEvent()
# args: eventExpr (input od dependency) and handlerExpr (code to be run)

# string = reactive( paste("you entered a name ", input$name, "!"))
# 
# output$string = renderText( string() )
# # OBSERVE
# observeEvent( eventExpr = input$name, handlerExpr = {message("name variable stored")} )


# workflow ----------------------------------------------------------------

# BUILD YOUR APP PROTOTYPE AS SIMPLE AS POSSIBLE
# do a few pencil-and-paper sketches to rapidly explore the UI 
# and reactive graph before committing to code.

# good idea to clean up EDA code before coding Shiny app code



# fluidpage HTML ----------------------------------------------------------

# fluidPage() sets all the HTML, CSS, Javascript
# fixedPage() has max width 
# fillPage() uses height of browser, for full screen plots


#             -- single page --
# fluidPage
# titlePanel
# -----------------------------
# sidebarLayout
#   [sidebarPanel] [mainPanel]
# 
# ----------------------------




# plotOutput --------------------------------------------------------------

# interactive graphics
# click, dblclick , hover, brush

# plotOutput('plot', click = 'plot_click')
# input$plot_click

# brush  (xmin, xmax, ymin, and ymax)


# renderImage https://shiny.rstudio.com/articles/images.html




# user feedback -----------------------------------------------------------
# validation  (input)
# notification (messages)
# progress bars
# confirmation dialogues 
# 

# shinyFeedback  / waiter  / shinyvalidate

# feedback(), feedbackWarning(), feedbackDanger(), and feedbackSuccess()

# showNotification() : for fixed amt of time/ when a process starts & ends/ progress update

# progress bars : withProgress()  incProgress() 



# uploads & downloads -----------------------------------------------------

# fileInput('upload','Upload a file')

# name (of file) 
# size (of file in bytes)
# type 
# datapath  (where the data has been uploaded)




# dynamic UI --------------------------------------------------------------

#  3 techniques : update, tabsetPanel(), uiOutput()

# update inputs:  updateTextInput()











#******************************* ESSENTIAL FOR DARK THEME PLOTS
thematic::thematic_shiny(font="auto")
#*******************************
#







# --- GLOBAL VARIABLE









# ===================================== UI
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
  

  h1("Shiny App 10"),
  titlePanel("chapter 10 - interrelated inputs"),


  h3('temperature conversion'),
  numericInput("temp_c", "Celsius", NA, step = 1),
  numericInput("temp_f", "Fahrenheit", NA, step = 1),
  
  
  h3('dynamic visbility'),
  
  sidebarLayout(
    sidebarPanel(
      selectInput("controller", "Show", choices = paste0("panel", 1:3))
    ),
    mainPanel(
      tabsetPanel(
        id = "switcher",
        type = "hidden",
        tabPanelBody("panel1", "Panel 1 content"),
        tabPanelBody("panel2", "Panel 2 content"),
        tabPanelBody("panel3", "Panel 3 content") )
    )
  ),
  
  
  h3('wizard interface'),
  tabsetPanel(
    id= 'wizard',
    type= 'hidden',
    tabPanel('page_1', 'Welcome!', actionButton('page_12', 'next')),
    tabPanel('page_2', 'page 2', actionButton('page_21', 'prev')),
    tabPanel('page_3', 'end', actionButton('page_32', 'prev')),
  ),
  
  
  
  h3('input controls'),
  textInput("label", "label"),
  selectInput("type", "type", c("slider", "numeric")),
  uiOutput("numeric")


  
  
)
# ===================================== UI





# ===================================== SERVER
server <- function(input, output, session) {


  # -- temp conversion
  observeEvent(input$temp_f, {
    c <- round((input$temp_f - 32) * 5 / 9)
    updateNumericInput(inputId = "temp_c", value = c)
  })
  
  observeEvent(input$temp_c, {
    f <- round((input$temp_c * 9 / 5) + 32)
    updateNumericInput(inputId = "temp_f", value = f)
  })
  
  
  # -- drop down tab selection
  observeEvent(input$controller, {
    updateTabsetPanel(inputId = "switcher", selected = input$controller)
  })
  
  
  # -- wizard
  switch_page <- function(i) {
    updateTabsetPanel(inputId = "wizard", selected = paste0("page_", i))
  }
  
  observeEvent(input$page_12, switch_page(2))
  observeEvent(input$page_21, switch_page(1))
  observeEvent(input$page_23, switch_page(3))
  observeEvent(input$page_32, switch_page(2))
  
  
  
  output$numeric <- renderUI({
    if (input$type == "slider") {
      sliderInput("dynamic", input$label, value = 0, min = 0, max = 10)
    } else {
      numericInput("dynamic", input$label, value = 0, min = 0, max = 10) 
    }
  })
  

}
# ===================================== SERVER




shinyApp(ui, server)

