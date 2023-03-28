library(hyperSpec)
library(pracma)

colors.graph2<-c("#000000","#00004d","#000066","#000080","#0000FFFF","#0036FFFF","#006BFFFF","#00A1FFFF" , "#00D7FFFF","#00FF51FF", "#00FF1BFF", "#1BFF00FF", "#86FF00FF", "#BCFF00FF", "#F2FF00FF", "#FFD700FF", "#FFA100FF", "#FF6B00FF","#FF3600FF", "#FF0000FF")

setwd('folder_path\\')
namefile<-"filename_prec7.txt"
acq.temp<-read.txt.Renishaw(namefile)

plotmap(acq.temp,col.regions = colors.graph2,xlab="x [mm]", ylab="y [mm]")

acq.temp$filename<-'label'#choose the label you prefer

#from data to mean
means.temp<- aggregate (acq.temp, by = acq.temp$filename, mean_pm_sd)

#histogram of intensities
h.temp<-hist(means.temp[2]$spc,xlab=expression('Intensity [counts]'), breaks=750)

x<- h.temp$mids[]
y<-h.temp$counts[]

plot(x,y,type='h',lwd=3)
#plot(x,y,type='h',xlim=c(0,0.007),lwd=3)
#plot(means.temp[2]@wavelength,means.temp[2]$spc/(means.temp[3]$spc-means.temp[2]$spc),type='h',xlim=c(0,0.007),lwd=3)


#fit distribution with lognormal function
res<-nls(y ~ A0 * dlnorm(x,mu,sigma), start=list(A0=30000, mu=3.4, sigma=0.25), control = list(maxiter = 500, warOnly=TRUE), trace=TRUE)

y.fitted.temp<-predict(res)


#set threshold and see the effect

threshold<-exp(coefficients(res)[2]+0.5*coefficients(res)[3]^2)+exp(coefficients(res)[2]+0.5*coefficients(res)[3]^2)*sqrt(exp(coefficients(res)[3]^2)-1)

lines(x, y.fitted.temp, col='red', type='l', lwd = 2, add=TRUE)
abline( v = threshold,col='blue',lwd = 2)

dev.new()
plot(tck=0.02, means.temp[2]@wavelength, means.temp[2]$spc, type='h', lwd = 2, pch=16, xlab='m/z',  ylab='Intensity [counts]', xlim=c(600,900), ylim=c(0,max(means.temp[2]+0.005)))
dev.new()
plot(tck=0.02, means.temp@wavelength[which(means.temp[2]$spc>threshold)], means.temp[2,,means.temp@wavelength[which(means.temp[2]$spc>threshold)]]$spc, type='h', lwd = 2, pch=16, xlab='m/z', ylab='Intensity [counts]', xlim=c(600,900), ylim=c(0,max(means.temp[2]+0.005)))

a<-size(means.temp@wavelength[which(means.temp[2]$spc>threshold)])[2]


peaks.nonoise.temp<-matrix(1:(2*a),nrow=a,ncol=2)
peaks.nonoise.temp[,1]<-means.temp@wavelength[which(means.temp[2]$spc>threshold)]
peaks.nonoise.temp[,2]<-means.temp[2,,means.temp@wavelength[which(means.temp[2]>threshold)]]$spc


acq.temp.denoised<-acq[,,peaks.nonoise.temp[,1]]


