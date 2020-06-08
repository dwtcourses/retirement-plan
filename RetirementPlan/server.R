

library(shiny)
library(shinydashboard)

# Define server logic required to draw a histogram
shinyServer(function(input, output,session){
    
    # jump pages
    observeEvent(input$jump_bank_account,  {
        updateTabItems(session, "tabs", "asset")
        updateTabsetPanel(session = session, inputId = "asset_tabs", selected = "bank_tab")
    })
    
    observeEvent(input$jump_investment,  {
        updateTabItems(session, "tabs", "asset")
        updateTabsetPanel(session = session, inputId = "asset_tabs", selected = "investment_tab")
    })
    
    observeEvent(input$jump_vehicle,  {
        updateTabItems(session, "tabs", "asset")
        updateTabsetPanel(session = session, inputId = "asset_tabs", selected = "vehicle_tab")
    })
    
    observeEvent(input$jump_house,  {
        updateTabItems(session, "tabs", "asset")
        updateTabsetPanel(session = session, inputId = "asset_tabs", selected = "house_tab")
    })
    
    observeEvent(input$jump_pension,  {
        updateTabItems(session, "tabs", "asset")
        updateTabsetPanel(session = session, inputId = "asset_tabs", selected = "pension_tab")
    })
    
    observeEvent(input$jump_equity,  {
        updateTabItems(session, "tabs", "asset")
        updateTabsetPanel(session = session, inputId = "asset_tabs", selected = "equity_tab")
    })
    
    
    observeEvent(input$jump_otherasset,  {
        updateTabItems(session, "tabs", "asset")
        updateTabsetPanel(session = session, inputId = "asset_tabs", selected = "otherasset_tab")
    })
    
    observeEvent(input$jump_credit_card,  {
        updateTabItems(session, "tabs", "ex_liab")
        updateTabsetPanel(session = session, inputId = "ex_liab_tabs", selected = "credit_card_tab")
    })
    
    observeEvent(input$jump_loan,  {
        updateTabItems(session, "tabs", "ex_liab")
        updateTabsetPanel(session = session, inputId = "ex_liab_tabs", selected = "loan_tab")
    })
    
    observeEvent(input$back2sheet,  {
        updateTabItems(session, "tabs", "sheet")
    })
    
    ### bank account balance ####
    output$bank_balance <- renderUI({
        numericInput(paste0('bank_account', 1), paste0('Balance ', 1),0)
        # numericInput(varaible name,title, number )
    })

    ## reactive values
    # store history as reactive values
    num_bank <- reactiveValues(clicked = c(1)) # number of clicks
    observeEvent(input$addbank, {
        num_bank[['clicked']] <- 
            c(num_bank[['clicked']],length(num_bank[['clicked']])+1)
        insertUI("#addbank", "beforeBegin",
                 ui= numericInput(paste0('bank_account', length(num_bank[['clicked']])), 
                                  paste0('Balance ',length(num_bank[['clicked']]) ),0))
    })
    
    ### Vehicle Value ####
    output$vehicle_value <- renderUI({
        numericInput(paste0('vehicle', 1), paste0('Vehicle ', 1),0)
        # numericInput(varaible name,title, number )
    })
    
    num_vehicle <- reactiveValues(clicked = c(1)) # number of clicks
    observeEvent(input$addvehicle, {
        num_vehicle[['clicked']] <- 
            c(num_vehicle[['clicked']],length(num_vehicle[['clicked']])+1)
        insertUI("#addvehicle", "beforeBegin",
                 ui= numericInput(paste0('vehicle', length(num_vehicle[['clicked']])), 
                                  paste0('Vehicle ',length(num_vehicle[['clicked']]) ),0))
    })
    ### credit card balance ####
    output$credit_card_balance <- renderUI({
        numericInput(paste0('credit_card', 1), paste0('Balance ', 1),0)
        # numericInput(varaible name,title, number )
    })

    num_credit_card <- reactiveValues(clicked = c(1)) # number of clicks
    observeEvent(input$addcreditcard, {
        num_credit_card[['clicked']] <- 
            c(num_credit_card[['clicked']],length(num_credit_card[['clicked']])+1)
        insertUI("#addcreditcard", "beforeBegin",
                 ui= numericInput(paste0('credit_card', length(num_credit_card[['clicked']])), 
                                  paste0('Balance ',length(num_credit_card[['clicked']]) ),0))
    })
    
    
    ### loans #####
    output$loan_balance <- renderUI({
        numericInput(paste0('loan', 1), paste0('Loan ', 1),0)
        # numericInput(varaible name,title, number )
    })
    
    num_loan <- reactiveValues(clicked = c(1)) # number of clicks
    observeEvent(input$addloan, {
        num_loan[['clicked']] <- 
            c(num_loan[['clicked']],length(num_loan[['clicked']])+1)
        insertUI("#addloan", "beforeBegin",
                 ui= numericInput(paste0('loan_account', length(num_loan[['clicked']])), 
                                  paste0('Loan ',length(num_loan[['clicked']]) ),0))
    })
    
    
    
    
    ### subtotal and total output ####
    # functions to calculate ...
    total_fin_asset <- 30
    total_ex_liab <- 40
    total_im_liab <- 40
    total_hum_capital <- 70
    
    # calculate total asset
    total_asset <- total_fin_asset+total_hum_capital
    
    # calculate total liability
    total_liab <- total_im_liab + total_ex_liab
    
    # calculate total economic networth
    econ_net_worth <- total_asset - total_liab
    
    # value boxes output
    output$AssetBox <- renderValueBox({
        valueBox(
            total_fin_asset, "Subtotal", icon = icon("coins")
        )
    })  
    
    output$CapitalBox <- renderValueBox({
        valueBox(
            total_hum_capital, "Subtotal", icon = icon("coins"),
            color = "teal"
        )
    })  
    
    output$ExLiabBox <- renderValueBox({
        valueBox(
            total_ex_liab, "Subtotal", icon = icon("file-invoice-dollar"),
            color = "maroon"
        )
    }) 
    
    output$ImLiabBox <- renderValueBox({
        valueBox(
            total_im_liab, "Subtotal", icon = icon("file-invoice-dollar"),
            color = "purple"
        )
    })  
    
    output$totalAssetBox <- renderValueBox({
        valueBox(
            total_asset, "Total Assets", icon = icon("coins"),
            color = "blue"
        )
    })   
    output$totalLiabilityBox <- renderValueBox({
        valueBox(
            total_liab, "Total Liabilities", icon = icon("file-invoice-dollar"),
            color = "yellow"      
            )
    })
    output$networthBox <- renderValueBox({
        valueBox(
            econ_net_worth, "Economic Net Worth", icon = icon("dollar-sign"),
            color = "red"
        )
    })
})


# update for webpage application

# rsconnect::deployApp('~/R/R shiny/RetirementPlan')