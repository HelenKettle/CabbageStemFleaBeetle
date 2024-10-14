#model for cabbage stem flea beetle with temp dependency
#need to install.packages('stagePop') to run

#runs for one simulation - for multiple runs, use multiRuns.R

singleRun=TRUE

if (singleRun){
    rm(list=ls())
    source('Settings.R') #note when singleRun is FALSE, Settings.R is sourced in multiRuns.R
}

library(stagePop)

source('functionNames.R')

for (f in requiredFunctions){
    source(paste0(params$srcFolder,f))
}

#----------------------------set up stagePop model-----------------------------

#stage names must be in chronological order
stageNames=c('eggs','larvae','pre-adults','pre-ovi-adults','laying-adults','old-adults')
Ns=length(stageNames)

#set default values (used if a function is not called):

death.rate=c(
    'eggs'=params$eggDeathRate,
    'larvae'=params$larvalDeathRate,
    'pre-adults'=params$preAdultDeathRate,
    'pre-ovi-adults'=params$adultDeathRate,
    'laying-adults'=params$adultDeathRate,
    'old-adults'=params$adultDeathRate,
    'new-adults'=params$adultDeathRate
)
        
stage.duration=c(
    'eggs'=params$eggDuration, #f(T)
    'larvae'=params$larvalDuration, #fixed
    'pre-adults'=params$preAdultDuration, #fixed
    'pre-ovi-adults'=params$preOviDuration, #f(T)
    'laying-adults'=params$layingAdultDuration, #fixed
    'new-adults'=params$newAdultDuration #fixed
)
#---------------------------------------------------

#For DDE solver - alter if solution numerics fail
solver.options=list(DDEsolver='PBS',tol=1e-7,hbsize=1e5,dt=0.01)

#----------------------set time vector for model-------------------
simJD=seq(params$start.DOY,(params$start.DOY+params$num.days),params$tstep) 

#start.doy=params$start.DOY
        
times=simJD-min(simJD)

#set temperature time series----------------------------------------
set.seed(params$seed)
temperatureTS=simWeather(params$weatherParams,simJD)

if (params$seasonChange){#modify seasons
    dT.ts=changeWeather(params$seasonList$season,params$seasonList$dT,simJD)
    temperatureTS[,2]=temperatureTS[,2]+dT.ts
}

if (params$climateChange){#modify for climate
    temperatureTS[,2]=temperatureTS[,2]+params$climate.dT
}

if (params$useSoilTemp){#set soil temps for eggs
    soilTemp=convertAirToSoilTemp(temperatureTS,params$soilTemp.dT,params$soilTemp.av)
}

#Define immigration rates of pre-ovi adults------------------------------
immAdultsTS = immigrationFunc(simJD,params)

#Run stagePop----------------------------------------------
start.time <- Sys.time()
print(paste('model start.time:',start.time))

print('starting stagePop...')

modelOutput=popModel(
    numSpecies=1,
    numStages=Ns,
    timeDependLoss=TRUE,
    timeDependDuration=TRUE,
    ICs=list(matrix(0,nrow=Ns,ncol=1)),
    timeVec=times,
    solverOptions=solver.options,
    rateFunctions=rateFunctions,
    stageNames=stageNames,
    speciesNames='Beetles',
    saveFig=FALSE,
    plotFigs=FALSE,
    checkForNegs=TRUE
)


#---------------plotting ---------------------------------------------------
    
if (params$plotFigs){

    quickPlot(modelOutput,stageNames,'Beetles','abundance')
    quickPlot(modelOutput,stageNames[1:5],'dur.Beetles','stage duration')
    quickPlot(modelOutput,stageNames[1:5],'prob.Beetles','survival probability')

}
    
end.time <- Sys.time()
time.taken <- round(end.time - start.time,2)
print(time.taken)


if (!exists('singleRun') & params$save.output){

    save(modelOutput,params,file=params$output.path)
    
  #  save(modelOutput,params,file='standardModelRun.Rdata')
}

    



         



