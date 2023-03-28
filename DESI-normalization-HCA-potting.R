library(lattice)
library(ggplot2)
library(grid)
library(hyperSpec)
library(plotrix)
library(baseline)

#IMPORT DATA IN HYPERSPEC OBJECT

setwd('folder_path\\') #NOTE:use backslash before each and every backslash
namefile<-'filename.txt'
acq.tot<-read.txt.Renishaw(namefile)

#SELECT THE APPROPRIATE ROI
#For the human biopsy dataset the ROIs are given in the file "ROIs_definition.xlsx"
#here are given the values of ymin, xmin, ymax, xmax for the replica 25, once imported the dataset "20-21-23-25-29-r" 

ymin<-13.1
xmin<- -3.5 #leave a space between arrow and minus sign, when negative coordinate
ymax<-19.3
xmax<-2.8

acq<-acq.tot[acq.tot$y>ymin & acq.tot$x > xmin & acq.tot$y<ymax & acq.tot$x< xmax]

#NORMALIZATION BY TIC

acq.norm<- sweep (acq, 1, sum, "/")

#HCA

dist.norm<-pearson.dist(acq.norm[[]])
dendrogram.norm<- hclust (dist.norm, method = "ward.D")
acq.norm$clusters<-as.factor(cutree(dendrogram.norm,k=6)) #here select number of clusters

#change following based on the number of clusters

levels (acq.norm$clusters) <- c ("a", "b", "c", "d","e","f")

cluster.cols <- c ("#C02020", "orange", "darkolivegreen2", "forestgreen","cyan3","dark blue")
#cluster.cols <- c ("#C02020",  "dark blue", "orange", "cyan3","coral","yellow3")

#CALCULATE AVERAGE SPECTRA FOR THE CLUSTERS

means.norm<- aggregate (acq.norm, by = acq.norm$clusters, mean_pm_sd)

#PLOT AVERAGE SPECTRA AND CLUSTERMAP

dev.new()
plot (means.norm, col = cluster.cols, stacked = ".aggregate", fill = ".aggregate",plot.args=list(xlab='m/z',ylab="Normalized Intensity"), lines.args=list(type='h'))
dev.new()
plotmap(acq.norm, clusters~x*y, col.regions=cluster.cols,xlab="x [mm]", ylab="y [mm]")

#REMOVE CLUSTERS ASSOCIATED WITH BACKGROUND

out<-which(acq.norm$clusters=='a')
out<-c(out, which(acq.norm$clusters=='b'))
out<-c(out, which(acq.norm$clusters=='c'))
#out<-c(out, which(acq.norm$clusters=='d'))

acq.norm.cut<-acq.norm[-out]

#--- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---

#REPEAT HCA

dist.norm.cut<-pearson.dist(acq.norm.cut[[]])
dendrogram.norm.cut<- hclust (dist.norm.cut, method = "ward.D")
acq.norm.cut$clusters<-as.factor(cutree(dendrogram.norm.cut,k=3)) #here select number of clusters

#change following based on the number of clusters

levels (acq.norm$clusters) <- c ("a", "b", "c")
#levels (acq.norm.cut$clusters) <- c ("a", "b", "c", "d","e","f")

cluster.cols <- c ("#C02020", "forestgreen","dark blue")
#cluster.cols <- c ("#C02020",  "dark blue", "orange", "cyan3","coral","yellow3")

#CALCULATE AVERAGE SPECTRA FOR THE CLUSTERS

means.norm.cut<- aggregate (acq.norm.cut, by = acq.norm.cut$clusters, mean_pm_sd)

#PLOT AVERAGE SPECTRA AND CLUSTERMAP

dev.new()
plot (means.norm.cut, col = cluster.cols, stacked = ".aggregate", fill = ".aggregate",plot.args=list(xlab='m/z',ylab="Normalized Intensity"), lines.args=list(type='h'))
dev.new()
plotmap(acq.norm.cut, clusters~x*y, col.regions=cluster.cols,xlab="x [mm]", ylab="y [mm]")



#HERE FOLLOWS CODE TO PLOT CLUSTERMAPS WITH INCREASING NUMBER OF CLUSTERS


###

acq.norm.cut$clusters<-as.factor(cutree(dendrogram.norm.cut,k=2))

levels (acq.norm.cut$clusters) <- c ("a", "b")

cluster.cols <- c ("#C02020", "orange")

means.norm.cut<- aggregate (acq.norm.cut, by = acq.norm.cut$clusters, mean_pm_sd)
dev.new()
plot (means.norm.cut, col = cluster.cols, stacked = ".aggregate", fill = ".aggregate",plot.args=list(xlab='m/z',ylab="Normalized Intensity"), lines.args=list(type='h'))
dev.new()
plotmap(acq.norm.cut, clusters~x*y, col.regions=cluster.cols,xlab="x [mm]", ylab="y [mm]")

