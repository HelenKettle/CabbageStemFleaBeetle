larvalDevelRateFunc=function(temp){

    #made up relationship as there is no data
    #output is /d
    
    funcName='larvalDevelRateFunc()'
    if (is.null(temp)){
        stop(paste('ERROR: temperature input to',funcName,'is NULL'))
    }
    if (length(temp)>1){
        stop(paste('ERROR: temperature input to',funcName,'should be a single value'))
    }
    if (!is.finite(temp)){
        stop(paste('ERROR: temperature input to',funcName,'is NA or NaN'))
    }

    Tbase = params$larvalDuration.Tb
    TDD = params$larvalDuration.TDD
    
    #use degree day approach
    v = max((temp-Tbase),0)/TDD #gives rate (/d)

    if (!is.finite(v)){stop('NaN in larvalDevelRateFunc() output')}

    return(max(v,1e-12))
}

    
