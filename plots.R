################################
# 1. Getting Started
################################

# go to http://goo.gl/Qhs3PR with a web browser and download tutorial.zip and unzip. 
# or 
# https://github.com/mmarchin/introRgraphics
# command line: git clone git@github.com:mmarchin/introRgraphics.git

# set your R working directory to the directory where you put the data
#setwd("C:/Users/mcm/Google Drive/Public/R/introRgraphics")
setwd("/Users/mcm/Google Drive/Public/R/introRgraphics")

#check that you're in the right place first - do you see files like yeardf.txt, girlranks.txt, boyranks.txt?
dir()

#to find out about a function, do ?mean

# exercise 1 - try looking at the help page for setwd.

#############################################
# 2.  Variables
#############################################

#assign 2 to a variable called num
num <- 2
num

#create a variable n with value 7.45
n <- 7.45

#variables can also hold text
mytext <- "hello"

#here we use a function - the log base 2 of 8.
log2(8)

#can also use a variable in a function
log2(num)

#num is an argument, can be named or just based on position.
#these are equivalent:
log(num,2)
log(x=num,base=2)
num + 8

# exercise 2 - what is the log base 10 of 10000?

#############################################
# 3. Vectors
#############################################

#here we are combining a list of numbers to create a vector.
c(1,3,6,8,13)
#the vector is immediately returned.

#save the vector to a variable x
x <- c(1,3,6,8,13)
x

#create another vector, y.
y <- c(2,5,4,7,12)
y

#create a text vector
vector1 <- c("hi","how","are","you")

# exercise 3 - create your own text vector with a name of your choosing.

############################################
# 4. Accessing parts of vectors
############################################

#access the fifth element of x
x[5]

#the second element of y
y[2]

#special trick that R does
1:10

values <- 1:10

#access the third through fifth elements of x
x[3:5]

# exercise 4 - what is the 5th element of y?

############################################
# 5. useful summary functions
############################################

mean(x)

#median (center or mean of two centermost elements of sorted vector)
median(x)

#minimum value of the vector
min(y)

#maximum value of the vector
max(y)

#sample standard deviation
sd(x)

#summary gives you many values at once – min, first quartile (25%), median, mean, third quartile (75%), max
summary(x)

#correlation (pearson, by default)
cor(x,y)

length(y)

# exercise 5 - what is the median of y?

#############################################
# 6. logical operators
#############################################

#is x equal to 6?
x==6	

#which elements of x are equal to 6?
which(x==6)

#you can also use greater than (>), less than (<), greater than or equal to (>=), or less than or equal to (>=).
which(x<3)

# exercise 6 - which elements of y are less than 3?

########################################
# 7. plot()
########################################

plot(x,y)

#plot takes a lot of arguments - do ?plot or ?par for more

#add a color
plot(x,y,col="blue")

#main sets the title
plot(x,y,main="x vs. y")

#pch is plotting character
plot(x,y,main="x vs. y", col="blue", pch=20)

#xlab and ylab set the axis labels
plot(x,y,main="x vs. y", xlab="x label", ylab="y label", col="red")

#for more plotting parameters, look at ?par

#############################################
# 8. Read in some data
#############################################

# the original data set - baby names from ssa.gov

#original data - list of names with at least 5 occurrences from social security card applications. For each year of birth from 1880-2012. Names are restricted to cases where the year of birth, sex, State of birth (50 States and District of Columbia) are on record, and where the given name is at least 2 characters long. Name data are not edited. For example, the sex associated with a name may be incorrect. Entries such as "Unknown" and "Baby" are not removed from the lists.

#I have messed around with the data and generated a few different files for us to use today as we explore R basic plotting.

#this first file has each year, the number of unique girl and boy names listed for each year, and the number that start and end with each letter each year.
yeardf<-read.table("data/yeardf.txt",sep='\t',as.is=T,header=T)
row.names(yeardf)<-yeardf[,1]

################################################
# 9. what's going on with this data set?
################################################

# explore the data a little

#what are the dimensions?
dim(yeardf)

#what are the column names and row names?
colnames(yeardf)
rownames(yeardf)

#first five lines?
head(yeardf)

################################################
# 10. refer to parts of a data frame
################################################

#use square brackets to refer to parts of a data frame
#dataframe[row,column]

#first row, all the columns
yeardf[1,]

#first column, all the rows
yeardf[,1]

#first five columns and first five rows?
yeardf[1:5,1:5]

#refer to a column by name a few ways
yeardf$year
yeardf[,"year"]

#multiple columns by number or name
yeardf[,c(1,3,5)]
yeardf[,c("year","num.g.names")]

#refer to rows by row name
yeardf["1880",]

# exercise 10 - use which.max() to find out which year had the most girls names that start with a. (column g.start.a)

