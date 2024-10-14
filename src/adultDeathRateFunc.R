adultDeathRateFunc=function(temp){

    #adult death rate from Mathiasen et al 2015
    
    #temp is temperature in oC
    
    #Data from Mathiasen on time for 50% to die (Table 3)
    #T=c(4,8,12,16,20) #oC
    #survivalTime=c(239,153,195,186,78) #days

    #dev.new()
    #par(mfrow=c(2,2))
    #plot(T,survivalTime)

    #plot(T,-log(0.5)/survivalTime,ylab='death rate /d')
    #V=exp(-5.49-0.07*T+0.005*T^2)
    #lines(T,V,col='red')
    #rsq = function (x, y) cor(x, y) ^ 2
    #rsq(-log(0.5)/survivalTime,V)
 
    
    #since this is a quadratic (with min at 7oC) when temperatures are below this it will start to rise.
    
    funcName='adultDeathRateFunc()'
    if (is.null(temp)){
        stop(paste('ERROR: temperature input to',funcName,'is NULL'))
    }
    if (length(temp)>1){
        stop(paste('ERROR: temperature input to',funcName,'should be a single value'))
    }
    if (!is.finite(temp)){
        stop(paste('ERROR: temperature input to',funcName,'is NA or NaN'))
    }



    v=exp(-5.49-0.07*temp+0.005*temp^2)

    if (!is.finite(v)){stop('NaN in adultDeathRateFunc')}

    return(max(v,0)+params$adultDeathRate.NT)
    
}