acq.norm.cut$clusters<-as.factor(cutree(dendrogram.norm.cut,k=3))

levels (acq.norm.cut$clusters) <- c ("a", "b", "c")

cluster.cols <- c ("#C02020", "orange", "dark blue")

means.norm.cut<- aggregate (acq.norm.cut, by = acq.norm.cut$clusters, mean_pm_sd)
dev.new()
plot (means.norm.cut, col = cluster.cols, stacked = ".aggregate", fill = ".aggregate",plot.args=list(xlab='m/z',ylab="Normalized Intensity"), lines.args=list(type='h'))
dev.new()
plotmap(acq.norm.cut, clusters~x*y, col.regions=cluster.cols,xlab="x [mm]", ylab="y [mm]")



acq.norm.cut$clusters<-as.factor(cutree(dendrogram.norm.cut,k=4))

levels (acq.norm.cut$clusters) <- c ("a", "b","c","d")

cluster.cols <- c ("#C02020", "orange","forestgreen","dark blue")

means.norm.cut<- aggregate (acq.norm.cut, by = acq.norm.cut$clusters, mean_pm_sd)
dev.new()
plot (means.norm.cut, col = cluster.cols, stacked = ".aggregate", fill = ".aggregate",plot.args=list(xlab='m/z',ylab="Normalized Intensity"), lines.args=list(type='h'))
dev.new()
plotmap(acq.norm.cut, clusters~x*y, col.regions=cluster.cols,xlab="x [mm]", ylab="y [mm]")


acq.norm.cut$clusters<-as.factor(cutree(dendrogram.norm.cut,k=5))

levels (acq.norm.cut$clusters) <- c ("a", "b", "c", "d","e")

cluster.cols <- c ("#C02020", "orange", "darkolivegreen2", "forestgreen","dark blue")

means.norm.cut<- aggregate (acq.norm.cut, by = acq.norm.cut$clusters, mean_pm_sd)
dev.new()
plot (means.norm.cut, col = cluster.cols, stacked = ".aggregate", fill = ".aggregate",plot.args=list(xlab='m/z',ylab="Normalized Intensity"), lines.args=list(type='h'))
dev.new()
plotmap(acq.norm.cut, clusters~x*y, col.regions=cluster.cols,xlab="x [mm]", ylab="y [mm]")


acq.norm.cut$clusters<-as.factor(cutree(dendrogram.norm.cut,k=6))

levels (acq.norm.cut$clusters) <- c ("a", "b", "c", "d","e","f")

cluster.cols <- c ("#C02020", "orange", "darkolivegreen2", "forestgreen","cyan3","dark blue")

means.norm.cut<- aggregate (acq.norm.cut, by = acq.norm.cut$clusters, mean_pm_sd)
dev.new()
plot (means.norm.cut, col = cluster.cols, stacked = ".aggregate", fill = ".aggregate",plot.args=list(xlab='m/z',ylab="Normalized Intensity"), lines.args=list(type='h'))
dev.new()
plotmap(acq.norm.cut, clusters~x*y, col.regions=cluster.cols,xlab="x [mm]", ylab="y [mm]")


acq.norm.cut$clusters<-as.factor(cutree(dendrogram.norm.cut,k=7))

levels (acq.norm.cut$clusters) <- c ("a", "b", "c", "d","e","f","g")

cluster.cols <- c ("#C02020", "orange", "darkolivegreen2", "forestgreen","cyan3","dark blue","coral")

means.norm.cut<- aggregate (acq.norm.cut, by = acq.norm.cut$clusters, mean_pm_sd)
plot (means.norm.cut, col = cluster.cols, stacked = ".aggregate", fill = ".aggregate",plot.args=list(xlab='m/z',ylab="Normalized Intensity"), lines.args=list(type='h'))
plotmap(acq.norm.cut, clusters~x*y, col.regions=cluster.cols,xlab="x [mm]", ylab="y [mm]")


acq.norm.cut$clusters<-as.factor(cutree(dendrogram.norm.cut,k=8))

levels (acq.norm.cut$clusters) <- c ("a", "b", "c", "d","e","f","g","h")

cluster.cols <- c ("#C02020", "orange", "darkolivegreen2", "forestgreen","cyan3","dark blue","coral","yellow3")

means.norm.cut<- aggregate (acq.norm.cut, by = acq.norm.cut$clusters, mean_pm_sd)
plot (means.norm.cut, col = cluster.cols, stacked = ".aggregate", fill = ".aggregate",plot.args=list(xlab='m/z',ylab="Normalized Intensity"), lines.args=list(type='h'))
plotmap(acq.norm.cut, clusters~x*y, col.regions=cluster.cols,xlab="x [mm]", ylab="y [mm]")

