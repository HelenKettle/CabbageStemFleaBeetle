changeWeather=function(season,dT,JD){

    #modify temperature time series by dT for a particular season
    #JD is a vector of julian days
    #output is a vector of dTs to add to the base weather time series


    DOY=JD%%365

    month.ends=monthFunc('end',3)

    if (season%in%c('winter','Winter')){
        ii=(DOY>month.ends['nov'] | DOY<=month.ends['feb'])
        
    }else if (season%in%c('spring','Spring')){
        ii=(DOY>month.ends['feb'] & DOY<=month.ends['may'])
        
    }else if (season%in%c('summer','Summer')){
        ii=(DOY>month.ends['may'] & DOY<=month.ends['aug'])
        
    }else if (season%in%c('autumn','Autumn')){
        ii=(DOY>month.ends['aug'] & DOY<=month.ends['nov'])
        
    }else{
        stop(error('specify season from winter, spring, summer or autumn in changeWeather()'))
    }


    dT.ts=0*DOY

    if (sum(ii)>0){
        dT.ts[ii]=dT
    }


    return(dT.ts)
}
