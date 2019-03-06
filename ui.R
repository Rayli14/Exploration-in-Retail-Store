options(shiny.sanitize.errors = FALSE)
options(warn=-1)

library(shiny)
library(shinydashboard)
library(ggplot2)
library(ggthemes)
#install.packages("devtools")
library(plotly)
library(dplyr)
library("arules")
library("arulesViz")
library(DT)


####read data 
df=read.csv("BlackFriday.csv",header=TRUE,stringsAsFactor=FALSE)

data=read.transactions("test.dat") 

####


dashboardPage(
 dashboardHeader(title="BlackFriday analysis"),
 dashboardSidebar(
     sidebarMenu(
        menuItem("visualization1", tabName = "visualization1", icon = icon("dashboard")),
        menuItem("visualization2", tabName = "visualization2", icon = icon("dashboard"))
    )
),
 dashboardBody(
tabItems(
      tabItem("visualization1", 
        fluidRow(
                
        box(plotlyOutput("plot"),width=12),
        box(plotlyOutput("plot1"),width=12),
        box(plotlyOutput("plot2"),width=12),
        box(plotlyOutput("plot3"),width=12),
        box(plotlyOutput("plot4"),width=12),
        box(plotlyOutput("plot5"),width=12),
        
        box(numericInput("sup1", label = "Choose a support value to show item frequency ", value = 0.2),width=12),
        box(plotlyOutput("plot6"),width=12),
		
        box(numericInput("sup2", label = "Choose support value to search rules ", value = 0.1),width=6),
        box(numericInput("sup3", label = "Choose confidence value to search rules ", value = 0.3),width=6),
		
        box(dataTableOutput("tb"),width=12),
        box(plotlyOutput("plot7"),width=12)
		
            )
          )
        
        

        
        
        
        
        
        
        
        
        
        
        )

        
        
        
    )
)


