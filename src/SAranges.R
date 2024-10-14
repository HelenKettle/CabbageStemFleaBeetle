SAranges=list(

    eggDeathRate.NT = c(0.005,0.1), #non-temp dep death
    adultDeathRate.NT = c(0.005,0.1),#non-temp dep death
    larvalDeathRate = c(1e-6,1e-4),
    preAdultDeathRate = c(0.005,0.1),
    female.frac=c(0.4,0.6), #assumed half are female

    larvalDuration.Tb=c(4,10),
    larvalDuration.TDD=c(150,350),

    EPD = c(577.8, 608.2),#c(7,8)*30.4+365,
    pupalAndYoungAdult.tau = c(71,99), 15+c(8,12)*7, #Young adults = 15 d (Guney). Pupal = 10 weeks
#    preAdultDuration = c(70,130),
    layingAdultDuration = c(200,280),
    soilTemp.dT=c(1,5),
    soilTemp.av=c(1,14),
    seed = c(1,5)
        )

