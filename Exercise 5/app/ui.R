#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

shinyUI(fluidPage(
    titlePanel("Titanic"),
    sidebarPanel(
        fluidRow(column(6,textInput("name", label = h3("Name"), value = "John")),),
        fluidRow(column(6,textInput("surname", label = h3("Surname"), value = "Doe"))),
        fluidRow(column(12,sliderInput("age", label = "Age", min = 1, max = 100, value = 50))),
        fluidRow(
            column(6, radioButtons("sex", label = h3("Sex"), choices = list("Male" = 'male', "Female" = 'female'))),
            column(6, radioButtons("class", label = h3("Class"), choices = list(1, 2, 3))),
        )),
    mainPanel(
        fluidRow(column(6, textOutput("outtext"))),
        fluidRow(column(6, plotOutput("plot")))
    )
))
