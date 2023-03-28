

#Report the correct number of peaks in the datasets

rnum<-817 #section
cnum<-541 #replica

#In the following loop, that builds the matrix of differences, do change the dataset names before running

toselectmz<-matrix(1:(rnum*cnum), nrow = rnum, ncol = cnum)

for (i in 1:rnum){
  for (j in 1:cnum){
    
    toselectmz[i,j]<-acq.section.tumour@wavelength[i]-acq.replica.tumour@wavelength[j] #section - replica , change dataset names before running
    
  }
}

#how many peak positions are equal to section positions? (given the m/z tolerance)

howmany.rep.eq.sec.025<-rep(0,cnum)

for (i in 1:cnum){
  howmany.rep.eq.sec.025[i]<-length(which(abs(toselectmz[,i])<0.025)) #here you set tolerance
}

equal.025<-which(howmany.rep.eq.sec.025==1) #they are replicas wavelength vector positions
multiple.025<-which(howmany.rep.eq.sec.025>1)

#When m/z position difference is below tolerance, the following 2 loops sets the same m/z value of the section in the replica dataset
#if more than one are found, the one with minimum difference is selected

secpos.rep.eq.sec.025<-rep(0,cnum)
for (i in 1:cnum){
  
  support<-length(which(abs(toselectmz[,i])<0.025)) #here you set tolerance
  if(support==1){
    secpos.rep.eq.sec.025[i]<-which(abs(toselectmz[,i])<0.025) #here you set tolerance
  }else{
    if(support>1){
      secpos.rep.eq.sec.025[i]<-which.min(abs(toselectmz[which(abs(toselectmz[,i])<0.025),i])) #here you set tolerance
    }
  }
}


acq.replica.premer.025<-acq.replica.tumour #replica
for (i in 1:cnum){
  
  if(secpos.rep.eq.sec.025[i]>0){
    acq.replica.premer.025@wavelength[i]<-acq.section.tumour@wavelength[secpos.rep.eq.sec.025[i]]
  }
}

#Now the premerging replica file has same m/z of section where the difference is below tolerance
#Here following, (X,y) position of the replica are modified to have section and replica disposed in diagonal and not overlapping

acq.replica.premer.025$x<-acq.replica.premer.025$x-min(acq.replica.premer.025$x)+max(acq.section.tumour$x) #repprem<-repprem-rep+sec
acq.replica.premer.025$y<-acq.replica.premer.025$y-min(acq.replica.premer.025$y)+max(acq.section.tumour$y)

#Set equal filename for merging

acq.section.tumour$filename<-'tum2'
acq.replica.premer.025$filename<-'tum2'

#merge the two datasets

acq.tum2.025<-collapse(acq.section.tumour,acq.replica.premer.025)

#order the m/z
acq.tum2.025$spc[which(is.na(acq.tum2.025$spc))]<-0
acq.tum2.025.ord<-acq.tum2.025[,,acq.tum2.025@wavelength[order(acq.tum2.025@wavelength)]]
