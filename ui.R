library(shiny)
library(tidyverse)
library(plotly)

shinyUI(navbarPage(
  "Partisympatier i olika valkretsar",
  tabPanel(
  "Diagram",
  sidebarPanel(
  selectInput(
    "valkrets",
    label = "Välj valkrets",
    choices = list("Blekinge län" ,
                   "Dalarnas län" ,
                   "Gävleborgs län" ,
                   "Göteborgs kommun",
                   "Hallands län" ,
                   "Jämtlands län",
                   "Jönköpings län" ,
                   "Kalmar län",
                   "Kronobergs län" ,
                   "Malmö kommun" ,
                   "Norrbottens län",
                   "Skåne läns norra och östra",
                   "Skåne läns södra" ,
                   "Skåne läns västra",
                   "Stockholms kommun",
                   "Stockholms län",
                   "Södermanlands län",
                   "Uppsala län",
                   "Värmlands län",
                   "Västerbottens län" ,
                   "Västernorrlands län",
                   "Västmanlands län" ,
                   "Västra Götalands läns norra",
                   "Västra Götalands läns södra" ,
                   "Västra Götalands läns västra" ,
                   "Västra Götalands läns östra",
                   "Örebro län" ,
                   "Östergötlands län"),
    selected = "Dalarnas län"
  ),
  checkboxGroupInput(
    "parti",
    label = h3("Vilka partier vill du visa?"),
    choices = list(
      "Centerpartiet" = "C",
      "Kristdemokraterna" = "KD",
      "Liberalerna" = "L",
      "Miljöpartiet" = "MP",
      "Moderaterna" = "M",
      "Socialdemokraterna" = "S",
      "Sverigedemokraterna" = "SD",
      "Vänsterpartiet" = "V",
      "Övriga" = "ÖVR."
    ),
    selected = c(
      "C"
    )
  )
),
mainPanel(plotlyOutput(
  "plot", width = 800, height = 600
)))
))