
library(shiny)

shinyUI(fluidPage(
  titlePanel(
    h1("Voting Patterns for Individual States from 1970-2016", align = "center")
  ),
  
  mainPanel(
    h3("Data is from the MIT Election Lab", align = "center"),
    h3("https://dataverse.harvard.edu/dataset.xhtml?persistentId=doi:10.7910/DVN/42MVDX", align = "center"),
    selectInput(inputId = "state_choices", label = "State",
                choices = state.name),
    splitLayout(h4("Republican Percent of Votes"), h4("Democratic Percent of Votes")),
    splitLayout(plotOutput("stateData1"),
                plotOutput("stateData2")),
    br(),
    splitLayout(h4("Correlation between year and percentage of votes for Republicans"),
                h4("Correlation between year and percentage of votes for Democrats")),
    splitLayout(h5(textOutput("correl1")),
                h5(textOutput("correl2"))),
    br(),
    br(),
    h3("This website allows viewers to see voting patterns in terms of party preference dating back about 40-50 years. For each state, two regression lines are produced, illustrating the overall increase or decrease in percentage of total votes for both the Democratic and Republican parties. The user has a selection tool at the top of the page where they can switch between different states and view their corresponding data. At the bottom of each graph, I have provided a correlation between year and percentage of votes based on the linear regression model, with correlations with an absolute value closer to 1 indicating a stronger relationship."),
    width=12
  )
))