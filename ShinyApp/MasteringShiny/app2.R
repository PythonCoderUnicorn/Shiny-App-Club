
library(shiny)
library(shinythemes)
library(sysfonts)
library(shinyWidgets)
library(bslib)
library(thematic)


#----- UI input functions ----
# sliderInput(), selectInput(), textInput(), numericInput()

# SHINY WIDGET GALLEY 
# https://shiny.rstudio.com/gallery/widget-gallery.html







# ========== GLOBAL VARIABLES ============
animals = c('dog','cat','bird','rabbit','other','no animals')
languages = c('Python','R','C++','Lua','Javascript')


#******************************* ESSENTIAL FOR DARK THEME PLOTS
thematic::thematic_shiny(font="auto")
#*******************************

ui = fluidPage(

  theme = bslib::bs_theme(
    version = 4,
    bg = "#28303B", 
    fg = "#ACA8A8", 
    font_scale = NULL, 
    bootswatch = "cosmo"
    # ------------------------------
  ),
  
  h1("App 2"),
  
  # -- name
  textInput(inputId = "name", label = "Enter a name",placeholder = NULL),
  # -- password
  passwordInput(inputId = "password",label = "Enter a password", placeholder = NULL),
  # -- textbox
  textAreaInput(inputId = "story",
                label = "Comments", 
                width = '400px', 
                placeholder = 'Enter text here'),
  
  h3("numeric inputs"),
  numericInput(inputId = "num", label = "Number 1", value = 0, min = 0, max=30),
  sliderInput(inputId = "num2", label = "Num 2", value = 7, min = 0, max=30),
  sliderInput(inputId = "rng", label = "Range", value = c(4,9), min = 0, max= 30),
  
  h3("date input"),
  dateInput(inputId = "dob", label = "When were you born?"),
  dateRangeInput(inputId = "holiday",label = "select vacation time"),
  
  h3("limited choices"),
  selectInput(inputId = 'state',label = "select a state", state.name),
  radioButtons(inputId = "animal","select an animal", animals),
  
  
  # -- RADIO BUTTONS
  radioButtons(inputId = "rb", label = "Select one:",
               choiceNames = list('pizza','burger','shwarma' ),
               choiceValues = list("pizza","burger","shwarma")),
  
  # --- DROP DOWN
  selectInput(inputId = "state", label = "Choose a US state area", state.region, multiple = TRUE),
  
  # --- CHECK BOX
  h6("remember to declare your vector in global scope"),
  checkboxGroupInput("code","what do you code ?", languages),
  
  # -- y/n
  checkboxInput("shutdown","shutdown system?", value = TRUE),
  checkboxInput("restart","restart system?"),
  
  h3("file upload"),
  h5("file upload function= chapter 9"),
  fileInput("upload file",NULL),
  
  # ====== ACTION BUTTONS !
  h3("action buttons"),
  actionButton("dx1","Level 1 diagnostic"),
  actionButton(inputId = "dx2","Level 2 diagnostic"),
  
  h6("\n"),
  # -- fluidRow
  fluidRow(
    actionButton('Red','Red Alert !', class= "btn-danger"),
    h6("\n"),
    actionButton("alert", "Cancel Alert", class = "btn-success")
  ),
  
  h4("exercises"),
  
  # numericInput(inputId = "num", label = "Number 1", value = 0, min = 0, max=30),
  # dateRangeInput(inputId = "holiday",label = "select vacation time")
  
  sliderInput(
    "Delivery",
    "Dates for delivery:",
    min = as.Date("2022-04-01","%Y-%m-%d"),
    max = as.Date("2022-04-30","%Y-%m-%d"),
    value =  as.Date("2022-04-01"),
    timeFormat = "%Y-%m-%d"
  ),
  
  h3("output$text"),
  textOutput("text1"),
  verbatimTextOutput("print1"),
  
  
  textOutput("text"), # keywords
  verbatimTextOutput("print"),
  
  # ===== TABLES   
  # tableOutput()     & renderTable()      = static tables
  # dataTableOutput() & renderDataTable()  = dynamic tables
  h2("Tables"),
  
  h4("static table"),
  tableOutput("static"),
  h4("dynamic table"),
  dataTableOutput("dynamic")
  
  
  
)




server <- function(input, output, session) {
  # { } needed for multiple lines of code for functions
  
  output$text1 = renderText("output$text1 = renderText")
  output$print1 = renderPrint("output$print1 = renderPrint")
  
  output$text <- renderText("hello! renderText")
  h3("\n")
  output$print <- renderPrint("hello! renderPrint")
  
  
  # == Table
  output$static = renderTable( head(mtcars))
  output$dynamic = renderDataTable(mtcars, options = list(pageLength= 5))
  
}









shinyApp(ui, server)