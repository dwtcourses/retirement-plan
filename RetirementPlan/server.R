

library(shiny)
library(shinydashboard)

# Define server logic required to draw a histogram
shinyServer(function(input, output,session){
    
    # jump pages
    observeEvent(input$jump_bank_account,  {
        updateTabItems(session, "tabs", "asset")
    })
    
    observeEvent(input$jump_credit_card,  {
        updateTabItems(session, "tabs", "ex_liab")
    })
    
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