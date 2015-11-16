library(shiny)
library(DiagrammeR)
library(magrittr)
library(shinyAce)

ui = shinyUI(fluidPage(
  fluidRow(
    column(4,
           aceEditor('code', mode='r', value="create_system() %>%
  node('load balancer', 0.9) %>%
  node('database', 0.9) %>%
  node('web server', 0.9)"),
           actionButton("eval", "Evaluate")
    ),
    column(8,
           textOutput("reliability"),
           grVizOutput("diagram"))
  )
))

server = shinyServer(function(input, output) {

  code <- reactive(input$code)

  output$reliability <- renderText({
    input$eval
    isolate(eval(parse(text=code())) %>% reliability())
  })

  output$diagram <- renderGrViz({
    input$eval
    isolate(eval(parse(text=code())) %>% plot())
  })
})

shinyApp(ui, server)
