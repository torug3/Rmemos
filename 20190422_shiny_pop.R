library(shiny)
library(ggplot2)
library(dplyr)

setwd("C:/Users/****/Desktop/forR/shinytest")

data <- read.csv("H30-3-suikei.csv", header=TRUE)
data <- data[-1,]

names(data)[1] <- "ward"
names(data)[2] <- "population"
names(data)[3] <- "male"
names(data)[4] <- "female"
names(data)[5] <- "area"
names(data)[6] <- "density"
names(data)[7] <- "family"

data$ward2 <- factor(data$ward, c("�k��","�s����","������","���ԋ�","������","����","�`��",
"�吳��","�V������","�Q����","�������","�����","�������",
"������","�����","����","�铌��","�ߌ���",
"���{���","�Z�V�]��","�Z�g��","���Z�g��","�����","������"))

setwd("C:/Users/****/Desktop/forR")
setwd("C:/Users/****/Desktop/forR/shinytest")
#ui
ui <- fluidPage(
  titlePanel("PopulationVis"),

	sidebarLayout(
		sidebarPanel(
		  h5("Bar charts related to the population in Osaka city."),
		  

      	  selectInput("select", label = h3("Choose a variable to display"), 
        	  choices = c("population" = "population", "area" = "area",
                       "density" = "density", "family" = "family"), selected = "population")),
    		mainPanel(
      		plotOutput("bar")
		),
	)
)

#sever

sever <- function(input, output){
	output$bar <- renderPlot({
		ggplot(data=data)+
			geom_bar(aes_string(x="ward2", y=input$select),fill="lightblue",stat="identity")

	})

}

shinyApp(ui, sever)
