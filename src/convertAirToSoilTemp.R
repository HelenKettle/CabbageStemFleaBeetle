convertAirToSoilTemp=function(TS,dT,avPeriod){

    #computes a trailing moving average over the period avPeriod
    #and adds on a temperature shift dT
    
    #TS is a temperature time series ([time,T]), eg the ouput from simWeather()
    #avPeriod is the time to average over in days

    #output is a vector of temperatures

    time=TS[,1]
    Ta=TS[,2]
    
    Lt=length(Ta)
    Ts=NA*Ta
    tstep=mean(diff(time),na.rm=TRUE)

    avIndex=round(avPeriod/tstep)
        
    for (i in 1:Lt){
        st=max(1,i-avIndex+1)
        fin=i
        Ts[i]=mean(Ta[st:fin])
    }

    v = Ts+dT

    return(v)
}
