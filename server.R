library(shiny)
library(dplyr)
library(ggplot2)

data <- read.csv("1976-2016-president.csv")
data <- filter(data, (party == "democrat" | party == "republican")  & (writein == FALSE)) 
data <- data %>%
  mutate(percent_votes = data$candidatevotes/data$totalvotes)

createStatePlot <- function(st){
    state_data_r <- filter(data, state == st & party == "republican")
    state_data_d <- filter(data, state == st & party == "democrat")
    c1<-cor.test(state_data_r$percent_votes, state_data_r$year, method="pearson")
    c2<-cor.test(state_data_d$percent_votes, state_data_d$year, method="pearson")
    g1 <- ggplot(data = state_data_r, aes(x = year, y = percent_votes)) + geom_line() +
      geom_smooth(method = "lm") + 
      xlab("Year")+
      ylab("Percentage of total votes")
    g2 <- ggplot(data = state_data_d, aes(x = year, y = percent_votes)) + geom_line() +
      geom_smooth(method = "lm")+ 
      xlab("Year")+
      ylab("Percentage of total votes")
    return(list(c1, c2, g1, g2))
}

shinyServer(function(input, output) {
  select_state <- reactive({
    input$state_choices
  })
  
  output$stateData1 <- renderPlot({
    createStatePlot(select_state())[3]
  })
  
  output$stateData2 <- renderPlot({
    createStatePlot(select_state())[4]
  })
  
  output$correl1 <- renderText({
    as.numeric(createStatePlot(select_state())[[1]][4])
  })
  
  
  output$correl2 <- renderText({
    as.numeric(createStatePlot(select_state())[[2]][4])
  })

})
