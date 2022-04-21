
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
  
}


# shinyApp function -------------------------------------------------------

shinyApp(ui, server)
