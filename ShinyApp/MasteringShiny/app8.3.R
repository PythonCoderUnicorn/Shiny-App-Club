
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

# withProgress({
#   for(i in seq_len(step)){
#       x = function(x)
#       incProgress(1/ length(step))
#   }
#   
# })





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
  
  tableOutput('data'),
  
  # -- progress bar
  h3('progress bar'),
  # numericInput('steps','How many steps ?', 10),
  # actionButton('go','Action !'),
  # textOutput('result'),
  # 
  
  # h3('waiteress !'),
  # waiter::use_waitress(),
  # numericInput('steps1', 'How many steps?', 5),
  # actionButton('go','oh Waitress!'),
  # textOutput('check') # result
  
  h3('waiter !'),
  actionButton('go','call the waiter'),
  textOutput('bill') # result
  
  
  
  
  
  
)
# ===================================== UI




# ===================================== SERVER
server <- function(input, output, session) {


  notify = function(msg, id=NULL){
    showNotification(msg, id=id, duration = NULL, closeButton = NULL)
  }
  
  # -- notifications while loading dataset
  data = reactive({
    id = notify("Reading data ...")
    on.exit( removeNotification(id), add = TRUE)
    Sys.sleep(1)
    
    notify("Processing Bajoran data ...", id=id)
    Sys.sleep(1)
    
    notify("Importing Klingon data ...", id=id)
    Sys.sleep(1)
    
    notify("Refactoring Borg data ...", id=id)
    Sys.sleep(1)
    
    # palmerpenguins::penguins
    mtcars
  })
  
  output$data = renderTable( head( data() ) )
  
  
  
  # -- progress steps
  # steppy = eventReactive(input$go, {
  #   withProgress(message = "Computing random integer", {
  #     for (i in seq_len(input$steps)) {
  #       Sys.sleep(0.5)
  #       incProgress(1 / input$steps)
  #     }
  #     runif(1, min = 1, max = 100)
  #   })
  # })
  # 
  # output$result = renderText( floor( steppy()))

  
  
  # -- waitress
  # dataW = eventReactive(input$go, {
  #   waitress <- waiter::Waitress$new(max = input$steps1, theme = 'overlay', selector = '#steps1')
  #   on.exit( waitress$close() )
  #   
  #   for (i in seq_len(input$steps1)) {
  #     Sys.sleep(0.2)
  #     waitress$inc(1)
  #   }
  #   runif(1, min = 1, max = 100)
  # })
  # 
  # output$check = renderText( floor(dataW() ))
  # 
  
  # -- waiter
  dWaiter = eventReactive(input$go, {
    waiter = waiter::Waiter$new()
    waiter$show()
    on.exit( waiter$hide() )
    Sys.sleep( sample(5, 1))
    runif(1, min = 1, max = 100)
  })
  output$bill = renderText( floor(dWaiter() ))
  
  
  
  

}
# ===================================== SERVER




shinyApp(ui, server)

