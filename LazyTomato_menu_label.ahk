MENU_TRAY:
if SubStr(A_OSVersion,1,3) = "10."
    Menu, Tray,Tip , % AppName
                    . "`n ⌛  " sec2min(at_clock)
                    . "`n ⏲` ETA~" ETAtime(point_time, time_array[time_index])
else
    Menu, Tray,Tip , % AppName
                    . "`n REMAIN:  " sec2min(at_clock)
                    . "`n ETA:  " ETAtime(point_time, time_array[time_index])
return

PAUSE:
Gui, alertGUI:Hide
if (A_IsPaused)
	Menu, Tray, Icon , Tomato.ico,,1
Else {
    Menu, Tray, Icon , Shell32.dll, 48,1
    if SubStr(A_OSVersion,1,3) = "10."
        Menu, Tray,Tip , % AppName "`n  🔒  " A_Hour ":" A_Min ":" A_Sec
    else
        Menu, Tray,Tip , % AppName "`n  LOCK AT:  " A_Hour ":" A_Min ":" A_Sec
}
Pause ,Toggle,1
; finish the command it was running (if any) and then enter a paused state
;   	Menu, Tray, Icon, Shell32.dll, 303 ;shell32 max1-327
return

EX_SESSION:
at_clock += round(Extended_Time*60)
SetTimer, PRE_BLINK, Off
Loop, 3
    GuiControl, shadeGUI:Show, Bar%A_Index%
Gui, alertGUI:Hide
; if (time_index&1) {
;     Pomodoro_cnt-=ceil(Extended_Time)
; } else {
;     if (time_index!=time_array.Length()) {
;         Break_cnt-=ceil(Extended_Time)
;     } else {
;         Long_Break_cnt-=ceil(Extended_Time)
;     }
; }
return

NEXT_SESSION:
if (time_index&1) {
    Pomodoro_cnt-=1
} else {
    if (time_index!=time_array.Length()) {
        Break_cnt-=1
    } else {
        Long_Break_cnt-=1
    }
}
at_clock=1
return

INI_EDIT:
Run,%iniFile%,,UseErrorLevel
return
INI_LOAD:
reload
return

iniScanGuiClose:
EXIT:
exitApp
