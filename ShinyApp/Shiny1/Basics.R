
# ================================================= Shiny framework
library(shiny)

# ui <- fluidPage(
#   # front end interface
# )
# 
# server <- function(input, output, session) {
#   # back end logic
# }
# 
# shinyApp(ui, server)
# =================================================


# SPELLING MATTERS, APP WON'T RUN WITH TYPOS


# functions like sliderInput(), selectInput(), textInput(), and numericInput()

# ------ FUNCTIONS
sliderInput("min", "Limit (minimum)", value = 50, min = 0, max = 100)

animals <- c("dog", "cat", "mouse", "bird", "other", "I hate animals")


# ------- PAGE ELEMENTS
ui <- fluidPage(
  
  # # ------------------------------------
  # textInput("name", "What's your name?"),
  # passwordInput("password", "What's your password?"),
  # textAreaInput("story", "Tell me about yourself", rows = 3)
  # # ---------------------------------
  
  # numericInput("num", "Number one", value = 0, min = 0, max = 100),
  # sliderInput("num2", "Number two", value = 50, min = 0, max = 100),
  # sliderInput("rng", "Range", value = c(10, 20), min = 0, max = 100),

  # dateInput("dob", "When were you born?"),
  # dateRangeInput("holiday", "When do you want to go on vacation next?")
  
  # selectInput("state", "What's your favourite state?", state.name),
  # radioButtons("animal", "What's your favourite animal?", animals)
  
  # selectInput( # this allows user to keep adding states into box
  #   "state", "What's your favourite state?", state.name,
  #   multiple = TRUE )
  
  # checkboxGroupInput("animal", "What animals do you like?", animals)
  
  # checkboxInput("cleanup", "Clean up?", value = TRUE),
  # checkboxInput("shutdown", "Shutdown?")
  
  # fileInput("upload", NULL)
  
  #-- paired with observeEvent() or eventReactive() 
  # actionButton("click", "Click me!"),
  # actionButton("drink", "Drink me!", icon = icon("cocktail"))
  # 
  
  # fluidRow(
  #   actionButton("click", "Don't Click me!", class = "btn-lg btn-danger"),
  #   actionButton("click", "Click here!", class = "btn-lg btn-success") ),
  #   fluidRow(actionButton("eat", "Submit", class = "btn-block") )
  
  
  # --- text output
  # textOutput("text"),
  # verbatimTextOutput("code")
  
  # tableOutput("static"),
  # dataTableOutput("dynamic")
  
  plotOutput("plot", width = "400px")
  
  
  
  
  
)
  
server <- function(input, output, session) {
  # output$text <- renderText({ "Hello friend!" })
  # output$code <- renderPrint({ summary(1:10) })
  # output$print <- renderPrint("hello!")
  
  output$static <- renderTable(head(mtcars))
  output$dynamic <- renderDataTable(mtcars, options = list(pageLength = 5))
  
  output$plot <- renderPlot(plot(1:5), res = 96)
}
shinyApp(ui, server)







# ========================= reactivity

library(shiny)

ui <- fluidPage(
  #--------------------------------- front end interface
  # - input objects are read-only
  numericInput("count", label = "Number of values", value = 100),
  textInput("name", "What's your name?"),
  
  # - output 
  textOutput("greeting")
  
  
)

# --------------------------------------------- server
server <- function(input, output, session) {
  # 
  # - output greeting
  output$greeting <- renderText("Hello human!")
  
  output$greeting <- renderText({ paste0("Hello ", input$name, "!") })

  
  
}
# --------------------------------------------- execute app
shinyApp(ui, server)





































