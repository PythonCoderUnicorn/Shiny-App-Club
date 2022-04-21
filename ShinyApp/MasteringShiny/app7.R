
# ================== MASTERING SHINY

library(shiny)
library(bslib)
library(thematic)


#  IMPERATIVE PROGRAMMING = specific commands and executed immediately
#  DECLARATIVE PROGRAMMING = express/ declare constraints on programming, decision is to be made

# Shiny app is a declarative 
# watch out for typos ! no error code returned
# make sure that reactive expressions and outputs only refer to things defined above, not below
# 

# whenever you copy and paste something once, you should consider extracting 
# the repeated code out into a reactive expression ==> efficiency & easier to read/ understand

# not using reactive functions, all variables/data is calculated only once, x1 won't know about x2

# reactiveTimer() depends on hidden input of time. inside the server function
# timer = reactiveTimer(500)    # ms is 2x per second, changes plot
#  x1 = reactive({ timer()  rpois(input$n, input$lambda1 )})

# actionButton()  deals with user constantly clicking buttons and app is running calculations
#  inside the fluidPage function   actionButton("simulate", "Simulate!") but this also leaves 
# dependencies on variables = not ideal
# **** USE eventReactive() to handle all changes and triggering of app





# debugging ---------------------------------------------------------------

# for DEBUGGING use observeEvent()
# args: eventExpr (input od dependency) and handlerExpr (code to be run)

# string = reactive( paste("you entered a name ", input$name, "!"))
# 
# output$string = renderText( string() )
# # OBSERVE
# observeEvent( eventExpr = input$name, handlerExpr = {message("name variable stored")} )


# workflow ----------------------------------------------------------------

# BUILD YOUR APP PROTOTYPE AS SIMPLE AS POSSIBLE
# do a few pencil-and-paper sketches to rapidly explore the UI 
# and reactive graph before committing to code.

# good idea to clean up EDA code before coding Shiny app code



# fluidpage HTML ----------------------------------------------------------

# fluidPage() sets all the HTML, CSS, Javascript
# fixedPage() has max width 
# fillPage() uses height of browser, for full screen plots


#             -- single page --
# fluidPage
# titlePanel
# -----------------------------
# sidebarLayout
#   [sidebarPanel] [mainPanel]
# 
# ----------------------------




# plotOutput --------------------------------------------------------------

# interactive graphics
# click, dblclick , hover, brush

# plotOutput('plot', click = 'plot_click')
# input$plot_click

# brush  (xmin, xmax, ymin, and ymax)




#******************************* ESSENTIAL FOR DARK THEME PLOTS
thematic::thematic_shiny(font="auto")
#*******************************
#







# --- GLOBAL VARIABLE




# ===================================== UI
ui <- fluidPage(
  

  h1("Shiny App 7"),
  # ------------------------------
  theme = bslib::bs_theme(
    version = 4,
    bg = "#28303B", 
    fg = "#ACA8A8", 
    font_scale = NULL, 
    bootswatch = "cosmo"
  ),
  # ------------------------------
  

  titlePanel("chapter 7 - graphics"),
  
  # h2('nearPoints : click on data point for table info'),
  # plotOutput('plot', click = 'plot_click'),
  # verbatimTextOutput('info')
  # tableOutput('data')


  h2('brushing : rectangle selection'),
  plotOutput('plot', brush = 'plot_brush'),
  tableOutput('data')
  
  
  
  
  
)
# ===================================== UI




# ===================================== SERVER
server <- function(input, output, session) {

  #-- mtcars data plot
  # output$plot = renderPlot({
  #   plot(x= mtcars$wt, y= mtcars$mpg)
  # })
  # 
  #-- round the number of where user clicks on plot & get/print coordinates
  # output$info = renderPrint({
  #   req(input$plot_click)
  #   x = round(input$plot_click$x, 2)
  #   y = round(input$plot_click$y, 2)
  #   glue::glue("[ {x} , {y} ]")
  # })

  # --- nearpoints
  # output$plot = renderPlot({
  #   plot(mtcars$wt, mtcars$mpg)
  # })
  # 
  # output$plot = renderPlot({
  #   ggplot(mtcars, aes(x= wt, y= mpg))+
  #     geom_point(size= 4)+
  #     theme( text = element_text(size = 14) )
  # })
  # 
  # output$data = renderTable({
  #   req(input$plot_click)
  #   nearPoints(mtcars, input$plot_click)
  # })
  
  
  # -- plot brush
  output$plot = renderPlot({
    ggplot(mtcars, aes(wt, mpg))+
      geom_point(size=4)+
      theme( text = element_text(size = 14) )
  })
  
  output$data = renderTable({
    brushedPoints(mtcars, input$plot_brush)
  })
  
  
  
  
  
  
  
  
  
}
# ===================================== SERVER




shinyApp(ui, server)

