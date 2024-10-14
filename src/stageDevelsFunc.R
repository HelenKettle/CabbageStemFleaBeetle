stageDevelsFunc=function(stage,x,time,species,strain){

    tiny=1e-12

        
        #default is the fixed duration
    v = 1/max(tiny,stage.duration[stageNames[stage]])

        
    if (params$useTempFuncs$all){
        
        if (params$useTempFuncs$eggDev & stageNames[stage]=='eggs'){

            soil.temp = tempC(time,temperatureTS,params$start.DOY,params$useSoilTemp)
            
            v = eggDevelRateFunc(soil.temp,params$eggDevRelation)

        }
            
        
        if (params$useTempFuncs$preOvi & stageNames[stage]=='pre-ovi-adults'){

            temp = tempC(time,temperatureTS,params$start.DOY)
                
            v = preOviDevelFunc(temp)

            
        }

        if (params$useTempFuncs$larvalDev & stageNames[stage]=='larvae'){
                
            temp = tempC(time,temperatureTS,params$start.DOY,FALSE,params$useStemTemp)

            v = larvalDevelRateFunc(temp)
            
        }
    
    }


    if (stageNames[stage]=='pre-adults'){
          
        #ensure that beetles do not leave diapause until after a given date

        v = preAdultDurationFunc(time,params)

    }
              

    return(max(v,tiny))
    
}
