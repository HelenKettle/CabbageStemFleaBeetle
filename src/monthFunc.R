monthFunc = function(position,labelLength){

    #return a named vector with DOY for each month
    #position is a string: 'start', 'middle' or 'end' of the month
    #labelLength is 1 (single letter), 2 (mix), 3 (3 letters)
    
    monlen=rep(31,12)
    monlen[c(9,4,6,11)]=30
    monlen[2]=28

    monthNamesLong=c('jan','feb','mar','apr','may','jun','jul','aug','sep','oct','nov','dec')
    monthNames2=c('Ja','F','Mar','Ap','May','Jun','Jul','Au','S','O','N','D')
    monthNamesLetters=c('J','F','M','A','M','J','J','A','S','O','N','D')
    
    monthEnd=cumsum(monlen)
    monthStart=cumsum(c(0,monlen[1:11]))
    monthMid=(monthEnd+monthStart)/2

    if (position=='start'){
        monthDOY=monthStart
    }else if (position=='middle'){
        monthDOY=monthMid
    }else if (position=='end'){
        monthDOY=monthEnd
    }else{
        stop('please specify month position:  start, middle or end')
    }

    
    if (labelLength==1){
        monthNames=monthNamesLetters
    }else if (labelLength==2){
        monthNames=monthNames2
    }else if (labelLength==3){
        monthNames=monthNamesLong
    }else{
        stop('please specify label length: 1 (single letter), 2 (mix), 3 (3 letters)')
    }
        
    names(monthDOY)=monthNames
    
    return(monthDOY)
}
