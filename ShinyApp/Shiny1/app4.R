
# interactive 

library(shiny)
library(ggplot2)




# ui <- fluidPage(
#   plotOutput("plot", click = "plot_click"),
#   tableOutput("data")
# )
# server <- function(input, output, session) {
#   output$plot <- renderPlot({
#     plot(mtcars$wt, mtcars$mpg)
#   }, res = 96)
#   
#   output$data <- renderTable({
#     nearPoints(mtcars, input$plot_click, xvar = "wt", yvar = "mpg")
#   })
# }





# ui <- fluidPage(
#   plotOutput("plot", brush = "plot_brush"),
#   tableOutput("data")
# )
# server <- function(input, output, session) {
#   output$plot <- renderPlot({
#     ggplot(mtcars, aes(wt, mpg)) + geom_point()
#   }, res = 96)
#   
#   output$data <- renderTable({
#     brushedPoints(mtcars, input$plot_brush)
#   })
# }






ui <- fluidPage(
  sliderInput("height", "height", min = 100, max = 500, value = 250),
  sliderInput("width", "width", min = 100, max = 500, value = 250),
  plotOutput("plot", width = 250, height = 250)
)
server <- function(input, output, session) {
  output$plot <- renderPlot(
    width = function() input$width,
    height = function() input$height,
    res = 96,
    {
      plot(rnorm(20), rnorm(20))
    }
  )
}









shinyApp(ui, server)