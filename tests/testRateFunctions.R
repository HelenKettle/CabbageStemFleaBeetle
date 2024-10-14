library('testthat')
rm(list=ls())

#tests for: repro and immigration
#death and devel rates have separate test scripts

functionNamesPath = '../src/functionNames.R'
source(functionNamesPath)
source('Settings.R')
for (f in requiredFunctions){
    source(paste0(params$srcFolder,f))
}


#----------reproFunc i.e. eggsPerFemalePerDay()----------------------
expect_error(eggsPerFemalePerDay(c(1,2)))
expect_gte(eggsPerFemalePerDay(-2),0)
expect_true(is.finite(eggsPerFemalePerDay(200)))
expect_error(eggsPerFemalePerDay(NA))


#---------immigrationFunc()------------------------------
#should be zero for all stages that aren't pre-ovi
stageNames=c('eggs','larvae','pre-adults','pre-ovi-adults','laying-adults','old-adults')
DOY=params$immigration[['window.st']]+2
for (s in 1:length(stageNames)){ 
    if (stageNames[s]!='pre=ovi-adults'){
        expect_equal(rateFunctions$immigrationFunc(s,x=NULL,
                                                   DOY,species=1,strain=1),0)
    }else{
        expect_gt(rateFunctions$immigrationFunc(s,x=NULL,
                                                 DOY,species=1,strain=1),0)
    }
}
expect_equal(rateFunctions$immigrationFunc(4,x=NULL,params$immigration[['window.fin']]+10,species=1,strain=1),0)
