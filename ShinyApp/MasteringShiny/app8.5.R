
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





#******************************* ESSENTIAL FOR DARK THEME PLOTS
thematic::thematic_shiny(font="auto")
#*******************************
#







# --- GLOBAL VARIABLE






# ===================================== UI
ui <- fluidPage(
  

  h1("Shiny App 8"),
  # ------------------------------
  theme = bslib::bs_theme(
    version = 4,
    bg = "#28303B", 
    fg = "#ACA8A8", 
    font_scale = NULL, 
    bootswatch = "cosmo"
  ),
  # ------------------------------
  

  titlePanel("chapter 8 - user feedback"),

  h2('undoing an action'),
  textAreaInput("message", 
                label = NULL, 
                placeholder = "What's happening?",
                rows = 3
  ),
  actionButton("tweet", "Tweet")
  

  
  
  
)
# ===================================== UI


runLater <- function(action, seconds = 3) {
  observeEvent(
    invalidateLater(seconds * 1000), action, 
    ignoreInit = TRUE, 
    once = TRUE, 
    ignoreNULL = FALSE,
    autoDestroy = FALSE
  )
}

# ===================================== SERVER
server <- function(input, output, session) {

  
  waiting <- NULL
  last_message <- NULL
  
  observeEvent(input$tweet, {
    notification <- glue::glue("Tweeted '{input$message}'")
    last_message <<- input$message
    updateTextAreaInput(session, "message", value = "")
    
    showNotification(
      notification,
      action = actionButton("undo", "Undo?"),
      duration = NULL,
      closeButton = FALSE,
      id = "tweeted",
      type = "warning"
    )
    
    waiting <<- runLater({
      cat("Actually sending tweet...\n")
      removeNotification("tweeted")
    })
  })
  
  observeEvent(input$undo, {
    waiting$destroy()
    showNotification("Tweet retracted", id = "tweeted")
    updateTextAreaInput(session, "message", value = last_message)
  })
  


  

}
# ===================================== SERVER




shinyApp(ui, server)

