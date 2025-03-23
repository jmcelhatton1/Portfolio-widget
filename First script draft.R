library(shiny)
library(quantmod)

portfolio_df <- getSymbols('VEQT.TO', src="yahoo", auto.assign=FALSE)

shinyUI(
  fluidPage(
    titlePanel("Portfolio Tracker"),
    sidebarLayout(
      sidebarPanel(
        textInput("asset", "Asset Name"),
        numericInput("holdings", "Holdings"),
        dateInput("date", "Date")
      ),
      mainPanel(
        textOutput("gainsLosses"),
        tableOutput("portfolioValue")
      )
    )
  )
)

# Create a reactive expression to load and process data
data <- reactive({
  # Calculate daily gains/losses and portfolio value
  gains_loss <- calculate_gains_loss(portfolio_data)
  portfolio_value <- calculate_portfolio_value(portfolio_data)
  # Return a list of data
  list(gains_loss = gains_loss, portfolio_value = portfolio_value)
})

# Use render functions to link output fields to data
output$gainsLosses <- renderText({
  # Render text output for gains/losses
  data()$gains_loss
})

output$portfolioValue <- renderTable({
  # Render table output for portfolio value
  data()$portfolio_value
})

