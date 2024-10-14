params = list(
    
    #Model Settings------------------------------------
    srcFolder='~/GitLab/csfb2024/Code/CodeForPaper/src/',
    output.path='~/GitLab/csfb2024/Code/CodeForPaper/Results/Run.Rdata',

    plotFigs=TRUE,

    num.days = 365*1.1,#(d) 1 year plus migration window
    
    tstep=1, #(d)
    
    start.DOY = 212, #day of year (start is when ovaries start maturing (pre-ovi stage))
    seed = 3, #seed for random number generator (for generating simulated temperature)

    save.output=FALSE,

    #Parameters---------------------------------------

    #Temperature-----------------------
    #choose which rates to make temperature dependent
    #to remove all temp dependency just change 'all' to FALSE
    useTempFuncs=list(all=TRUE,
        eggLayRate=TRUE,
        Adeath=TRUE,
        Edeath=TRUE,
        eggDev=TRUE,
        larvalDev=TRUE,
        preOvi=TRUE
                      ),
    
    weatherParams=c(
        'a'=9.60, #(oC) alpha in Eq 2
        'b'=6.34, #(oC) beta in Eq 2
        'shift'=113.57, #(d) delta in Eq 2
        'sd'=2.76 #(oC) sigma in Eq 2
    ),

    useSoilTemp=TRUE, #convert air temp to soil temperature in the model
    soilTemp.dT=3, #(oC) soil temp = dT + air temp #deg C
    soilTemp.av=7, #(d) number of days to average air temp 

    seasonChange=FALSE, #modify temperature time series to have warmer than ususal seasons
    seasonList=list(season='winter',dT=0), #(oC) season to change by adding dT

    climateChange=FALSE, #increase air temperature over whole time series
    climate.dT=0, #(oC)
   
    #Reproduction--------------------------
    #always used:
    female.frac=0.5, #assumed half are female

    #not used if f(T)
    eggLayingRate=1.6, #(eggs/female/d) - only used if useTempFuncs=FALSE, estimated for T=10oC

    #Death-----------------------------------
    #always used:
    LDD=TRUE,    #use larval density dependent death
    larvalDeathRate = 1e-5,#(/L/d) density dependent death rate
    preAdultDeathRate = 0.01, #(/d)
    eggDeathRate.NT = 0.01, #(/d) non-temp dep death
    adultDeathRate.NT = 0.01,#(/d) non-temp dep death

    #not used if f(T):
    eggDeathRate = 0.01,#(/d) from approx mean of eggDeathRateFunc
    adultDeathRate = 0.01,#(/d) mean of (-log(0.5)/survival days) 

    #Stage durations (days)--------------------
    #always used:
    layingAdultDuration = 243, #(d) 8*30.4 #213
    EPD = 593,#(DOY) earliest pre-ovi day 7.5*30.4+365,
    pupalAndYoungAdult.tau = 85, #(d) Young adults = 15 d (Guney). Pupal = 10 weeks (8-12 weeks) = 70 d
    tau.diapause = 25, #(d)

    #not used if f(T):
    larvalDuration = 6*30.4,#(d) Horeau Fig 1
    eggDuration = 55, #(d) mean from Mathaisen Fig 4b 
    preOviDuration = 30, #(d)

    #choose egg dev relationship if f(T)
    eggDevRelation=c('Mathiasen','Alford','Johnen','Bonnemaison','power')[3],

    larvalDuration.Tb=7, #(d)
    larvalDuration.TDD=250, #(degree days)

    #-----------Immigration-------------------------
    immigration = list(
        sd=7.5, #(oC) sigma in Eq 1
        mean.DOY=230.5,#258.5-28, #mu in Eq 1
        total=41, #gamma in Eq 1
        window.st=202,#230-28, first DOY of immigration
        window.fin=262#290-28 last DOY of immigration
    ),


    #------------Timing (used for plotting only)---------------------------
    Timing=list(
        'eggs'=c(start='sep',end='mar'),
        'larvae'=c(start='nov',end='apr'),
        'pre-adults'=c(start='mar',end='aug'),
        'pre-ovi-adults'=c(start='aug',end='sep'),
        'laying-adults'=c(start='sep',end='feb')
        )
    
)





