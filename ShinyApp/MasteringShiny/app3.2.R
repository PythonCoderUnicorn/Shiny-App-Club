


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








#******************************* ESSENTIAL FOR DARK THEME PLOTS
thematic::thematic_shiny(font="auto")
#*******************************




library(ggplot2)

freqpoly <- function(x1, x2, binwidth = 0.1, xlim = c(-3, 3)) {
  df <- data.frame(
    x = c(x1, x2),
    g = c(rep("x1", length(x1)), rep("x2", length(x2)))
  )
  
  ggplot(df, aes(x, colour = g)) +
    geom_freqpoly(binwidth = binwidth, size = 1) +
    coord_cartesian(xlim = xlim)
}

t_test <- function(x1, x2) {
  test <- t.test(x1, x2)
  
  # use sprintf() to format t.test() results compactly
  sprintf(
    "p value: %0.3f\n[%0.2f, %0.2f]",
    test$p.value, test$conf.int[1], test$conf.int[2]
  )
}


x1 <- rnorm(100, mean = 0, sd = 0.5)
x2 <- rnorm(200, mean = 0.15, sd = 0.9)

freqpoly(x1, x2)
cat(t_test(x1, x2))
#> p value: 0.065
#> [-0.32, 0.01]















ui <- fluidPage(
  

  h1("Shiny App 3"),
  # ------------------------------
  theme = bslib::bs_theme(
    version = 4,
    bg = "#28303B", 
    fg = "#ACA8A8", 
    font_scale = NULL, 
    bootswatch = "cosmo"
  ),
  # ------------------------------
  

  titlePanel("chapter 3"),
  
  
  fluidRow(
    # ---------- column
    column(
      4, 
      "Distribution 1",
      numericInput("n1", label = "n", value = 1000, min = 1),
      numericInput("mean1", label = "µ", value = 0, step = 0.1),
      numericInput("sd1", label = "σ", value = 0.5, min = 0.1, step = 0.1)
      ),
    # ---------- column
    column(4, 
    "Distribution 2",
    numericInput("n2", label = "n", value = 1000, min = 1),
    numericInput("mean2", label = "µ", value = 0, step = 0.1),
    numericInput("sd2", label = "σ", value = 0.5, min = 0.1, step = 0.1)
    ),
    # ---------- column
    column(4, 
           "Frequency polygon",
           numericInput("binwidth", label = "bin width", value = 0.1, step = 0.1),
          sliderInput("range", label = "range", value = c(-3,3), min = -5, max = 5)
          )
    ),
  
  fluidRow(
    column(9, plotOutput('hist')),
    column(3, verbatimTextOutput('ttest'))
  ),
  
  # ---- observeEvent debugging
  textInput("name","Enter a name:"),
  textOutput("name entered")

  
  
)






server <- function(input, output, session) {

  # ====== reactive function to store results in variable to act like a function
  x1 = reactive( rnorm(input$n1, input$mean1, input$sd1))
  x2 = reactive( rnorm(input$n2, input$mean2, input$sd2))
  
  output$hist = renderPlot({
    
    # --- call the x1, x2 like functions
    freqpoly(x1(), 
             x2(),
             binwidth = input$binwidth,
             xlim = input$range
             )}, 
    res = 96
    )
  
  output$ttest = renderText({ t_test( x1(), x2() ) })
  
  
  # --- debugging 
  string = reactive( paste("you entered a name ", input$name, "!"))
  
  output$string = renderText( string() )
  # OBSERVE
  observeEvent( eventExpr = input$name, handlerExpr = {message("name variable stored")} )
  
  
  
}

shinyApp(ui, server)

