
library(shiny)
library(shinydashboard)

# Dashboard header carrying the title of the dashboard
header <- dashboardHeader(title = "Personal Financial Planning",titleWidth = 300) 

# Sidebar content of the dashboard
sidebar <- dashboardSidebar(
    sidebarMenu(id = "tabs",
        menuItem("Personal Balance Sheet", icon = icon("th"), tabName = "balance_sheet",
                 menuSubItem("Balance Sheet", tabName = "sheet"),
                 menuSubItem("Financial Assets", tabName = "asset"),
                 menuSubItem("Explicit Liablility", tabName = "ex_liab"),
                 menuSubItem("Saving and Consumption", tabName = "suggestion")),
        menuItem("Home Mortgage Financing", tabName = "house", icon = icon("home")),
        menuItem("Life and Health Insurance", tabName = "insurance", icon = icon("heart")),
        menuItem("Pensions and Retirement", tabName = "retirement", icon = icon("dashboard"))
    )
)




#### Balance sheet page ####
sheet_page <- tabItem(tabName = "sheet",
                      fluidRow(
                          box(
                              title = tagList(shiny::icon("wallet"), "Financial Assets"),
                              id = "asset", background = "aqua",
                              actionButton('jump_bank_account', 'Bank account'),
                              valueBoxOutput("AssetBox")
                              ),
                          box(
                              title = tagList(shiny::icon("credit-card"), "Explicit Liabilities"),
                              id = "ex_liability", background = "maroon",
                              actionButton('jump_credit_card', 'Credit Card'),
                              valueBoxOutput("ExLiabBox")
                              ),
                      ),
                
                      fluidRow(
                          box(
                              title = tagList(shiny::icon("briefcase"), "Human Capital"),
                              # The id lets us use input$tabset1 on the server to find the current tab
                              id = "asset", background = "teal",
                              valueBoxOutput("CapitalBox")
                          ),
                          box(
                              title = tagList(shiny::icon("money-bill"), "Implicit Liabilities"),
                              # The id lets us use input$tabset1 on the server to find the current tab
                              id = "im_liability", background = "purple",
                              valueBoxOutput("ImLiabBox")
                          )
                      ),   
                      fluidRow(
                          valueBoxOutput("totalAssetBox"),
                          valueBoxOutput("totalLiabilityBox"),
                          valueBoxOutput("networthBox")
                      )    
                      
)

#### Financial Asset Page ####
asset_page <- tabItem(tabName = "asset",
                             fluidRow(
                             box(
                                 title = tagList(shiny::icon("bank"), "Bank Account"),
                                 id = "bank_account_balance", 
                                 numericInput("bank_account", "Account Balance",
                                          0))
                             )
                             
)

#### Explicit Liability Page ####
ex_liab_page <- tabItem(tabName = "ex_liab",
                      fluidRow(
                          box(
                              title = tagList(shiny::icon("bank"), "Credit Card"),
                              id = "CreditCards", 
                              numericInput("credit_card", "Balance",
                                           0))
                      )
                      
)



#### dashboard body ####        
body <- dashboardBody(
    tabItems(
        sheet_page,
        asset_page,
        ex_liab_page,
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

#### complete the ui with dashboardPage #####
shinyUI(dashboardPage(title = 'Personal_financial_planning', header, sidebar, body, skin='blue'))
