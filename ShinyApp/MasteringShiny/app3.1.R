


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


# ======================= WHAT NOT TO DO, DON'T CODE THIS WAY --- THE SERVER CODE CHUNKS

library(ggplot2)

freqpoly <- function(x1, x2, binwidth = 0.1, xlim = c(-3, 3)) {
  df <- data.frame(
    x = c(x1, x2),
    g = c(rep("x1", length(x1)), rep("x2", length(x2)))
  )
  
  ggplot(df, aes(x, colour = g)) +
    geom_freqpoly(binwidth = binwidth, size = 1) +
    coord_cartesian(xlim = xlim)
}

t_test <- function(x1, x2) {
  test <- t.test(x1, x2)
  
  # use sprintf() to format t.test() results compactly
  sprintf(
    "p value: %0.3f\n[%0.2f, %0.2f]",
    test$p.value, test$conf.int[1], test$conf.int[2]
  )
}


x1 <- rnorm(100, mean = 0, sd = 0.5)
x2 <- rnorm(200, mean = 0.15, sd = 0.9)

freqpoly(x1, x2)
cat(t_test(x1, x2))
#> p value: 0.065
#> [-0.32, 0.01]















ui <- fluidPage(
  

  h1("Shiny App 3"),
  # ------------------------------
  theme = bslib::bs_theme(
    version = 4,
    bg = "#28303B", 
    fg = "#ACA8A8", 
    font_scale = NULL, 
    bootswatch = "cosmo"
  ),
  # ------------------------------
  

  titlePanel("chapter 3"),
  
  
  fluidRow(
    # ---------- column
    column(
      4, 
      "Distribution 1",
      numericInput("n1", label = "n", value = 1000, min = 1),
      numericInput("mean1", label = "µ", value = 0, step = 0.1),
      numericInput("sd1", label = "σ", value = 0.5, min = 0.1, step = 0.1)
      ),
    # ---------- column
    column(4, 
    "Distribution 2",
    numericInput("n2", label = "n", value = 1000, min = 1),
    numericInput("mean2", label = "µ", value = 0, step = 0.1),
    numericInput("sd2", label = "σ", value = 0.5, min = 0.1, step = 0.1)
    ),
    # ---------- column
    column(4, 
           "Frequency polygon",
           numericInput("binwidth", label = "bin width", value = 0.1, step = 0.1),
          sliderInput("range", label = "range", value = c(-3,3), min = -5, max = 5)
          )
    ),
  
  fluidRow(
    column(9, plotOutput('hist')),
    column(3, verbatimTextOutput('ttest'))
  )
  

  
  
)






server <- function(input, output, session) {

  output$hist = renderPlot({
    x1 = rnorm(input$n1, input$mean1, input$sd1)
    x2 = rnorm(input$n2, input$mean2, input$sd2)
    
    freqpoly(x1, x2, binwidth= input$binwidth, xlim= input$range)
  }, res = 96)
  
  
  output$ttest = renderPlot({
    x1 = rnorm(input$n1, input$mean1, input$sd1)
    x2 = rnorm(input$n2, input$mean2, input$sd2) 
    
    t_test(x1,x2)
    })
  
  
  
  
  
  
  
  
}

shinyApp(ui, server)

