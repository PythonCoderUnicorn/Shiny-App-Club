
# Images & Tibbles

library(shiny)
library(ggplot2)
library(tidyverse)

# make a dataframe 
puppies = tibble::tribble(
  ~breed, ~id, ~author,
  "corgi","t7ht23aw1",'DogDr',
  'poodle','b7bvx545aL','puppiesLvr',
  'golden retriever','s6fg2d3axt','DogzCentral'
)



ui <- fluidPage(
  selectInput("id", "Pick a breed", choices = setNames(puppies$id, puppies$breed)),
  htmlOutput("source"),
  imageOutput("photo")
)
server <- function(input, output, session) {
  output$photo <- renderImage({
    list(
      src = file.path("~/Documents/R_/ShinyApp/", paste0(input$id, ".jpg")),
      contentType = "image/jpg",
      width = 500,
      height = 650
    )
  }, deleteFile = FALSE)
  
  output$source <- renderUI({
    info <- puppies[puppies$id == input$id, , drop = FALSE]
    HTML(glue::glue("<p>
      <a href='https://unsplash.com/photos/{info$id}'>original</a> by
      <a href='https://unsplash.com/@{info$author}'>{info$author}</a>
    </p>"))
  })
}


shinyApp(ui, server)
