library(shiny)
library(DiagrammeR)
library(magrittr)
library(shinyAce)

ui = shinyUI(fluidPage(
  aceEditor('code', mode='r', value="create_graph() %>%
  add_node_df(create_nodes(c('Internet', 'Load Balancer', 'Web Server'))) %>%
            add_edge_df(create_edges(from = c('Internet', 'Load Balancer'),
            to = c('Load Balancer', 'Web Server'))) %>%
            set_node_attr('Internet', 'shape', 'plaintext') %>%
            set_node_attr('Load Balancer', 'reliability', 0.8) %>%
            set_node_attr('Web Server', 'reliability', 0.9) %>%
            render_graph()"),
  actionButton("eval", "Evaluate"),
  grVizOutput('diagram')
))

server = shinyServer(function(input, output) {
  output$diagram <- renderGrViz({
    input$eval
    isolate(eval(parse(text=input$code)))
  })
})

shinyApp(ui, server)
