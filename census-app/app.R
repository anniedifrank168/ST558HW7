library(shiny)

source("helpers.R")
counties <- readRDS("data/counties.rds")
library(maps)
library(mapproj)

# User interface ----
ui <- page_sidebar(
  title = "censusVis",
  
  sidebar = sidebar(
    helpText(
      "Create demographic maps with information from the 2010 US Census."
    ),
    selectInput(
      "var",
      label = "Choose a variable to display",
      choices =
        c(
          "Percent White",
          "Percent Black",
          "Percent Hispanic",
          "Percent Asian"
        ),
      selected = "Percent White"
    ),
    sliderInput(
      "range",
      label = "Range of interest:",
      min = 0, 
      max = 100, 
      value = c(0, 100)
    )
  ),
  
  card(plotOutput("map"))
)

# Server logic ----
server <- function(input, output) {
  output$map <- renderPlot({
    data <- switch(input$var,
                   "Percent White" = counties$white,
                   "Percent Black" = counties$black,
                   "Percent Hispanic" = counties$hispanic,
                   "Percent Asian" = counties$asian)
    
    color <- switch(input$var,
                    "Percent White" = "darkgreen",
                    "Percent Black" = "pink",
                    "Percent Hispanic" = "purple",
                    "Percent Asian" = "blue")
    
    legend.title <- switch(input$var, 
                     "Percent White" = "% white",
                     "Percent Black" = "% BLACK",
                     "Percent Hispanic" = "% hispanic",
                     "Percent Asian" = "% asian"
                           )
    
    percent_map(var = data, color, legend.title, input$range[1], input$range[2])
  })
}
# Run app ----
shinyApp(ui, server)
