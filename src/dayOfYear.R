dayOfYear = function(sim.time,start.doy,yearLength=365){

    #sim.time is a single number
    
    #this function adjusts the simulation time to day of year (doy)
    #It returns two versions of day of year a continuous one which runs from 0 to 364.999
    #and an integer which runs from 1,2,3,..,365.

    #meteor::photoperiod() requires time as integer between 1 and 365
    
    #sim.time model time in days from start of start.day
    #start.doy is day of year that sim.time is zero i.e. when the simulation starts (integer from 1 to 365)
    #yearLength is number of days in year (e.g. 365 (default) or 365.25)


    #we assume that sim day 1 is sim times from 0 to 0.9999999, 
    #...that sim day 2 is sim times from 1 to 1.9999999,
    #...that sim day 365 is sim times from 364 to 364.9999999 etc

    #doy        | 1 | 2 | 3 |  ....  | 364 | 365 |  1  |  2  | 3 |
    #sim.time   0   1   2   3  .... 363   364   365   366   367  368

    #check that start.doy is an integer from 1 to 365
    if (start.doy < 1){stop('start.doy must be greater than or equal to 1')}
    if (start.doy >= 366){stop('start.doy must be less than 366')}
    if (start.doy-floor(start.doy)>0){stop('start.doy must be an integer')}
    
    #adjust for start.doy
    sim.doy = start.doy + sim.time #float

    #adjust for multiple years
    sim.doy = sim.doy%%yearLength
    
    x=list()
    x$integer = ceiling(sim.doy)

    #if (sim.time == 0){x$integer=1}

    x$float = sim.doy 
    
 #   print('dayOfYear()')
 #   print(x)

    return(x)
    
}
