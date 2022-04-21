
# ================== MASTERING SHINY

library(shiny)
library(bslib)
library(thematic)


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


# for DEBUGGING use observeEvent()
# args: eventExpr (input od dependency) and handlerExpr (code to be run)

# --- debugging 
# string = reactive( paste("you entered a name ", input$name, "!"))
# 
# output$string = renderText( string() )
# # OBSERVE
# observeEvent( eventExpr = input$name, handlerExpr = {message("name variable stored")} )


# BUILD YOUR APP PROTOTYPE AS SIMPLE AS POSSIBLE
# do a few pencil-and-paper sketches to rapidly explore the UI 
# and reactive graph before committing to code.

# good idea to clean up EDA code before coding Shiny app code


#******************************* ESSENTIAL FOR DARK THEME PLOTS
thematic::thematic_shiny(font="auto")
#*******************************
#



# traceback/ call stack debugging -----------------------------------------------------
f = function(x) g(x) 
g = function(x) h(x) 
h = function(x) x*2 

# f('a')
# Error in x * 2 : non-numeric argument to binary operator
# traceback()
# 3: h(x) at #1
# 2: g(x) at #1
# 1: f("a")




# --- GLOBAL VARIABLE




# ===================================== UI
ui <- fluidPage(
  

  h1("Shiny App 5"),
  # ------------------------------
  theme = bslib::bs_theme(
    version = 4,
    bg = "#28303B", 
    fg = "#ACA8A8", 
    font_scale = NULL, 
    bootswatch = "cosmo"
  ),
  # ------------------------------
  

  titlePanel("chapter 5 :: workflow, debug"),
  
  selectInput('n', "N", 1:10),
  plotOutput("plot")


  
  
)
# ===================================== UI




# ===================================== SERVER
server <- function(input, output, session) {



  
  
}
# ===================================== SERVER




shinyApp(ui, server)

