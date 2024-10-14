#test all functions involved in computing development rates
rm(list=ls())

library(testthat)

functionNamesPath = '../src/functionNames.R'
source(functionNamesPath)
source('Settings.R')
for (f in requiredFunctions){
    source(paste0(params$srcFolder,f))
}


#---egg devel rate---------------------------------------
dev.relation='Alford'
temp=20
dev.rate = eggDevelRateFunc(temp,dev.relation)

#check length
expect_equal(length(dev.rate),1)

#check what happens if put in -ve value for temp
expect_gte(eggDevelRateFunc(-2,dev.relation),0)
expect_gte(eggDevelRateFunc(200,dev.relation),0)
expect_error(eggDevelRateFunc(c(1,2),dev.relation))
expect_error(eggDevelRateFunc(NA,dev.relation))
expect_error(eggDevelRateFunc(NaN,dev.relation))
expect_error(eggDevelRateFunc(NULL,dev.relation))

#---pre-ovi devel------------------------------------
expect_error(preOviDevelFunc(c(1,2)))
expect_gte(preOviDevelFunc(-2),0)
expect_true(is.finite(preOviDevelFunc(200)))
expect_error(preOviDevelFunc(NA))

#--larvalDevelRateFunc------------------------------
expect_error(larvalDevelRateFunc(c(1,2)))
expect_gte(larvalDevelRateFunc(-2),0)
expect_true(is.finite(larvalDevelRateFunc(200)))
expect_error(larvalDevelRateFunc(NA))

#-----preAdultDurationFunc------------------------
expect_error(preAdultDurationFunc(c(1,2),params))
expect_gte(preAdultDurationFunc(-2,params),0)
expect_true(is.finite(preAdultDurationFunc(200,params)))
expect_error(preAdultDurationFunc(NA,params))
expect_error(preAdultDurationFunc(365*3,params))
