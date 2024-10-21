library(shiny)

# Define UI ----
ui <- page_sidebar(titlePanel("censusVis"),
                   sidebar = sidebar(
                     helpText(
                       "Create demographic maps with informations from the 2010 US Census."
                     ),
                     selectInput(
                       inputId = "var",
                       label = "Choose a variable to display",
                       choices =
                         list(
                           "Percent White",
                           "Percent Black",
                           "Percent Hispanic",
                           "Percent Asian"
                         ),
                       selected = "Percent White"
                     ),
                     sliderInput(
                       "range",
                       "Range of interest:",
                       min = 0,
                       max = 100,
                       value = c(0, 100)
                     )
                   )
)

# Define server logic ----
server <- function(input, output) {
  
}

# Run the app ----
shinyApp(ui = ui, server = server)