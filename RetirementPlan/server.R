

library(shiny)
library(shinydashboard)

source("global.R")

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
    
    #observeEvent(input$back2sheet,  {
    #    updateTabItems(session, "tabs", "sheet")
    #})
    
    ### bank account balance ####
    output$bank_balance <- basicadd("bank_account","Balance ")
    
    bankaccount <- actadd("add_bank","bank_account","Balance ",input)
    
    actback("back_bank",input,session)
    sum_bank <- actupdate("update_bank",bankaccount,"bank_account",input)

    ### Vehicle Value ####
    output$vehicle_value <- basicadd("vehicle","Vehicle ")
    
    vehicle<- actadd("add_veh",'vehicle','Vehicle ',input)
    
    actback("back_veh",input,session)
    sum_veh <- actupdate("update_veh",vehicle,"vehicle",input)
   

    ### credit card balance ####
    output$credit_card_balance <- basicadd("credit_card","Balance ")
    
    creditcard<- actadd("add_cred","credit_card","Balance ",input)
    
    actback("back_cred",input,session)
    sum_cred <- actupdate("update_cred",creditcard,"credit_card",input)
    
    ### loans #####
    output$loan_balance <- basicadd("loan","Loan ")
    
    loan_loan<- actadd("add_loan","loan","Loan ",input)
    
    actback("back_loan",input,session)
    sum_loan <- actupdate("update_loan",loan_loan,"loan",input)
    
   
    ### subtotal and total output ####
    # functions to calculate ...
    total_fin_asset <- reactive({sum_bank()+sum_veh()})
    total_ex_liab <- reactive({sum_cred()+sum_loan()})
    total_im_liab <- 40
    total_hum_capital <- 70
    
    # calculate total asset
    total_asset <- reactive({total_fin_asset() + total_hum_capital})
    
    # calculate total liability
    total_liab <- reactive({total_im_liab + total_ex_liab()})
    
    # calculate total economic networth
    econ_net_worth <- reactive({total_asset() - total_liab()})
    
    # value boxes output
    output$AssetBox <- renderValueBox({
        valueBox(
            total_fin_asset(), "Subtotal", icon = icon("coins")
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
            total_ex_liab(), "Subtotal", icon = icon("file-invoice-dollar"),
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
            total_asset(), "Total Assets", icon = icon("coins"),
            color = "blue"
        )
    })   
    output$totalLiabilityBox <- renderValueBox({
        valueBox(
            total_liab(), "Total Liabilities", icon = icon("file-invoice-dollar"),
            color = "yellow"      
            )
    })
    output$networthBox <- renderValueBox({
        valueBox(
            econ_net_worth(), "Economic Net Worth", icon = icon("dollar-sign"),
            color = "red"
        )
    })
})


# update for webpage application

# rsconnect::deployApp('~/R/R shiny/RetirementPlan')