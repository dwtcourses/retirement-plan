# global.R

########Add button################

basicadd <- function(index,title){
  renderUI({
    numericInput(paste0(index,"1"), paste0(title, "1"),0)
  })
}

addbutton <- function(name){
  actionButton(name,"Add")
}

actadd <- function(button,index,title,input){
  num <- reactiveVal(1)
  num2 <- reactiveValues(clicked=1)
  result <- list()
  result$num <- reactive({num()})
  result$num2 <-  num2
  
  observeEvent(input[[button]], {
    num(num()+1)
      insertUI(paste0("#",button), "beforeBegin",
               ui= numericInput(paste0(index,num()), 
                                paste0(title,num()),0))
      num2[['clicked']] =num2[['clicked']]+1
    })
 
  return(result)
}

###################back Button########################

backbutton <- function(name){
  actionButton(name, "Back")
}


actback <- function(name,input,session){
  observeEvent(input[[name]],  {
    updateTabItems(session, "tabs", "sheet")
  })
}


##################update Button#######################

updatebutton <- function(name){
  actionButton(name,"Update")
}


actupdate<-function(button,numindex,inputindex,input){
  amnt <- reactiveValues(sum_amnt=0)
  name1 <- paste0(inputindex, 1)
  observeEvent(input[[button]], {
    amnt[['sum_amnt']]=0
    for(i in 1:numindex$num2[['clicked']]){
        amnt[['sum_amnt']] <- amnt[['sum_amnt']] +input[[paste0(inputindex,i)]]
        print(amnt[['sum_amnt']])  
    }
    
  })
  
  result <- reactive({amnt[['sum_amnt']]})
  return(result)
}





