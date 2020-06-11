# global.R

#Add button

basicadd <- function(index,title){
  renderUI({
    numericInput(paste0(index,"1"), paste0(title, "1"),0)
  })
}

addbutton <- function(button,index,title,input){
  num <- reactiveVal(1)
  result <- list()
  result$num <- reactive({num()})
  name1 <- paste0(index, 1)
  result$account <- reactive({input[[name1]]})
  #result$action <-
    observeEvent(input[[button]], {
      
      insertUI(paste0("#",button), "beforeBegin",
               ui= numericInput(paste0(index, num(num()+1)), 
                                paste0(title,num() ),0)) 
    
    name2 <-  reactive({ paste0(index, num() ) }) 
    acc <- reactive({input[[result$name2() ]]})
    result$account <- reactive({result$account()+acc()})
    })           
  return(result)
}

#back Button

backbutton <- function(name){
  actionButton(name, "Back")
}

actback <- function(name,input,session){
  observeEvent(input[[name]],  {
    updateTabItems(session, "tabs", "sheet")
  })
}



