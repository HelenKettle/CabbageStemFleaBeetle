immigrationFunc=function(simJD,params){

    #creates a 2 column matrix [simJD imRate]
    #imRate is based on a normal distribution around the mean immigration day (from adult trap data)
    
    immAdultsTS = cbind(simJD,rep(0,length(simJD)))
    
    imm.window=(simJD>=params$immigration[['window.st']] & simJD<=params$immigration[['window.fin']])

    v1=params$immigration[['sd']]*sqrt(2*pi)
    v2=exp(-0.5*( ((simJD[imm.window]-params$immigration[['mean.DOY']])/
                       params$immigration[['sd']])^2))
    
    immAdultsTS[imm.window,2] = params$immigration[['total']]*v2/v1

    return(immAdultsTS)
    #print(paste('starting total adults is',round(sum(immAdultsTS[,2]))))

}
