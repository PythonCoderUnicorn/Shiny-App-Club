


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



# for DEBUGGING use observeEvent()
# args: eventExpr (input od dependency) and handlerExpr (code to be run)

# --- debugging 
# string = reactive( paste("you entered a name ", input$name, "!"))
# 
# output$string = renderText( string() )
# # OBSERVE
# observeEvent( eventExpr = input$name, handlerExpr = {message("name variable stored")} )








#******************************* ESSENTIAL FOR DARK THEME PLOTS
thematic::thematic_shiny(font="auto")
#*******************************



# ==================== case study
#  National Electronic Injury Surveillance System (NEISS), 
#  collected by the Consumer Product Safety Commission

library(vroom)
library(tidyverse)

# dir.create("neiss")
# download <- function(name) {
#   url <- "https://github.com/hadley/mastering-shiny/raw/master/neiss/"
#   download.file(paste0(url, name), paste0("neiss/", name), quiet = TRUE)
# }
# download("injuries.tsv.gz")
# download("population.tsv")
# download("products.tsv")
# 
# injuries = vroom("neiss/injuries.tsv.gz")
# products <- vroom("neiss/products.tsv")
# population <- vroom("neiss/population.tsv")
# 
# glimpse(injuries)

# ======= EDA 

# toilet product code 649

injuries %>% 
  select(prod_code,narrative) %>% 
  filter(prod_code == 649) %>% 
  mutate(Toilet = str_detect(narrative, pattern = "toilet|TOILET")) %>% 
  janitor::tabyl(Toilet)


toilet_injuries = injuries %>% filter(prod_code ==649)

# sort by location
toilet_injuries %>% count(location, wt= weight, sort=T)
 

# sort by body part injured
toilet_injuries %>% 
  count(body_part, wt= weight, sort=T)

toilet_injuries %>% 
  count(age, sex, wt= weight) %>% 
  ggplot(
    aes(x= age, y= n, col= sex)
  )+
  geom_line()+
  geom_point()+
  labs(y="Estimated number of injuries",
       title = "Injuries by toilet")


# need to control for smaller elderly population 
toilet_injuries %>% 
  count(age, sex, wt= weight) %>% 
  left_join(population, by= c('age','sex')) %>% 
  mutate(rate = n / population * 1e4) %>% 
  ggplot(
    aes(x= age, y= rate, col= sex)
  )+
  geom_line()+
  geom_point()+
  labs(y="injuries per 10,000 people",
       title = "Injuries by toilet")


# BUILD YOUR APP PROTOTYPE AS SIMPLE AS POSSIBLE
# do a few pencil-and-paper sketches to rapidly explore the UI 
# and reactive graph before committing to code.


# --- top 5 results in tables
injuries %>%
  mutate(diag = fct_lump(fct_infreq(diag), n = 5)) %>%
  group_by(diag) %>%
  summarise(n = as.integer(sum(weight)))


count_top <- function(df, var, n = 5) {
  df %>%
    mutate({{ var }} := fct_lump(fct_infreq({{ var }}), n = n)) %>%
    group_by({{ var }}) %>%
    summarise(n = as.integer(sum(weight)))
}



# --- GLOBAL VARIABLE
prod_codes = setNames(products$prod_code, products$title)




ui <- fluidPage(
  

  h1("Shiny App 4"),
  # ------------------------------
  theme = bslib::bs_theme(
    version = 4,
    bg = "#28303B", 
    fg = "#ACA8A8", 
    font_scale = NULL, 
    bootswatch = "cosmo"
  ),
  # ------------------------------
  

  titlePanel("chapter 4"),
  
  # -- fluidRow
  fluidRow(
    column(width = 6, selectInput(inputId = "code",label = "Product", choices = prod_codes))
  ),

  # --- columns in dataset
  fluidRow(
    column(width = 4, tableOutput("diag") ),
    column(width = 4, tableOutput("body_part") ),
    column(width = 4, tableOutput("location") ),
  ),
  
  fluidRow(
    column(width = 12, plotOutput("age_sex"))
  ),
  


  
  
)



# good idea to clean up EDA code before coding Shiny app code


server <- function(input, output, session) {

  # --- selected injuries
  selected = reactive(
    injuries %>% 
      filter(prod_code == input$code)
      )
  
  # ---- output diagnosis
  # output$diag = renderTable(
  #   selected() %>% 
  #     count(diag, wt= weight, sort= TRUE)
  # )
  
  # ---- output body part
  # output$body_part = renderTable(
  #   selected() %>% 
  #     count(body_part, wt= weight, sort= TRUE)
  # )
  
  # ---- output location
  # output$location = renderTable(
  #   selected() %>% 
  #     count(location, wt= weight, sort= TRUE)
  # )
  
  # ====== section 4.5 Polish tables is unclear what is kept/deleted
  
  # ---- summary reactive
  summary = reactive({
    selected() %>%
      count(age, sex, wt= weight) %>%
      left_join(population, by= c('age','sex')) %>%
      mutate(rate = n / population * 1e4)
  })

  
  output$diag <- renderTable(count_top(selected(), diag), width = "100%")
  output$body_part <- renderTable(count_top(selected(), body_part), width = "100%")
  output$location <- renderTable(count_top(selected(), location), width = "100%")
  
  # ---- output a plot
  output$age_sex = renderPlot({
    summary() %>% 
      ggplot( aes(x=age, y= n, color= sex)) +
      geom_line()+
      geom_point()+
      labs(title = "Injuries by product code", y="estimated injuries")
  }, res = 100)

  
  
}

shinyApp(ui, server)

