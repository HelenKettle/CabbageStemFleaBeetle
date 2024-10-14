eggsPerFemalePerDay = function(temp){

    #temp in oC
    #returns number of eggs laid per female per day

    #Fitted to the mean estimated eggs per female per day from Table 2 of Mathiasen et al 2015

    #----------------------------FITTING DATA--------------------------------------------
    # T  eggs/female/day (Mathiasen et al 2015, Table 2, Fig 2b)
    # 4  0.81
    # 8  1.73
    #12  2.31
    #16  5.43
    #20  6.82

    #T=seq(4,20,by=4)
    #E=c(0.81,1.73,2.31,5.43,6.82)

    #dev.new()
    #plot(c(0,21),c(0,8),type='n',xlab='T',ylab='E/d/f')
    #points(T,E)
    #lines(T,0.0525*T^1.631)
    #rsq = function (x, y) cor(x, y) ^ 2
    #rsq(E,0.0525*T^1.631)
    #print(sqrt(mean((0.0525*T^1.631-E)^2)))
    #lines(T,-1.296+0.393*T,col='blue')
    #print(sqrt(mean((-1.296+0.393*T-E)^2)))


    #Adults lay September to March

#    eggrate = max(c(-1.296 + 0.393*temp, 0))

    #saturate at 20oC as beyond range of data (don't think this will affect things as egg laying is not in summer so temperatures generally lower than 20)
    #assume no laying at temp less than zero (this seems plausible from data)

#    eggrate = 0.0527*min(max(temp,0),20)^1.631

    funcName='eggsPerFemalePerDay()'
    if (is.null(temp)){
        stop(paste('ERROR: temperature input to',funcName,'is NULL'))
    }
    if (length(temp)>1){
        stop(paste('ERROR: temperature input to',funcName,'should be a single value'))
    }
    if (!is.finite(temp)){
        stop(paste('ERROR: temperature input to',funcName,'is NA or NaN'))
    }

    #note temp must be above zero to avoid NaNs
    v = 0.0527*max(temp,0)^1.631

    if (!is.finite(v)){stop('NaN in eggsPerFemalePerDay')}

    return(max(v,0))
}
