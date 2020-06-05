
## app.R ##
library(shiny)
library(shinydashboard)

#Dashboard header carrying the title of the dashboard
header <- dashboardHeader(title = "Personal Financial Planning",titleWidth = 300) 

#Sidebar content of the dashboard
sidebar <- dashboardSidebar(
  sidebarMenu(
    menuItem("Personal Balance Sheet", icon = icon("th"),
             menuSubItem("Balance Sheet", tabName = "sheet"),
             menuSubItem("Saving and Consumption", tabName = "suggestion")),
    menuItem("Home Mortgage Financing", tabName = "house", icon = icon("home")),
    menuItem("Life and Health Insurance", tabName = "insurance", icon = icon("heart")),
    menuItem("Pensions and Retirement", tabName = "retirement", icon = icon("dashboard"))
  )
)



# make the body

body <- dashboardBody(
  tabItems(
    tabItem(tabName = "sheet",
            fluidRow(
              box(width = 3,
                  title = "Current Age", background = "yellow",
                  numericInput("age", " What is your age ? ", 25)
              ),
              box(width = 3,
                  title = "Retirement Age", background = "aqua",
                  numericInput("re_age"," when do you plan to retire? ", 65)
              )
            ),
            
            fluidRow(
              tabBox(
                title = tagList(shiny::icon("wallet"), "Financial Assets"),
                # The id lets us use input$tabset1 on the server to find the current tab
                id = "asset", 
                tabPanel( 
                  title = "Bank Accounts", status = "warning",
                  uiOutput("bank_balance"),
                  actionButton("addbank", "Add")
                ),
                tabPanel( 
                  title = "Investment"
                ),
                tabPanel( 
                  title = "Housing", status = "warning",
                  sliderInput("num_house", "Number of Real Estate:", 1, 30, 3),
                  uiOutput("house_value")
                ),
                tabPanel( 
                  title = "Vehicles", status = "warning",
                  sliderInput("num_vehicle", "Number of Vehicles:", 1, 30, 3),
                  uiOutput("vehicle_value")
                ),
                tabPanel( 
                  title = "Pensions"
                ),
                tabPanel( 
                  title = "Equity in Small Business"
                ),
                tabPanel( 
                  title = "Other Assets"
                )),
              tabBox(
                title = tagList(shiny::icon("credit-card"), "Explicit Liabilities"),
                # The id lets us use input$tabset1 on the server to find the current tab
                id = "ex_liability",
                tabPanel( 
                  title = "Credit Card", status = "warning",
                  sliderInput("num_creditcard", "Number of Credit Cards:", 1, 30, 3),
                  uiOutput("creditcard_balance")
                ),
                tabPanel( 
                  title = "Loans", status = "warning"
                ),
                tabPanel( 
                  title = "Other Debts", status = "warning"
                )
              )),
            
            fluidRow(
              tabBox(
                title = tagList(shiny::icon("briefcase"), "Human Capital"),
                # The id lets us use input$tabset1 on the server to find the current tab
                id = "asset", 
                tabPanel("tab1", "First tab content")
              ),
              tabBox(
                title = tagList(shiny::icon("money-bill"), "Implicit Liabilities"),
                # The id lets us use input$tabset1 on the server to find the current tab
                id = "im_liability", 
                tabPanel("tab1", "First tab content")
              )
            ),   
            
            fluidRow(
              valueBoxOutput("totalAssetBox"),
              valueBoxOutput("totalLiabilityBox"),
              valueBoxOutput("networthBox")
            )    
            
    ),
    tabItem(tabName = "suggestion",
            h2("Dashboard tab content")
    ),       
    tabItem(tabName = "house",
            h2("Dashboard tab content")
    ),
    tabItem(tabName = "insurance",
            h2("Dashboard tab content")
    ),
    tabItem(tabName = "retirement",
            h2("Dashboard tab content")
    )
  )
)

#completing the ui part with dashboardPage
ui <- dashboardPage(title = 'Personal_financial_planning', header, sidebar, body, skin='blue')

# create the server functions for the dashboard  
server <- function(input, output){ 
  output$bank_balance <- renderUI({
    numericInput(paste0('Account', 1), paste0('Balance ', 1),0)
    # numericInput(varaible name,title, number )
  })
  ## reactive values
  # store history as reactive values
  history <- reactiveValues(clicked = c(1)) # number of clicks
  observeEvent(input$addbank, {
    history[['clicked']] <- 
      c(history[['clicked']],length(history[['clicked']])+1)
    insertUI("#addbank", "beforeBegin",
             ui= numericInput(paste0('Account', length(history[['clicked']])), 
                              paste0('Balance ',length(history[['clicked']]) ),0))
  })
  
  output$house_value<- renderUI({
    houselist <-tagList()
    num_house <- as.integer(input$num_house)
    for(i in 1:num_house) {
      houselist[[i]]<-numericInput(paste0('house', i), paste0('Property Value ', i),
                                   0)
    }
    houselist
    
  })
  output$vehicle_value<- renderUI({
    vehiclelist <-tagList()
    num_vehicle <- as.integer(input$num_vehicle)
    for(i in 1:num_vehicle) {
      vehiclelist[[i]]<-numericInput(paste0('vehicle', i), paste0('Estimated Current Value ', i),
                                     0)
    }
    vehiclelist
  })
  output$creditcard_balance <- renderUI({
    creditcardlist <-tagList()
    num_creditcard <- as.integer(input$num_creditcard)
    for(i in 1:num_creditcard) {
      creditcardlist[[i]]<-numericInput(paste0('creditcard', i), paste0('Credit Card Balance ', i),
                                        0)
    }
    creditcardlist
    
  })
  output$totalAssetBox <- renderValueBox({
    valueBox(
      "1,424,256", "Total Assets", icon = icon("coins"),
      color = "purple"
    )
  })
  
  output$totalLiabilityBox <- renderValueBox({
    valueBox(
      "594,329", "Total Liabilities", icon = icon("file-invoice-dollar"),
      color = "purple"
    )
  })
  output$networthBox <- renderValueBox({
    valueBox(
      "829,927", "Economic Net Worth", icon = icon("dollar-sign"),
      color = "yellow"
    )
  })
}


#run/call the shiny app
shinyApp(ui, server)

# rsconnect::deployApp('~/R/R shiny/BalanceSheet')


