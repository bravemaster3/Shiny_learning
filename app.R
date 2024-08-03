library(shiny)
library(shinythemes)
library(ggplot2)

ui <- fluidPage(
  # theme = shinytheme("cyborg"),
  includeCSS("www/styles.css"),
  sidebarLayout(
    sidebarPanel(
      class="sidebar",
      sliderInput(inputId = "numberInput",
                  label="Choose a number",
                  min=0,
                  max=100,
                  value=0,
                  step=5),
      textInput("myText", h2("Type a text"), ""),
      checkboxInput("showGraph", "Display the plot", FALSE, width = "100%"),
      
      width = 4
    ),
    mainPanel(
      textOutput("outputText"),
      plotOutput("outputPlot")
    )
  )
)

server <- function(input, output, session) {
  output$outputText <- renderText({
    req(input$numberInput)
    req(input$myText)
    # if(input$numberInput & input$myText){
    paste0("Your number is: ", input$numberInput, " and you wrote the text: ", input$myText)
    # }
  })
  
  output$outputPlot <- renderPlot({
    if(input$showGraph){
      ggplot(mtcars, aes(hp, mpg))+
        geom_point()+
        theme_test()
    }
  })
}

shinyApp(ui, server)