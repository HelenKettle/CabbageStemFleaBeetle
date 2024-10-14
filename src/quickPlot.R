quickPlot=function(modelOutput,stageNames,prefix='Beetles',ylab='abundance'){

    
    shadeArea=function(x.min,x.max,y.min,y.max,colour){
        
        blockx=c(rep(x.min,2),rep(x.max,2))
        blocky=c(-0.1*y.min,1.1*y.max,1.1*y.max,-0.1*y.min)
        polygon(blockx, blocky, col = colour,lty=0)

    }
    
    sd=params$start.DOY
    out=modelOutput
    time=out[,1]
    num.yr=floor(max(time)/365)

    monthStart = monthFunc('start',3)
    monthEnd = monthFunc('end',3)
    
    Lv=1
    Ns=length(stageNames)
    dev.new()
    par(mfrow=c(2,3),mar=c(5,5,2,1))
    for (s in 1:Ns){
        y=out[,paste0(prefix,'.',stageNames[s])]
        x=time+sd
        plot(x,y,
             type='n',
             main=stageNames[s],
             ylab=ylab,
             xlab='DOY',
             cex.axis=1.3,
             cex.lab=1.5)
        
        for (yr in 1:num.yr){
            v=params$Timing[[stageNames[s]]]
            if (stageNames[s]%in%c('eggs','larvae','laying-adults')){
                shadeArea(monthStart[v['start']]+(yr-1)*365,monthEnd[v['end']]+yr*365,0,max(y),'lightcyan')
            }else if (stageNames[s]=='pre-adults'){
                shadeArea(monthStart[v['start']]+yr*365,monthEnd[v['end']]+yr*365,0,max(y),'lightcyan')
            }else if (stageNames[s]=='pre-ovi-adults'){
                shadeArea(monthStart[v['start']]+(yr-1)*365,monthEnd[v['end']]+(yr-1)*365,0,max(y),'lightcyan')
                shadeArea(monthStart[v['start']]+yr*365,monthStart[v['end']]+yr*365,0,max(y),'lightcyan')
            }            
        }
    
    lines(x,y)
    }
}
