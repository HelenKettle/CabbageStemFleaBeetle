eggDevelRateFunc=function(temp,relationship){

    #this gives the instantaneous egg development rate (/d)
    #based on a number of thermal degree day relationship ('relationship' input)
    #and the current temperature ('temp' single value input)

    #output has a minimum value of 1e-12

    funcName='eggDevelRateFunc()'
    if (is.null(temp)){
        stop(paste('ERROR: temperature input to',funcName,'is NULL'))
    }
    if (length(temp)>1){
        stop(paste('ERROR: temperature input to',funcName,'should be a single value'))
    }
    if (!is.finite(temp)){
        stop(paste('ERROR: temperature input to',funcName,'is NA or NaN'))
    }
 
    Tbase=c('Mathiasen'=5.1,'Alford'=3.2,'Johnen'=4,'Bonnemaison'=7)
    TDD=c('Mathiasen'=185,'Alford'=240,'Johnen'=200,'Bonnemaison'=160)

    if (relationship%in%names(Tbase)){
    
        #use degree day approach
        v = max((temp-Tbase[relationship]),0)/TDD[relationship]

    }else if (relationship=='power'){

    #Egg development rate is fitted to the data from Fig 4b in Mathiasen et al.
    #Used webplotdigitizer to extract the mean points and fitted relationship to that
    #bound temperatures at 4 degrees C
        
        a=0.00047
        b=1.734
        v=a*max(temp,0)^b

    }else{

        stop('egg development relationship is not defined')

    }
    
    if (!is.finite(v)){stop('NaN in eggDevelRateFunc')}
     
    return(max(v,1e-12))
}

    
