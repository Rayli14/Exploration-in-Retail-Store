options(shiny.sanitize.errors = FALSE)
options(warn=-1)

library(data.table)
library(dplyr)
library(shiny)
library(shinydashboard)
library(ggplot2)
library(ggthemes)
#install.packages("devtools")
library(plotly)
library("arules")
library("arulesViz")
library(DT)

####read data 
df=read.csv("BlackFriday.csv",header=TRUE,stringsAsFactor=FALSE)
df$Purchase=as.numeric(df$Purchase)

data=read.transactions("test.dat") 

#############custom function 
##
bar_plot=function(data,name,title=''){ 
    
    x=data[[name]]
    dt = data.frame(table(x))
    names(dt)=c("obj","val")
    dt = dt[order(dt$val, decreasing = TRUE),]
    
    p = dt %>% plot_ly( x = ~obj,y=~val) %>% add_bars() %>%layout(title = paste("Comparison between different groups in variable ' ",name,"'",sep=""))
    return(p)
    
}

  
shinyServer(function(input,output){
#########################################################################




output$plot <- renderPlotly({

	p1=bar_plot(df,"Age","Count by age group")

	#p2
	a= df %>% group_by(Age) %>% summarise(amount=sum(Purchase))
	p2=a %>% plot_ly( x = ~Age,y=~amount) %>% add_bars() %>% layout(title = "Count(left) and Amount(right) by age group")

	subplot(p1,p2)

  })
  
output$plot1 <- renderPlotly({

	p1=bar_plot(df,"Gender","Count by Gender")

	#p2
	a= df %>% group_by(Gender) %>% summarise(amount=sum(Purchase))
	p2=a %>% plot_ly( x = ~Gender,y=~amount) %>% add_bars() %>% layout(title = "Count(left) and Amount(right) by Gender")

	subplot(p1,p2)

  })

output$plot2 <- renderPlotly({

	p1=bar_plot(df,"Occupation","Count by Occupation")

	#p2
	a= df %>% group_by(Occupation) %>% summarise(amount=sum(Purchase))
	p2=a %>% plot_ly( x = ~Occupation,y=~amount) %>% add_bars() %>% layout(title = "Count(left) and Amount(right) by Occupation")

	subplot(p1,p2)

  })

output$plot3 <- renderPlotly({

	p1=bar_plot(df,"City_Category","Count by City_Category")

	#p2
	a= df %>% group_by(City_Category) %>% summarise(amount=sum(Purchase))
	p2=a %>% plot_ly( x = ~City_Category,y=~amount) %>% add_bars() %>% layout(title = "Count(left) and Amount(right) by City_Category")

	subplot(p1,p2)

  })

output$plot4 <- renderPlotly({

	p1=bar_plot(df,"Stay_In_Current_City_Years","Count by age group")

	#p2
	a= df %>% group_by(Stay_In_Current_City_Years) %>% summarise(amount=sum(Purchase))
	p2=a %>% plot_ly( x = ~Stay_In_Current_City_Years,y=~amount) %>% add_bars() %>% layout(title = "Count(left) and Amount(right) by Stay_In_Current_City_Years")

	subplot(p1,p2)

  })
  
output$plot5 <- renderPlotly({

	p1=bar_plot(df,"Marital_Status","Count by Marital_Status")

	#p2
	a= df %>% group_by(Marital_Status) %>% summarise(amount=sum(Purchase))
	p2=a %>% plot_ly( x = ~Marital_Status,y=~amount) %>% add_bars() %>% layout(title = "Count(left) and Amount(right) by Marital_Status")

	subplot(p1,p2)

  })
  
output$plot6 <- renderPlotly({

	a=data.frame(itemFrequency(data))
	a$name=row.names(a)
	row.names(a)=1:dim(a)[1]
	names(a)=c("item_frequency","name")
	a=a %>% arrange(desc(item_frequency))
	a=a[a$item_frequency>=input$sup1,]
	

	p=a %>% plot_ly( x = ~name,y=~item_frequency) %>% add_bars() %>% layout(title = paste("Item frequency when support >= ",input$sup1,sep=""))

  })

output$tb = renderDataTable({

	rules=apriori(data,parameter=list(support=input$sup2,confidence=input$sup3))
	b=data.frame(inspect(rules))
	
    datatable(b,caption = 'rules')

})

output$plot7 <- renderPlotly({

	rules=apriori(data,parameter=list(support=input$sup2,confidence=input$sup3))
	b=data.frame(inspect(rules))
	

  	p=plot_ly(b, x = ~support,y=~confidence, type = 'scatter', mode = 'markers',
        marker = list(color = ~lift, opacity = 5)) %>%
	layout(title = paste("Rules visualization when support = ",input$sup2," and confidence = ",input$sup3,sep=""))

  })
  
  


####################################################################################
})