
#########plot
library(plotly)

##count
bar_plot1=function(data,name,title=''){ 
    
    x=data[[name]]
    dt = data.frame(table(x))
    names(dt)=c("obj","val")
    dt = dt[order(dt$val, decreasing = TRUE),]
    
    p = dt %>% plot_ly( x = ~obj,y=~val) %>% add_bars() %>%layout(title = paste("Comparison between different groups in variable ' ",name,"'",sep=""))
    return(p)
    
}

#sum of sales
bar_plot2=function(data,name,title=''){ 
    
    df=data %>% group_by() %>%summarise(amt=sum(Purchase))
    dt = dt[order(dt$val, decreasing = TRUE),]
    
    p = dt %>% plot_ly( x = ~obj,y=~val) %>% add_bars() %>%layout(title = paste("Comparison between different groups in variable ' ",name,"'",sep=""))
    return(p)
    
}



for (i in (2:11)){
assign(paste("data",i,sep=""),datanew[is.na(datanew[i])==FALSE,])}  











cd="/Users/limn/Desktop/dv-final/Problem2/"
df=read.csv(paste(cd,"BlackFriday.csv",sep=""))

length(unique(df$User_ID))

df1= df %>% group_by(User_ID) %>% 
     summarise(newstate = paste(Product_ID,collapse = ",")) 
df1$newstate1=gsub(",","  ",df1$newstate)
write.table(df1$newstate1,paste(cd,"test.dat",sep=""),quote = F,sep = " ",col.names = F,row.names = F)


	 
install.packages("arules")
install.packages("arulesViz")
library("arules")
library("arulesViz")


data=read.transactions(paste(cd,"test.dat",sep="")) 
summary(data) 

#check frequency
itemFrequencyPlot(data,support=0.2) 

##rule
rules=apriori(data,parameter=list(support=0.1,confidence=0.3))
inspect(sort(rules,by="support")[1:10])

##visualization
plot(rules) 

#sheet output
m <- interestMeasure(rules, c("confidence", "oddsRatio", "leverage"),data) 