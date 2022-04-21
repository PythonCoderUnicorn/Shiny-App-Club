
# Shiny & Fluent UI

library(dplyr)
library(shiny)


# fluidPage() sets up all the HTML, CSS, and JavaScript that Shiny needs.
# fluidPage(
#   titlePanel("Hello Shiny!"),
#   sidebarLayout( sidebarPanel(
#     sliderInput("obs", "Observations:", min = 0, max = 1000, value = 500) ),
#     mainPanel(
#       plotOutput("distPlot"))
#   )
# )

# ui <- fluidPage(
#   titlePanel("Central limit theorem"),
#   sidebarLayout(
#     sidebarPanel(
#       numericInput("m", "Number of samples:", 2, min = 1, max = 100)
#     ),
#     mainPanel(
#       plotOutput("hist")
#     )
#   )
# )

# ui <- fluidPage(
#   tabsetPanel(
#     tabPanel("Import data", 
#              fileInput("file", "Data", buttonLabel = "Upload..."),
#              textInput("delim", "Delimiter (leave blank to guess)", ""),
#              numericInput("skip", "Rows to skip", 0, min = 0),
#              numericInput("rows", "Rows to preview", 10, min = 1)
#     ),
#     tabPanel("Set parameters"),
#     tabPanel("Visualise results")
#   )
# )

# ui <- fluidPage(
#   HTML(r"(
#        <h1>This is a heading</h1>
#        <p class="my-class">This is some text!</p>
#        <ul>
#        <li>First bullet</li>
#        <li>Second bullet</li>
#        </ul>
#   )")
# )


ui <- fluidPage(
  mainPanel(
    h1(paste0("Theme: darkly")),
    h2("Header 2"),
    p("Some text")
  ),
  
  theme = bslib::bs_theme(bootswatch = "darkly"),
  titlePanel("   A themed plot"),
  plotOutput("plot")
  
  # sidebarLayout(
  #   sidebarPanel(
  #     textInput("txt", "Text input:", "text here"),
  #     sliderInput("slider", "Slider input:", 1, 100, 30) )
    
)


server <- function(input, output, session) {
  thematic::thematic_shiny()
  
  
  output$hist <- renderPlot({
    means <- replicate(1e4, mean(runif(input$m)))
    hist(means, breaks = 20)
  }, res = 96)
  
  
  output$plot = renderPlot({
    ggplot(mtcars, aes(x= wt, y= mpg)) +
      geom_point() +
      geom_smooth() }, res= 97)
}


shinyApp(ui, server)



















