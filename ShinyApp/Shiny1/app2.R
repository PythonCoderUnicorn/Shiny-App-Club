
library(tidyverse)
library(shiny)
library(shiny.fluent)

# data
fluentSalesDeals %>% glimpse()

fluentPeople %>% glimpse()

fluentSalesDeals %>% glimpse()



library(tibble)

columns = tibble(
  fieldName = c('rep_name','date','deal_amount','city','is_closed'),
  name = c('Sales rep','Close date','Amount','City','is closed?')
)






ui = fluentPage(
  Text("Sales Data", variant= "mega"),
  
  DetailsList(items = fluentSalesDeals, columns= columns)
)

server = function(input, output){}

shinyApp(ui, server)



shinyApp(
  ui = div(
    Checkbox.shinyInput("checkbox", value = TRUE),
    textOutput("checkboxValue")
  ),
  server = function(input, output) {
    output$checkboxValue <- renderText({
      sprintf("Value: %s", input$checkbox)
    })
  }
)






details_list_columns <- tibble(
  fieldName = c("rep_name", "date", "deal_amount", "client_name", "city", "is_closed"),
  name = c("Sales rep", "Close date", "Amount", "Client", "City", "Is closed?"),
  key = fieldName)


ui <- fluentPage(
  uiOutput("analysis")
)

server <- function(input, output, session) {
  filtered_deals <- reactive({
    filtered_deals <- fluentSalesDeals %>% filter(is_closed > 0)
  })
  
  output$analysis <- renderUI({
    items_list <- if(nrow(filtered_deals()) > 0){
      DetailsList(items = filtered_deals(), columns = details_list_columns)
    } else {
      p("No matching transactions.")
    }
    
    Stack(
      tokens = list(childrenGap = 5),
      Text(variant = "large", "Sales deals details", block = TRUE),
      div(style="max-height: 500px; overflow: auto", items_list)
    )
  })
}

shinyApp(ui, server)
