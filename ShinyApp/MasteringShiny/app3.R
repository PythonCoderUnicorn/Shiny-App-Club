


library(shiny)
library(bslib)
library(thematic)


#  IMPERATIVE PROGRAMMING = specific commands and executed immediately
#  DECLARATIVE PROGRAMMING = express/ declare constraints on programming, decision is to be made

# Shiny app is a declarative 
# watch out for typos ! no error code returned
# make sure that reactive expressions and outputs only refer to things defined above, not below
# 



#******************************* ESSENTIAL FOR DARK THEME PLOTS
thematic::thematic_shiny(font="auto")
#*******************************



ui <- fluidPage(
  

  h1("Shiny App 3"),
  theme = bslib::bs_theme(
    version = 4,
    bg = "#28303B", 
    fg = "#ACA8A8", 
    font_scale = NULL, 
    bootswatch = "cosmo"
    # ------------------------------
  ),
  

  titlePanel("chapter 3"),
  
  numericInput(inputId = "count", label = "Number of values", value=100),
  
  
  
  h4("exercise, fix errors"), 
  textInput("name", "What's your name?"),
  textOutput("greeting"),
  textOutput("bye"),
  
  textOutput("a"),
  textOutput("b"),
  textOutput("d")
  
  
)

server <- function(input, output, session) {

  # output$greeting <- renderText({
  #   paste0("Hello ", input$name, "!")
  # })
  # 
  # output$greeting <- renderText(string())
  # string <- reactive(paste0("Hello :: ", input$name, "!"))
  
  # output$greeting <- renderText({paste0("Hello // ", input$name)})
  
  # output$greeting = renderText(string())
  # string =   reactive( paste0(" heyyy ", input$name)  )
  
  # output$greeting <- renderText( string())
  # string = reactive( paste0("Hello \\ ", input$name))
  # 
  # output$bye = renderText({
  #   paste0("bye ", input$name)
  # })
  

  
  
  
  
  
  
  
  
}

shinyApp(ui, server)

