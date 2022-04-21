

# SHINY THEMATIC COLOR CUSTOMIZATION
# https://rstudio.github.io/thematic/articles/auto.html
# https://rstudio.github.io/bslib/articles/bslib.html

# https://shiny.rstudio.com/articles/datatables.html

# https://shiny.rstudio.com/tutorial/written-tutorial/lesson1/
# https://shiny.rstudio.com/tutorial/written-tutorial/lesson1/

library(shiny)
library(bslib)
library(ggplot2)


tabs <- tabsetPanel(type = "pills",
                    tabPanel("ggplot", plotOutput("ggplot")),
                    tabPanel("lattice", plotOutput("lattice")),
                    tabPanel("base", plotOutput("base"))
)


solar_theme <- bs_theme(
  bg = "#002B36", 
  fg = "#EEE8D5", 
  primary = "#2AA198", 
  base_font = font_google("Pacifico")
)


ui <- fluidPage(
  # theme = solar_theme, tabs
  tabs, theme = shinythemes::shinytheme("darkly")
  ) 



server <- function(input, output) {
  output$ggplot <- renderPlot({
    ggplot(mtcars, aes(wt, mpg, label = rownames(mtcars), color = factor(cyl))) +
      geom_point() +
      ggrepel::geom_text_repel()
  })
  output$lattice <- renderPlot({
    lattice::show.settings()
  })
  output$base <- renderPlot({
    image(volcano, col = thematic_get_option("sequential"))
  })
}


thematic_shiny()
shinyApp(ui, server)
