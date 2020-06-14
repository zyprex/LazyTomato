calcTimeChain() {
    global Pomodoro, Break, Long_Break, Long_Break_Frequency
    arr := []
    loop %Long_Break_Frequency%
        arr.Push(Pomodoro, Break)
    arr.Pop()
    arr.Push(Long_Break)
    for i,v in arr
        arr[i]:=round(v*60)
    return arr
}
sec2min(sec) {
    min := sec // 60
    sec -= min*60
    return min>0 ? min " m " sec " s " : sec " s "
}

; estimated time of arrival
ETAtime(ponit,secs) {
;     Num1 += 19990101000000
    Num1 = %ponit%
    Num1 += %secs%, Seconds
    FormatTime, Num1 , %Num1%, HH:mm:ss
    return Num1
}
