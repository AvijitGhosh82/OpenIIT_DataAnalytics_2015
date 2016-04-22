require("plyr")
require("ggplot2")
options(max.print=1000000)
maindata <- read.csv('MainData.csv')
require('scales')

maindata <- maindata[order(maindata$Dept),]
maindata<-plyr::arrange(maindata, Dept, Product, City)

X <- split(maindata, maindata$Product)

prod20<-X[[1]]
prod20_hist <- prod20[!is.na(as.numeric(as.character(prod20$Difference))),]


prod20_hist$Date <- as.Date(prod20_hist$Date, "%d-%m-%Y")

dat1 <- subset(prod20_hist, Difference >= 0)
dat2 <- subset(prod20_hist,Difference < 0)

ggplot() +
  geom_line(data=dat1, aes(x=Date, y=Difference, group=City, colour=City)) +
  geom_point()+
  labs(x = "Month", y = "Surplus") +
  scale_x_date(labels = date_format("%b-%Y"))