
# Code source : https://minecr.shinyapps.io/01-hello/#section-user-interface-ui

library(shiny)
library(sysfonts)
library(bslib)
library(thematic)
library(tidyverse)
library(ggplot2)

# have file in local folder directory
load("movies.RData")



ui <- fluidPage(
  theme = bslib::bs_theme(
    version = 4,
    base_font = font_google("Poppins", local=TRUE),
    bg = "#282727", # soft black
    fg = "#E0B9FD", # purple
    font_scale = NULL, 
    bootswatch = "spacelab",
    
  ),
  
  # bs_theme_preview(),
  
  #******************************* ESSENTIAL FOR DARK THEME PLOTS
  thematic::thematic_shiny(),
  #*******************************
  
  
  # Application title
  titlePanel("Movie Data"),
  
  sidebarLayout(
    
    # Inputs: Select variables to plot
    sidebarPanel(
      
      # Select variable for y-axis
      selectInput(inputId = "y", 
                  label = "Y-axis:",
                  choices = c("IMDB Rating"="imdb_rating", 
                              "IMDB Votes"="imdb_num_votes", 
                              "Critics Score"="critics_score", 
                              "Audience Score"="audience_score", 
                              "Movie Length"="runtime"), 
                  selected = "audience_score"),
      
      # Select variable for x-axis
      selectInput(inputId = "x", 
                  label = "X-axis:",
                  choices = c("IMDB Rating"="imdb_rating", 
                              "IMDB Votes"="imdb_num_votes", 
                              "Critics Score"="critics_score", 
                              "Audience Score"="audience_score", 
                              "Movie Length"="runtime"), 
                  selected = "critics_score"),
      
      # Select variable for color
      selectInput(inputId = "z", 
                  label = "Color by:",
                  choices = c("Title"="title_type", 
                              "Genre"="genre", 
                              "MPAA Rating"="mpaa_rating", 
                              "Critics Rating"="critics_rating", 
                              "Audience Rating"="audience_rating"),
                  selected = "mpaa_rating")
    ),
    
    
    # Output: Show scatterplot
    mainPanel(
      paste("Scatterplot"),
      plotOutput(outputId = "scatterplot")
    )
  )
  
)



server <- function(input, output) {
  output$scatterplot <- renderPlot({
    ggplot(data = movies, aes_string(x = input$x, 
                                     y = input$y,
                                     color= input$z
                                     )) +
      geom_point(alpha= 0.5, size=5)+
      theme(axis.text.x = element_text(size=16),
            axis.text.y = element_text(size=16),
            axis.title = element_text(size = 13),
            legend.title = element_text(size = 14),
            legend.text = element_text(size = 13)
      )
  })
  
}



# Create the Shiny app object ---------------------------------------
shinyApp(ui = ui, server = server)

