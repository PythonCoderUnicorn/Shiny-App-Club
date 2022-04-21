
library(shiny)


# UI ----------------------------------------------------------------------

ui <- fluidPage(
  h1("App 1"),
  
  # ---- adding UI controls
  selectInput("dataset", 
              label = "Select a Dataset", 
              choices = ls("package:datasets")),
  verbatimTextOutput("summary"),
  tableOutput("table")
  
)


# SERVER ------------------------------------------------------------------

server <- function(input, output, session){
  
  # ------- add behavior
  output$summary = renderPrint({
    dataset = get(input$dataset, "package:datasets")
    summary(dataset)}
  )
  
  output$table = renderTable({
    dataset = get(input$dataset,"package:datasets")
    dataset
  })
  
}


# shinyApp function -------------------------------------------------------

shinyApp(ui, server)
