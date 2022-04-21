
library(shiny)


# UI ----------------------------------------------------------------------

ui <- fluidPage(
  h1("App 1"),
  
  # ---- adding UI controls
  selectInput("dataset", 
              label = "Select a Dataset", 
              choices = ls("package:datasets")),
  verbatimTextOutput("summary"),
  tableOutput("table"),
  
  h2("exercises"),
  
  
  numericInput("age","What is your computer's age?", value = NA),
  textInput("name","Enter a name"),
  textOutput("greetings"),
  
  # ----- slider calculation 1
  sliderInput("x", label = "if x is",min=1,max=50,value = 4),
  "then x times 5 is",
  textOutput("product"),
  
  
  # ----- slider calculation 2
  sliderInput(inputId = "x", label = "if x is",min=1,max=50,value = 4),
  sliderInput(inputId = "y", label = "y is", min = 1, max = 50, value = 3 ),
  "(x * y) is",
  textOutput("product2")
  
)


# SERVER ------------------------------------------------------------------

server <- function(input, output, session){
  
  # ------- create a reactive expression
  dataset = reactive({
    get(input$dataset,"package:datasets")
  })

  output$summary = renderPrint({
    summary(dataset())
  })
  output$table = renderTable({
    dataset()
  })
  
  
  tableOutput("mtcars")
  output$greeting = renderText({ paste("Hello ",input$name)})
  
  output$histogram = renderPlot({ hist(rnorm(1000))}, res = 96)
  
  # ----- slider calculation 1
  output$product = renderText({ 
      product = input$x * 5
      product
    })
  
  # --- slider calculation 2
  output$product2 = renderText({
    product2 = input$x * input$y
    product2
  })
  
}


# shinyApp function -------------------------------------------------------

shinyApp(ui, server)
