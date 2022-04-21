
# feedback / validation

library(shiny)



# ui <- fluidPage(
#   shinyFeedback::useShinyFeedback(),
#   numericInput("n", "n", value = 10),
#   textOutput("half")
# )
# 
# 
# server <- function(input, output, session) {
#   half <- reactive({
#     even <- input$n %% 2 == 0
#     shinyFeedback::feedbackWarning("n", !even, "Please select an even number")
#     req(even)
#     input$n / 2    
#   })
#   
#   output$half <- renderText(half())
# }




ui <- fluidPage(
  selectInput("language", "Language", choices = c("", "English", "Maori")),
  textInput("name", "Name"),
  textOutput("greeting")
)

server <- function(input, output, session) {
  greetings <- c(
    English = "Hello", 
    Maori = "Kia ora"
  )
  output$greeting <- renderText({
    paste0(greetings[[input$language]], " ", input$name, "!")
  })
}





















shinyApp(ui, server)
