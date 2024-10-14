tempC = function(time,temperatureTS,start.doy,useSoilTemp=FALSE,useStemTemp=FALSE){

    #this function takes the simulation time (single value) and finds the temperature on that day
    #it requires the temperature time series temperatureTS which is the output from simWeather()
    
    sim.JD = start.doy + time
    
    if (useSoilTemp){
        T = soilTemp
    }else{
        T = temperatureTS[,'Tmean']
    }
    
    v = approx(temperatureTS[,'JD'],T,sim.JD,rule=2)$y

    if (is.na(v)){
        stop('tempC() is producing NA or NaN values')
    }
    
    return(v)
}

