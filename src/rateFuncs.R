
rateFunctions<-list(

    
    reproFunc=function(x,time,species,strain){
        #print('repro st')

        egg.rate=params$eggLayingRate
   
        if (params$useTempFuncs$all & params$useTempFuncs$eggLayRate){
            temp = tempC(time,temperatureTS,params$start.DOY)
            egg.rate=eggsPerFemalePerDay(temp)
        }
            
         v = x$Beetles['laying-adults',1]*egg.rate*params$female.frac

        #print('repro end')
        return(max(0,v))
        
    },
    
    
    deathFunc=function(stage,x,time,species,strain){
        
         # print('death st')
     
        v = death.rate[stageNames[stage]]
        
        if (params$useTempFuncs$all){

            if (stageNames[stage] =='eggs' & params$useTempFuncs$Edeath){

                soil.temp = tempC(time,temperatureTS,params$start.DOY,params$useSoilTemp)
                 v=eggDeathRateFunc(soil.temp)
                    
            }


            if(stageNames[stage]%in%c('pre-adults','pre-ovi-adults','laying-adults','old-adults','new-adults') &  params$useTempFuncs$Adeath){

                temp = tempC(time,temperatureTS,params$start.DOY)
                v = adultDeathRateFunc(temp)
                 
            }

        }

    
        if(stageNames[stage]=='larvae' & params$LDD){

            v = death.rate['larvae']*x$Beetle['larvae',1] #density dependent
        
        }


        #print('death end')
        return(max(0,v))
    },
    
    durationFunc=function(stage,x,time,species,strain){
        #note this is only used for initial time step 
        #this is important to get right if there is no spin up time though as
        #the stage duration is computed as a change from this starting value
        
        v = 1/max(1e-12,stageDevelsFunc(stage,x,time,species,strain))

        return(v)
    },

    
    develFunc=function(stage,x,time,species,strain){

#        print('devel st')
        v = stageDevelsFunc(stage,x,time,species,strain)
#        print('dev end')
        return(v)

    },      
    

    immigrationFunc=function(stage,x,time,species,strain){

        v = 0

        if (stageNames[stage]=='pre-ovi-adults'){
            
            if (time<=(params$immigration[['window.fin']]-params$start.DOY+1)){

                doy=dayOfYear(time,params$start.DOY,yearLength=365)$integer

                if (doy>=params$immigration[['window.st']] &
                    doy<=params$immigration[['window.fin']]){

                    v=approx(immAdultsTS[,1],immAdultsTS[,2],doy,rule=2)$y
                    
                }
            
            }
        }
        
        return(v)
   
            
    },

    emigrationFunc=function(stage,x,time,species,strain){

        
      v = 0


      return(v)
  }
)
