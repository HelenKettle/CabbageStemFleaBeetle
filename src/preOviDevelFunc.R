preOviDevelFunc=function(temp){

    #pre-oviposition development rate (/d)

    #assume this starts after start.doy

    
    #from Mathiasen Table 1
    #temperature range of data is 4 to 20 oC but since this is a linear relationship just make sure it's above zero as it's not going to go into mad values on the higher bound.

   # T=c(4,8,12,16,20)
   # D=c(93.07,41.56,25.93,18.83,14.62)
   # temp=seq(-10,20,0.1)
   # dev.new()
   # plot(temp,a+b*temp,col='red')
   # points(T,1/D)

   # rsq = function (x, y) cor(x, y) ^ 2
   # rsq(1/D,a+b*T)

    funcName='preOviDevelFunc()'
    if (is.null(temp)){
        stop(paste('ERROR: temperature input to',funcName,'is NULL'))
    }
    if (length(temp)>1){
        stop(paste('ERROR: temperature input to',funcName,'should be a single value'))
    }
    if (!is.finite(temp)){
        stop(paste('ERROR: temperature input to',funcName,'is NA or NaN'))
    }

    a = -0.00433
    b = 0.00361

    v = a + b*temp

    if (!is.finite(v)){stop('NaN in preOviDevelFunc')}
   
    return(max(1e-12,v))
}
