
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
                 menuSubItem("Human Capital", tabName = "hum_cap"),
                 menuSubItem("Implicit Liablility", tabName = "im_liab"),
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
                              valueBoxOutput("AssetBox"),
                              actionButton('jump_bank_account', 'Bank account'),
                              actionButton('jump_investment', 'Investment'),
                              actionButton('jump_vehicle', 'Vehicle'),
                              actionButton('jump_house', 'Housing'),
                              actionButton('jump_pension', 'Pension'),
                              actionButton('jump_equity', 'equity'),
                              actionButton('jump_otherasset', 'Other Assets')
                              ),
                          
                          box(
                              title = tagList(shiny::icon("credit-card"), "Explicit Liabilities"),
                              id = "ex_liability", background = "maroon",
                              valueBoxOutput("ExLiabBox"),
                              actionButton('jump_credit_card', 'Credit Card'),
                              actionButton('jump_loan', 'Loan')
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
                      tabsetPanel(
                          id = "asset_tabs",
                          tabPanel(
                              value = "bank_tab",
                              title = "Bank Account Balance",
                              uiOutput("bank_balance"),
                              actionButton("addbank", "Add"),
                              actionButton("back2sheet", "Back")),
                              
                          tabPanel(
                              value = "investment_tab",
                              title = "Investments"),
                          
                          tabPanel(
                              value = "vehicle_tab",
                              title = "Vehicles",
                              uiOutput("vehicle_value"),
                              actionButton("addvehicle", "Add"),
                              actionButton("back2sheet", "Back")),
                          
                          tabPanel(
                              value = "house_tab",
                              title = "Housing"),
                    

                          tabPanel(
                              value = "pension_tab",
                              title = "Pension"),
                          
                          tabPanel(
                              value = "equity_tab",
                              title = "Equity"),
                          
                          tabPanel(
                              value = "otherasset_tab",
                              title = "Other Assets")
                          )
)
                      


#### Explicit Liability Page ####
ex_liab_page <- tabItem(tabName = "ex_liab",
                        tabsetPanel(
                            id = "ex_liab_tabs",
                            tabPanel(
                                value = "credit_card_tab",
                                title = "Credit Card Balance", 
                                uiOutput("credit_card_balance"),
                                actionButton("addcreditcard", "Add"),
                                actionButton("back2sheet", "Back")),
                            tabPanel(
                                value = "loan_tab",
                                title = "Loans", 
                                uiOutput("loan_balance"),
                                actionButton("addloan", "Add"),
                                actionButton("back2sheet", "Back"))
                        )
                      
)

#### Human Capital Page ####
hum_cap_page <- tabItem(tabName = "hum_cap")
                        

#### Implicit Liability Page ####
im_liab_page <- tabItem(tabName = "im_liab")

#### dashboard body ####        
body <- dashboardBody(
    tabItems(
        sheet_page,
        asset_page,
        ex_liab_page,
        hum_cap_page,
        im_liab_page,
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
