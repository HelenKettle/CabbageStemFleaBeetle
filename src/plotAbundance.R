#plot all abundances on one graph
plotAbundance = function(modelOutput,params,stageNames){

    source('~/GitLab/RFuncs/monthFunc.R')
    sd=params$start.DOY


    Ns=length(stageNames)
    times=modelOutput[,1]
    x=times+sd
    monthStart=monthFunc('start',1)
    monthStartLong=c(monthStart,monthStart+365,monthStart+2*365)

   
    ct=1
    dev.new()
    plot(range(x),c(0,800),type='n',ylab='Abundance',xlab='month',
         xaxt='n',cex.axis=1.5,cex.lab=1.5
)
    for (s in stageNames){
        lines(x,modelOutput[,paste0('Beetles.',s)],col=ct,lty=ct,lwd=3)
        ct=ct+1
    }
    axis(1, at=monthStartLong, labels=names(monthStartLong),cex.axis=1.2) 

    legend('topright',lwd=3,lty=1:Ns,col=1:Ns,legend=stageNames,bty='n',cex=1.3)
}