################################################
# 11. plot(), lines(), points()
################################################

# a basic plot - year vs number of girl names
plot(yeardf$year,yeardf$num.g.names)

# turn into a line plot with argument type = 'l' (L, not one).
plot(yeardf$year,yeardf$num.g.names,type='l'
	  
#adding color, title, labels
plot(yeardf$year,yeardf$num.g.names,type='l',col='red',main="Number of Unique Names",xlab="Year",ylab="Number of Unique Names")

#add a line to an existing open plot with lines() - add the number of boy names over time
plot(yeardf$year,yeardf$num.g.names,type='l',col='red',main="Number of Unique Names",xlab="Year",ylab="Number of Unique Names")
lines(yeardf$year,yeardf$num.b.names,type='l',col='blue')

#add points to (over) an existing plot with points() - color points after 2007 blue
plot(yeardf$year,yeardf$num.g.names)
points(yeardf$year[yeardf$year > 2007],yeardf$num.g.names[yeardf$year > 2007],col='blue')

# exercise 11 - what trend do you observe for boy's names ending with n? look at column b.end.n.

###############################################
# 12. multifigure plots using par and mfrow
###############################################

#for all the girl first letters, plot the normalized trend over time
par(mfrow=c(5,6),mar=c(1,1,1.5,1))
for(i in 4:29)
{
	plot(yeardf[,i]/yeardf[,2],type='l',main=colnames(yeardf)[i],xaxt='n',yaxt='n',ylab='',xlab='')
}

#read in one more data set (optional)

#this file has each name as a column, and the position of the name within the year ranking as a percentile - so names near the top of the list for a given year have a very high rank, less popular a lower rank. Only the top 5000 names of all time are included.
girlranks_top5000<-read.table("data/girlranks_top5000.txt",sep='\t',as.is=T,header=T,row.names=1)
#boyranks_top5000<-read.table("data/boyranks_top5000.txt",sep='\t',as.is=T,header=T,row.names=1)

#if you want to look at the FULL list, uncomment these and run.
#girlranks<-read.table("data/girlranks.txt",sep='\t',as.is=T,header=T,row.names=1)
#boyranks<-read.table("data/boyranks.txt",sep='\t',as.is=T,header=T,row.names=1)

namesofinterest<-c("Velma","Daphne")
par(mfrow=c(1,2))
for(i in 1:length(namesofinterest))
{
	plot(girlranks_top5000[,1],girlranks_top5000[,colnames(girlranks_top5000) %in% namesofinterest[i]],main=namesofinterest[i],ylim=c(0,1),type='l',ylab="percentile",xlab="year")
}

#exercise 12 - make some plots with your own list of interesting names, your family, etc. If you want to look at boys names, uncomment the line above.

################################################
# 13. adding a legend
################################################

plot(yeardf$year,yeardf$num.g.names,type='l',col='red')
lines(yeardf$year,yeardf$num.b.names,type='l',col='blue')

#add a legend to an open plot
#you can use this handy shortcut syntax "topleft/bottomright" or just give it an explicit position
legend("topleft",legend=c("girl names","boy names"),col=c("red","blue"),lty=1)

#kind of a contrived example, but if you want dots instead, you use pch=1 in the legend call 
plot(yeardf$year,yeardf$num.g.names,col='red')
points(yeardf$year,yeardf$num.b.names,col='blue')
legend("topleft",legend=c("girl names","boy names"),col=c("red","blue"),pch=1)

# exercise 13 - figure out how to shrink the legend text size.

################################################
# 14. Histogram
################################################

# a histogram is a representation of the distribution of data. It shows bars whose area is equal to the frequency of observations in a given interval.

hist(yeardf[,"b.end.n"])
hist(yeardf[,"b.end.n"],breaks=20)

#let's look at how names changed from 2011 to 2012.
recent_change<-girlranks_top5000["2012",]-girlranks_top5000["2011",]

#just for curiosity, what names increased a lot from 2011 to 2012
recent_change[rev(order(recent_change,na.last=NA))][1:100]

#histogram shows us how data is distributed
hist(t(recent_change))
hist(t(recent_change),breaks=20)

################################################
# 15. Barplot
################################################

#barplot of girl starting letters, 2012
barplot(as.matrix(yeardf[133,4:29]))

#fancy that up a bit - order, make horizontal, make labels perp to axis (las)
order.iv<-order(yeardf[133,4:29])
barplot(as.vector(t(yeardf[133,4:29][order.iv])),horiz=T,las=2,names.arg=letters[order.iv],main="Girl names first letters, 2012")

# exercise 15 - make the same plot with boy names - boy first letters are columns 30:55

################################################
# 16. Boxplot
################################################

#boxplot is another way besides hist() to show distribution of data - median, lower & upper quartile, outliers. Useful when comparing data sets.

#boxplot - boys names end with n more years than girls
boxplot(yeardf[,c("g.end.n","b.end.n")])

#exercise 16 - make a box plot of girl first letters over the years (cols 4:29).

###############################################
# 17. Colors
###############################################

# at least three equivalent ways to refer to colors - name, rgb(), and hex
barplot(1:3,col=c("red",rgb(1,0,0),"#FF0000"))

install.packages(RColorBrewer)
library(RColorBrewer)
barplot(1:9,col=brewer.pal(9,"Set1"))
barplot(1:9,col=brewer.pal(9,"Set2"))
barplot(1:8,col=brewer.pal(8,"Dark2"))

display.brewer.all()

# http://research.stowers-institute.org/efg/R/Color/Chart/ColorChart.pdf

#exercise 17 - copy code from any previous plot and add a color or colors

##############################################
# 18. Heatmaps
##############################################

#read in top 50 girl names
gr50<-read.table("data/girlranks_top50.txt",sep='\t',as.is=T,header=T,row.names=1)
heatmap(as.matrix(gr50))

#make the colors a little better 
heatmap(as.matrix(gr50),col=brewer.pal(9,"Blues"))

#for more advanced heatmapping or adding a color scale, use pheatmap package or roll your own with layout() and image() ala https://github.com/mmarchin/Rutils/blob/master/mcm_image.R

###############################################
# 19. Saving graphics
###############################################

#save to a pdf with pdf() - any plots done between pdf() and dev.off() will be pages in pdf
pdf("heatmap.pdf")
heatmap(as.matrix(gr50),col=brewer.pal(9,"Blues"),cexRow=.4)
dev.off()

#save to a png
png("heatmap.png",height=1600,width=1600,pointsize=16)
heatmap(as.matrix(gr50),col=brewer.pal(9,"Blues"))
dev.off()

#exercise 19 - copy a plot from somewhere above down here and save it to a file.

##############################################
# Links
##############################################

#https://github.com/mmarchin/introR - A longer version of an intro class I've done

#http://tutorialr.com - This site is an early attempt to wade through R learning resources

#http://www.rdocumentation.org - A new site for searching all R documentation, exploring what's available

#coursera courses - https://www.coursera.org/course/compdata

###############################################
# extra stuff that I just wanted to do for fun
###############################################

#because I couldn't stop my curiosity, here is some dow jones and population data in comparison... first a bit of ugly data fixing
djia<-read.table("data/DJIA.csv",sep=',',as.is=T,header=T)
#getting the year individually
djia$year<-gsub("-.*","",djia$DATE)
#getting rid of the first and last years which are empty
djia<-djia[-1,]
djia<-djia[-119,]
#making the text value into a number
djia$VALUE<-as.numeric(djia$VALUE)
#and getting the population values for some of the years
pop<-read.table("data/pop.txt",sep='\t',header=T)

#plot girl names, dow jones, pop growth
plot(yeardf$year,yeardf$num.g.names,type='l',ylim=c(0,20000),xlab="Year",ylab="Number of names")
lines(djia$year,djia$VALUE,col='blue')
lines(pop$year,pop$nat_pop/20000,col='darkgreen')
abline(v=2007,lty=2,col='gray')
text(2000,2500,"2007",col='gray')
legend("topleft",legend=c("unique girl names","dow jones","pop growth"),col=c("black","blue","darkgreen"),lty=1)

#kmeans of girl first letters?
temp<-yeardf[,4:29]/yeardf[,2]
kmc<-kmeans(t(temp),centers=9)
par(mfrow=c(3,3),oma=c(3,3,3,3))
cols<-c(brewer.pal(8,"Dark2"),brewer.pal(9,"Set1"))
for(i in 1:9)
{
	if(length(which(kmc$cluster==i))>1)
	{
		plot(temp[,kmc$cluster==i][,1],type='n',main=paste(gsub("g.start.","",names(kmc$cluster)[kmc$cluster==i]),collapse=','),ylim=c(0,.2),ylab="")
		for(j in 1:length(which(kmc$cluster==i)))
		{
			lines(temp[,kmc$cluster==i][,j],type='l',col=cols[j])
		}
		legend("topleft",gsub("g.start.","",names(kmc$cluster)[kmc$cluster==i]),lty=1,col=cols,seg.len=1,cex=.7)
	}else
	{
		plot(temp[,kmc$cluster==i],type='l',col=cols[i],main=paste(gsub("g.start.","",names(kmc$cluster)[kmc$cluster==i])),ylim=c(0,.2),ylab="")
	}
}
mtext("girl first letters",outer=T)

