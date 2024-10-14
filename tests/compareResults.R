#compare model run with standard run (Fig. 6 in paper)

rm(list=ls())

source('../src/plotAbundance.R')

load('../Results/standardModelRun.Rdata')

stageNames=c('pre-ovi-adults','laying-adults','eggs','larvae','pre-adults')

#stageNames=c('eggs','larvae','pre-adults','pre-ovi-adults','laying-adults','old-adults')

plotAbundance(modelOutput,params,stageNames)

