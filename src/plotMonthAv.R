plotMonthAv=function(stageName,modelOutput,start.doy,plotFig=TRUE){

    varName=paste0('Beetles.',stageName)
    
    month.len=c(J=31,F=28,M=31,A=30,M=31,J=30,J=31,A=31,S=30,O=31,N=30,D=31)
    month.end.doy=c(0,cumsum(month.len))

    out=modelOutput

    time=out[,'time']
    DOY=(time+start.doy)%%365
    
    monthAv=rep(NA,12)
    
    for (m in 1:12){
        ii=DOY>month.end.doy[m] & DOY<=month.end.doy[m+1]
        monthAv[m]=mean(out[ii,varName])
    }

    ii=is.finite(monthAv)
    if (max(monthAv[ii])<1e-12){monthAv[ii]=0}

    print(monthAv)
    if (plotFig){
        barplot(monthAv,names=names(month.len),xlab='Month',main=paste(stageName,'Abundance'))
    }
    
    return(monthAv)
    
}
    

