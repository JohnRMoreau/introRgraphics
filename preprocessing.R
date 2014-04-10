#setwd("C:/Users/mcm/Google Drive/Public/R/introRgraphics")
setwd("/Users/mcm/Google Drive/Public/R/introRgraphics")

yrsplain<-1880:2012
yrs<-paste("yob",yrsplain,".txt",sep="")

#make big tables of names
girltable<-data.frame(matrix(NA,nrow=2000,ncol=length(yrs)),stringsAsFactors=F)
boytable<-data.frame(matrix(NA,nrow=2000,ncol=length(yrs)),stringsAsFactors=F)
leng<-vector()
lenb<-vector()
for(i in 1:length(yrs))
{
	leng[i]<-length(which(!is.na(girltable[,i])))
	lenb[i]<-length(which(!is.na(boytable[,i])))
	data<-read.table(paste("data/names/",yrs[i],sep=''),sep=",",as.is=T)
	gl<-length(data[data[,2]=="F",1])
	bl<-length(data[data[,2]=="M",1])
	girltable[1:gl,i]<-data[data[,2]=="F",1]
	boytable[1:bl,i]<-data[data[,2]=="M",1]
}
colnames(girltable)<-yrsplain
colnames(boytable)<-yrsplain

#number of names in table, line plots over time
leng<-vector()
lenb<-vector()
allintgirl<-girltable[,1]
allintboy<-boytable[,1]
yeardf<-data.frame(matrix(nrow=length(yrs),ncol=3+(4*length(letters))))
yeardf[,1]<-yrsplain
colnames(yeardf)<-c("year","num.g.names","num.b.names",paste("g.start.",letters,sep=''),paste("b.start.",letters,sep=''),paste("g.end.",letters,sep=''),paste("b.end.",letters,sep=''))
for(i in 1:length(yrs))
{
	leng[i]<-length(which(!is.na(girltable[,i])))
	lenb[i]<-length(which(!is.na(boytable[,i])))
	yeardf[i,2]<-leng[i]
	yeardf[i,3]<-lenb[i]
	for(j in letters)
	{
		l1<-length(grep(paste("^",j,sep=''),girltable[,i],ignore.case=T))
		l2<-length(grep(paste("^",j,sep=''),boytable[,i],ignore.case=T))
		yeardf[i,paste("g.start.",j,sep='')]<-l1
		yeardf[i,paste("b.start.",j,sep='')]<-l2
		l3<-length(grep(paste(j,"$",sep=''),girltable[,i],ignore.case=T))
		l4<-length(grep(paste(j,"$",sep=''),boytable[,i],ignore.case=T))
		yeardf[i,paste("g.end.",j,sep='')]<-l3
		yeardf[i,paste("b.end.",j,sep='')]<-l4
	}
	allintgirl<-intersect(allintgirl,girltable[1:500,i])
	allintboy<-intersect(allintboy,boytable[1:500,i])
}

write.table(yeardf,"data/yeardf.txt",sep='\t',quote=F,row.names=F)
plot(leng,col='red',type='l',ylim=c(0,21000),xaxt='n',xlab="year",ylab="# of names in SSA table",main="Names over time")
axis(side=1,at=seq(from=1,to=length(yrs),by=10),labels=colnames(girltable)[seq(from=1,to=length(yrs),by=10)])
lines(lenb,col='blue')
legend("topleft",c("girls","boys"),col=c("red","blue"),lty=1)


write.table(girltable,"data/girltable.txt",sep='\t',quote=F,col.names=NA)
write.table(boytable,"data/boytable.txt",sep='\t',quote=F,col.names=NA)

allgirls<-unique(unlist(girltable))
allgirls[944]<-""

girlranks<-data.frame(matrix(ncol=length(allgirls),nrow=length(yrs)))
colnames(girlranks)<-allgirls
rownames(girlranks)<-colnames(girltable)

for(i in 1:length(allgirls))
{
	name<-vector()
	for(j in 1:length(yrs))
	{
		if(length(which(girltable[,j]==allgirls[i]))>0)
		{	
			name[j]<-which(girltable[,j]==allgirls[i])/leng[j]
		}
		else
		{
			name[j]<-0
		}
	}
	newname<- 1-name
	girlranks[,i]<-newname
}
sums<-colSums(girlranks,na.rm=T)
girltop50<-names(sums[rev(order(sums))][2:51])

girlranks.sort<-girlranks[,rev(order(sums))][2:length(girlranks[1,])]

write.table(girlranks.sort,"data/girlranks.txt",sep='\t',col.names=NA)
rownames(girlranks.sort)<-girlranks.sort[,1]
write.table(girlranks.sort[,colnames(girlranks.sort) %in% girltop50],"data/girlranks_top50.txt",sep='\t',row.names=T,col.names=NA)

allboys<-unique(unlist(boytable))
boyranks<-data.frame(matrix(ncol=length(allboys),nrow=length(yrs)))
colnames(boyranks)<-allboys
rownames(boyranks)<-colnames(boytable)

for(i in 1:length(allboys))
{
	name<-vector()
	for(j in 1:length(yrs))
	{
		if(length(which(boytable[,j]==allboys[i]))>0)
		{	
			name[j]<-which(boytable[,j]==allboys[i])/leng[j]
		}
		else
		{
			name[j]<-0
		}
	}
	newname<- 1-name
	boyranks[,i]<-newname
}

rownames(boyranks)<-boyranks[,1]

sums<-colSums(boyranks,na.rm=T)
boytop50<-names(sums[rev(order(sums))][2:51])

boyranks.sort<-boyranks[,rev(order(sums))][2:length(boyranks[1,])]
write.table(boyranks.sort,"data/boyranks.txt",sep='\t',col.names=NA)
write.table(boyranks.sort[,colnames(boyranks.sort) %in% boytop50],"data/boyranks_top50.txt",sep='\t',row.names=T,col.names=NA)

#correlation matrix of girl names?
source("U:/mcm/R/utilities/corplot.R")
cors<-corplotd(girlranks[,colnames(girlranks) %in% girltop50])
h<-heatmap(cors)
corplotd(girlranks[,colnames(girlranks) %in% girltop50][h$rowInd,h$colInd])

#line plots of names over time
#tbl<-girltable
ranktable<-girlranks
par(mfrow=c(1,3))
nameofinterest<-c("Madelaine","Madeline","Madelyn");
par(mfrow=c(3,3))
for(i in 1:length(nameofinterest))
{
	plot(ranktable[,colnames(ranktable) %in% nameofinterest[i]],axes=F,ylab="Relative Name Rank",xlab="Year",main=nameofinterest[i],ylim=c(0,1),type='l')
	axis(side=1,at=seq(from=1,to=length(yrs),by=20),labels=rownames(ranktable)[seq(from=1,to=length(yrs),by=20)])
	axis(side=2,at=seq(from=0,to=1,by=.1),labels=seq(from=0,to=1,by=.1))
}


barplot(t(tail(ranktable[,c("Mary","Anna")],20)),beside=T,ylim=c(.99,1),xpd=F)

sessionInfo()


