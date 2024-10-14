rm(list=ls())
library(testthat)

functionNamesPath = '../src/functionNames.R'
source(functionNamesPath)
source('Settings.R')
for (f in requiredFunctions){
    source(paste0(params$srcFolder,f))
}

#---test simWeather()--------------------
weatherParams=c(
    'a'=9.60, #(oC) alpha in Eq 2
    'b'=6.34, #(oC) beta in Eq 2
    'shift'=113.57, #(d) delta in Eq 2
    'sd'=2.76 #(oC) sigma in Eq 2
)
L=365*2
simJD=seq(1,L)
tempTS=simWeather(weatherParams,simJD)

#check dimensions
expect_equal(dim(tempTS),c(L,2))
#check JD
expect_equal(tempTS[,1],simJD)
#check no NAs in temperature
expect_equal(sum(is.na(tempTS[,2])),0)
#check no NaNs in temperature
expect_equal(sum(is.finite(tempTS[,2])),L)

#check sd is varying
weatherParams[['sd']]=1
tempTS1=simWeather(weatherParams,simJD)
expect_lt(var(tempTS1[,2]),var(tempTS[,2]))

#---test changeWeather()----------------
season='winter'
dT=changeWeather(season,dT=3,simJD)
expect_equal(length(dT),L)
#check no NAs in temperature
expect_equal(sum(is.na(dT)),0)
#check no NaNs in temperature
expect_equal(sum(is.finite(dT)),L)

#---test convertAirToSoilTemp()----------------
soil.temp=convertAirToSoilTemp(tempTS,dT=3,avPeriod=7)
expect_equal(length(soil.temp),L)
#check no NAs in temperature
expect_equal(sum(is.na(soil.temp)),0)
#check no NaNs in temperature
expect_equal(sum(is.finite(soil.temp)),L)
#check variance is leq to air temp variance
expect_lte(var(soil.temp),var(tempTS[,2]))

#---------------tempC()---------------------------
#check that the temperature is a single, real value
time=10
T=tempC(time,tempTS,params$start.DOY,useSoilTemp=FALSE,useStemTemp=FALSE)
expect_equal(length(T),1)

#check it gives real values outside time vector
expect_false(is.na(tempC(range(tempTS[,1])[1]-1,tempTS,params$start.DOY,useSoilTemp=FALSE,useStemTemp=FALSE)))
expect_false(is.na(tempC(range(tempTS[,1])[2]+1,tempTS,params$start.DOY,useSoilTemp=FALSE,useStemTemp=FALSE)))

#check interpolated values are within range of orginal temp TS
expect_lte(tempC(time,tempTS,params$start.DOY,useSoilTemp=FALSE,useStemTemp=FALSE),max(tempTS[,2]))
expect_gte(tempC(time,tempTS,params$start.DOY,useSoilTemp=FALSE,useStemTemp=FALSE),min(tempTS[,2]))


         

