#run runSim.R multiple times
#change parameter values in the list params

rm(list=ls())
graphics.off()

source('SAranges.R')

saveSim=TRUE

resultsFolder='../Results/'

fname='run'


parmNameVec=c(
    'season',
    'climate.dT',
    'EPD',
    'pupalAndYoungAdult.tau',
    'eggDeathRate.NT',
    'adultDeathRate.NT',
    'larvalDeathRate',
    'preAdultDeathRate',
    'female.frac',
    'larvalDuration.Tb',
    'larvalDuration.TDD',
    'preAdultDuration',
    'layingAdultDuration',
    'soilTemp.dT',
    'soilTemp.av',
    'eggDevRelation',
    'seed'
)[1:2]


for (parmName in parmNameVec){
    
    source('Settings.R')

    params$plotFigs=FALSE
    
    if (parmName=='eggDevRelation'){

        parmVec=c('Mathiasen','Alford','Johnen','Bonnemaison','power')

    }else if (parmName=='climate.dT'){
        
        params$climateChange=TRUE
        parmVec=c(0,0.5,1,2,3)

    }else if (parmName == 'season'){

        params$seasonChange=TRUE
        params$seasonList[['dT']]=3
        parmVec=c('winter','spring','summer','autumn')
        
    }else{

        parmRange=SAranges[[parmName]]
        parmDefault=params[[parmName]]
        parmVec=c(parmRange[1],parmDefault,parmRange[2])
                  
    }


    for (parm in parmVec){#run through values for parameter parm

        print(paste(parmName,'=',parm))
        
        if (parmName == 'season'){
            params$seasonList['season']=parm
        }else{
            params[[parmName]]=parm
        }
        
        source('runSim.R')
    
        if (saveSim){
            if (parmName=='eggDevRelation' | parmName=='season'){
                filepath=paste0(resultsFolder,fname,parmName,parm,'.Rdata')
            }else if (parm<1e-4){
                filepath=paste0(resultsFolder,fname,parmName,round(parm,6),'.Rdata')
            }else{
                filepath=paste0(resultsFolder,fname,parmName,round(parm,4),'.Rdata')
            }
            save(modelOutput,params,temperatureTS,file=filepath)
        }

    }
    
}
