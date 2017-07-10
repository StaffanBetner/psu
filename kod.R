library(tidyverse)
library(plotly)
library(readxl)
partisympati_valkrets <- read_excel("~/psu/partisympati valkrets.xls")
View(partisympati_valkrets)
names(partisympati_valkrets)[13:30] <- c("M Undre",
                                         "M Övre",
                                         "C Undre",
                                         "C Övre",
                                         "L Undre",
                                         "L Övre",
                                         "KD Undre",
                                         "KD Övre",
                                         "MP Undre",
                                         "MP Övre",
                                         "S Undre",
                                         "S Övre",
                                         "V Undre",
                                         "V Övre",
                                         "SD Undre",
                                         "SD Övre",
                                         "ÖVR. Undre",
                                         "ÖVR. Övre")

partisympati_valkrets <- partisympati_valkrets %>% fill(Valkrets) %>% mutate(Månad = parse_date(Månad, format="%Y-%m-%d"))
partisympati_valkrets <- partisympati_valkrets %>% 
  gather(3:11, key=Parti, value = Stöd) %>% 
  gather(4:21, key=Gräns, value = Värde) %>% 
  separate(Gräns, into=c("parti2","Gräns"), remove=T, sep=" ") %>% 
  filter(Parti == parti2) %>% 
  spread(key=Gräns, value=Värde) %>% 
  select(-parti2)

ggplotly(partisympati_valkrets %>% 
  filter(Valkrets == "Jönköpings län", Parti=="L") %>% 
  ggplot(aes(x=Månad,
             y=Stöd,
             ymin=Undre,
             ymax=Övre,
             color=Parti,
             text=paste("Mätmånadens början: ", Månad,"
Stöd: ", Stöd, " (",Undre," - ",Övre,")", sep="")))+
  geom_point()+
  geom_line()+
  geom_errorbar(width=15)+
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
      "ÖVR."="gray"
    )
  )+
  ggtitle("Partisympatier i [LÄN] (SCBs PSU)")+
  labs(y="Stöd (bästa parti) (%)",
       x="Tid (början av mätmånad)"), tooltip = c("Parti","text"))

partisympati_valkrets$Valkrets %>% unique
