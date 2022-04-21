
# FREECODECAMP 

# ============================ does not work properly
# Load R packages
library(shiny)
library(shinythemes)
library(sysfonts)
library(bslib)
library(thematic)
library(randomForest)
library(data.table)

library(RCurl) # HTTP

# Read data
# weather <- read.csv(text = getURL("https://raw.githubusercontent.com/dataprofessor/data/master/weather-weka.csv") )
weather = read_csv('Input.csv')

#================= Build model
model <- randomForest(play ~ ., 
                      data = weather, 
                      ntree = 500, 
                      mtry = 4, 
                      importance = TRUE)

####################################
#       User interface             #
####################################

ui <- fluidPage(
  # theme = shinytheme("slate"),
  theme = bslib::bs_theme(
    version = 4,
    base_font = font_google("Poppins", local=TRUE),
    bg = "#282727", 
    fg = "#E0B9FD", 
    font_scale = NULL, 
    bootswatch = "spacelab"
  ),
  
  # Page header
  headerPanel('Play Golf?'),
  
  # Input values
  sidebarPanel(
    HTML("<h3> Input parameters </h3>"),
    
    selectInput("outlook", 
                label = "Outlook:", 
                choices = list("Sunny" = "sunny", "Overcast" = "overcast", "Rainy" = "rainy"), 
                selected = "Rainy"),
    
    sliderInput("temperature", 
                "Temperature:",
                min = 64, # 17.7 Celsius
                max = 86,
                value = 70),
    
    sliderInput("humidity", 
                "Humidity:",
                min = 65, 
                max = 96,
                value = 90),
    
    selectInput("windy", 
                label = "Windy:", 
                choices = list("Yes" = "TRUE", "No" = "FALSE"), 
                selected = "TRUE"),
    
    actionButton("submitbutton", 
                 "Submit", 
                 class = "btn btn-primary")
  ),# sidebarPanel
  
  # mainPanel
  mainPanel(
    tags$label(h3('Status/Output')), # Status/Output Text Box
    verbatimTextOutput('contents'),
    tableOutput('tabledata') # Prediction results table
  )
  
  
)#-- fluidPage








####################################
#         Server                   #
####################################

server <- function(input, output, session) {
  
  # input data
  datasetInput = reactive({
    # df columns
    df = data.frame(
      Name = c("outlook",
               "temperature",
               "humidity",
               "windy"),
      Value = as.character(c(input$outlook,
                             input$temperature,
                             input$humidity,
                             input$windy)),
      stringsAsFactors = FALSE
    )#dataframe
    
    play = "play"
    df = rbind(df, play)
    input = transpose(df)
    write.table(
      input,
      "input.csv", 
      sep=",", 
      quote = FALSE, 
      row.names = FALSE,
      col.names = FALSE
    )#table
    
    test <- read.csv(paste("input", ".csv", sep=""), header = TRUE)
    test$outlook <- factor(test$outlook, 
                           levels = c("overcast", "rainy", "sunny"))
    
    Output <- data.frame(Prediction = predict(model,test), 
                         round(predict(model,
                                       test,
                                       type="prob"), 3))
    print(Output)
  })#reactive
  
  # Status/Output Text Box
  output$contents <- renderPrint({
    if (input$submitbutton>0) { 
      isolate("Calculation complete.") 
    } else {
      return("Server is ready for calculation.")
    }
  })
  
  # Prediction results table
  output$tabledata <- renderTable({
    if (input$submitbutton>0) { 
      isolate(datasetInput()) 
    } 
  })
  
  
}#function





####################################
#   Create the shiny app           #
####################################
shinyApp(ui = ui, server = server)

































