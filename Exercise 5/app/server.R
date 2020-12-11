#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(caret)
library(randomForest)

data <- read.csv("titanic.csv")
data <- data[complete.cases(data), ]
data$Survived <- factor(data$Survived)
priceData <- data[c("Pclass", "Sex", "Age", "Fare")]
survivalData <- data[c("Pclass", "Sex", "Age", "Survived")]

ctrl <-  trainControl(method = "repeatedcv", number = 10, repeats = 5, classProbs = FALSE)

priceModel <- train(Fare ~ .,
                data = priceData,
                method = "rf",
                trControl = ctrl,
                ntree = 10,
                metric = "RMSE")


ctrl2 <-  trainControl(method = "repeatedcv",number = 10,repeats = 5, classProbs = TRUE, summaryFunction = twoClassSummary)

survivedModel <- train(make.names(Survived) ~ .,
             data = survivalData,
             method = "rf",
             trControl = ctrl2,
             ntree = 10,
             metric = "ROC")

shinyServer(function(input, output) {
    
    output$outtext <- renderText({
        df <- data.frame(as.integer(input$class), input$sex, input$age)
        names(df) <- c('Pclass', 'Sex', 'Age')
        c("Ticket cost: $", predict(priceModel, df))})
    
    output$plot <- renderPlot({
        df <- data.frame(as.integer(input$class), input$sex, input$age)
        names(df) <- c('Pclass', 'Sex', 'Age')
        pred <- predict(survivedModel, df, type="prob")
        pie(c(pred[1, 1], pred[1, 2]), labels = c("Die", "Survive"), main = "Survival probability")
    })
    
})

