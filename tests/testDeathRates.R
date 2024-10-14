#test death rate funcs
library(testthat)
rm(list=ls())

functionNamesPath = '../src/functionNames.R'
source(functionNamesPath)
source('Settings.R')
for (f in requiredFunctions){
    source(paste0(params$srcFolder,f))
}


#-----------eggDeathRateFunc--------------
expect_error(eggDeathRateFunc(c(1,2)))
expect_gte(eggDeathRateFunc(-2),0)
expect_true(is.finite(eggDeathRateFunc(200)))
expect_error(eggDeathRateFunc(NA))


#----------adultDeathRateFunc-----------------
expect_error(adultDeathRateFunc(c(1,2)))
expect_gte(adultDeathRateFunc(-2),0)
expect_true(is.finite(adultDeathRateFunc(200)))
expect_error(adultDeathRateFunc(NA))
