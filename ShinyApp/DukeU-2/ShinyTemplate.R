
# ======= starter code template for Shiny

# Shiny Apps have 3 components to them:
# UI = user interface
# Server = for all functions
# ShinyApp() = executes running the app 

# ======= LIBRARIES
library(shiny)
library(sysfonts) # for custom fonts 
library(bslib)    # for styling
library(thematic) # for styling
library(tidyverse) 
library(ggplot2)


# =========================== Component #1
ui <- fluidPage(
  
  # ===== 3 STEPS TO INTERESTING SHINY APP DESIGN ====
  # step 1: run this code to get a custom theme
  # bs_theme_preview(),
  
  # step 2: copy the code after 'theme' 
  # and place inside the "theme = bslib::bs_theme()"
  
  # example, code from the terminal:
  ####  Update your bs_theme() R code with:  #####
  # bs_theme_update(theme, fg = "#67F997", primary = "#6A377F", info = "#DBBB34", 
  #                 font_scale = NULL, bootswatch = "darkly", bg = "#222222")
  
  # step 3: comment-out bs_theme_preview()
  #   and uncomment bs_theme() below
  
  theme = bslib::bs_theme(
     version = 4,
     # have the font of your choice on your machine
     # i go to Google fonts, select one, download
     # unzip the file, drag & drop the folder into your computer's Font Book
     base_font = font_google("Poppins", local=TRUE),
     bg = "#282727", # soft black
     fg = "#E0B9FD", # purple
     font_scale = NULL, 
     bootswatch = "spacelab",
    
   ),    # PAY ATTENTION TO THE COMMAS ! 
  
  
  
    #******************************* ESSENTIAL FOR DARK THEME PLOTS
    thematic::thematic_shiny(),
    #*******************************
  
  # Application title
  titlePanel("Shiny Template"),
  
  
  
)



# =========================== Component #2
server <- function(input, output) {}





# =========================== Component #3
shinyApp(ui = ui, server = server)



































