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
  result$num <- num
  result$account <-reactive(get(paste0(index, 1)))
  result$action <-
    observeEvent(input[[button]], {
      insertUI(paste0("#",button), "beforeBegin",
               ui= numericInput(paste0(index, num(num()+1)), 
                                paste0(title,num() ),0))
    result$account <-c(result$account,reactive(get(paste0(index, num()) )) )
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



