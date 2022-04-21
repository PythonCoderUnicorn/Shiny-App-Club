
# ================== MASTERING SHINY

library(shiny)
library(bslib)
library(thematic)
library(ggplot2)

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













#******************************* ESSENTIAL FOR DARK THEME PLOTS
thematic::thematic_shiny() # font="auto"
#*******************************
#







# --- GLOBAL VARIABLE




# ===================================== UI
ui <- navbarPage(
  

  h1("Shiny App 6"),
  # ------------------------------
  theme = bslib::bs_theme(
    version = 4,
    bg = "#28303B", 
    fg = "#ACA8A8", 
    font_scale = NULL, 
    bootswatch = "cosmo"
  ),
  # ------------------------------
  
  h2("Page title"),
  tabPanel('panel 1','one'),
  tabPanel('panel 2','two'),
  tabPanel('panel 3','three'),
  
  navbarMenu('subpanels', 
             tabPanel('panel 4a','4a'),
             tabPanel('panel 4b','4b'),
             tabPanel('panel 4c','4c'),
             ),
  
  
  
 


  
  
  
  
  
  
)
# ===================================== UI




# ===================================== SERVER
server <- function(input, output, session) {


  output$panel <- renderText({
    paste("Current panel: ", input$tabset)
  })
  
  
}
# ===================================== SERVER




shinyApp(ui, server)

