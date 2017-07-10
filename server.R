library(shiny)
library(tidyverse)
library(plotly)
load(".RData")
shinyServer(function(input, output) {
  output$plot <- renderPlotly({
      obj <- partisympati_valkrets %>% 
           filter(Valkrets %in% input$valkrets) %>% filter(Parti %in% input$parti) %>% 
           ggplot(aes(x=Månad,
                      y=Stöd,
                      ymin=Undre,
                      ymax=Övre,
                      colour=Parti,
                      group=Parti,
                      text=paste("Parti: ", Parti,"<br>Mätmånadens början: ", Månad,"<br>Stöd: ", Stöd, " (",Undre," - ",Övre,")", sep="")))+
  geom_point()+
  geom_errorbar(width=15)+
    geom_line()+
  scale_y_continuous(limits=c(0,NA))+
  scale_color_manual(
    values = c(
      "C"="#009933",    
      "KD"="#231977",      
      "L"="#6BB7EC",    
      "MP"="#83CF39",      
      "M"="#1B49DD",    
      "S"="#EE2020",    
      "SD"="#DDDD00",      
      "V"="#AF0000",    
      "ÖVR."="gray")
    )+
    ggtitle(paste("Partisympatier i ",input$valkrets, " med felmarginaler (SCBs PSU)", sep=""))+
    labs(y="Stöd (bästa parti) (%)", x="Tid (början av mätmånad)")
     obj2 <- obj %>%  ggplotly(tooltip = c("text"))
  })
  }
  )