simWeather=function(weatherParams,simJD){

    #this function generates the weather described in Eq. 2 in paper
    #there is only one fluctuation per day

    #inputs: weatherParams list defined in Settings.R
    #        simJD is the julian day
    #output: is vector: ('JD','Tmean')
    
    #note this contains randomly varying function (rnorm) which
    #is controlled by seed in Settings.R

    sim.days = seq(min(simJD),max(simJD))
        
    if (weatherParams['sd']>0){
        fluc = rnorm(length(sim.days),mean=0,sd=as.numeric(weatherParams['sd']))
    }else{
        fluc = 0
    }

    
    W = weatherParams['a'] + weatherParams['b']*
            sin( (sim.days-weatherParams['shift'])*2*pi/365) + fluc
    
    
    temperatureTS=cbind('JD'=sim.days,'Tmean'= W)
    
    return(temperatureTS)
}
