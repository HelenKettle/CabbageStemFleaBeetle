preAdultDurationFunc = function(time,params){

    #note the pre adult stage includes the diapause stage
    #to force a yearly life cycle we don't let this stage finish before
    #the earliest pre-ovi day (EPD)

    #NOTE THAT THIS FUNCTION IS NOT WRITTEN TO COPE WITH MULTIPLE YEARS!
    #it will produce an error!
    
    funcName='preAdultDurationFunc()'
    if (is.null(time)){
        stop(paste('ERROR: time input to',funcName,'is NULL'))
    }
    if (length(time)>1){
        stop(paste('ERROR: time input to',funcName,'should be a single value'))
    }
    if (!is.finite(time)){
        stop(paste('ERROR: time input to',funcName,'is NA or NaN'))
    }

    if (time>(2*365)){
        stop(paste('ERROR: ',funcName,' is not set up to cope with
multiple simulation years'))
    }
        
    sim.JD = time + params$start.DOY
    
    tau.d = params$tau.diapause+max(params$EPD-sim.JD,0)
    
    v = 1/(params$pupalAndYoungAdult.tau + tau.d)

    return(v)
}
