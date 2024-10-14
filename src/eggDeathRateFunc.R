eggDeathRateFunc=function(temp){

    #gives egg deat rate (/d) based on temp (oC)

    #Estimated from a combination of percentage of eggs that hatch (Table 5 Mathiasen)
    #and the duration of the egg stage (see eggDevelRateFunc.R)
    
    #T=c(4,8,12,16,20)
    #hatchedPercent=c(47.27,69.96,72.37,66.22,67.89)

    #dev.new(height=4,width=12)
    #par(mfrow=c(1,3))
    #plot(T,hatchedPercent)
    #lines(T,hatchedPercent)

    #development time for eggs is estimated from :
    #a=4.66e-4
    #b=1.734
    #egg.dur=1/(a*T^b)

    #alpha=-log(hatchedPercent/100)/egg.dur #from dx/dt=-alpha x

    #plot(T,alpha,ylab='specific death rate (/d)')

    ##fit exponential curve to find specific death rate (alpha)
    #lm1=lm(log(alpha)~T)
    
    #summary(lm1)
    #A=summary(lm1)$coef[1]
    #B=summary(lm1)$coef[2]

    ##log(alpha)=A+B*T
    ##alpha=exp(A)*exp(BT)
    #lines(T,exp(A)*exp(B*T),col='red')

    #eggDeathRate=0.00214*exp(0.14*T)
    #plot(T,hatchedPercent)
    #lines(T,100*exp(-eggDeathRate*egg.dur),col='green')
    
    funcName='eggDeathRateFunc()'
    if (is.null(temp)){
        stop(paste('ERROR: temperature input to',funcName,'is NULL'))
    }
    if (length(temp)>1){
        stop(paste('ERROR: temperature input to',funcName,'should be a single value'))
    }
    if (!is.finite(temp)){
        stop(paste('ERROR: temperature input to',funcName,'is NA or NaN'))
    }


    v = 0.00214*exp(0.14*temp)

    if (!is.finite(v)){stop('NaN in eggDeathRateFunc')}
    
    return(max(v,0) + params$eggDeathRate.NT)

}
    

    
