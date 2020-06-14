#NoEnv
#Warn
#SingleInstance, Force
#Persistent
SendMode Input
SetWorkingDir %A_ScriptDir%
CoordMode, Mouse, Screen
; ------------------------------- variable
AppName    := "LazyTomato-v0.1"
#include color_t.ahk
#include ini_read_all.ahk
time_array := calcTimeChain()
#include LazyTomato_func.ahk
time_index := 0 ; current time indicator
at_clock   := 0 ; current time length
blink      := 0 ; blink controler
;--------------------------------- variable end


;--------------------------------- initial
Menu, Tray, NoStandard             ; menu initial
Menu, Tray, DeleteAll
Menu, Tray, Add, &Pause, PAUSE
Menu, Tray, Add, &Next , NEXT_SESSION
Menu, Tray, Add, &Extend  %Extended_Time% min, EX_SESSION
Menu, Tray, Add, &Settings, INI_EDIT
Menu, Tray, Add, &Reload , INI_LOAD
Menu, Tray, Add, E&xit , EXIT
Menu, Tray, Default, &Pause
Menu, Tray, Click, 1
Menu, Tray, Icon , Tomato.ico
                                    ; gui initial
Gui, alertGUI:Default ; alert windows
   Gui, +LastFound +ToolWindow +E0x20 +AlwaysOnTop -SysMenu -Caption
   Gui, Margin, 10, 10
   Gui, color, AA0000
   Gui, font, s24 bold cEEEEEE q5, Consolas
   Gui, Add, Text,  Center, % Alert_sym
   Gui, Add, Text,x+1 vCountDown Center, % "    "
Gui, shadeGUI:Default ; shade windows
    Gui, +LastFound -DPIScale -Border -Caption +AlwaysOnTop
    Gui, Color, 000000
    Gui, Margin, 0, 0
    Gui, font, s%Font_Size% q5, %Font_Family%
    Gui, Add, Text,% "vBar1 center x0 y" A_ScreenHeight*Text_Pos " w" A_ScreenWidth,`s
    Gui, Add, Text,% "vBar2 center x0 y+0 w" A_ScreenWidth,`s
    Gui, Add, Text,% "vBar3 center x0 y+0 w" A_ScreenWidth,`s
Gui, shadeGUI:Show, Hide, %AppName%-Locker
;--------------------------------- initial end


;--------------------------------- first label
CLOCK_START:
wake       := 1          ; wake at blink start
point_time := A_Now      ; record current time
time_index := time_index=time_array.Length() ? 1 : time_index+1
at_clock   := time_array[time_index]
SetTimer, TIK_TIME, 1000 ; new session start
gosub shadeGUI_VIVID
return


;--------------------------------- main label
TIK_TIME:
at_clock--      ; countdown
gosub MENU_TRAY ; LazyTomato_menu_label
; Pomodoro alert time start
; show alert gui
if( at_clock<=Alert_Time ) && ( time_index&1 )
    gosub alertGUI_VIVID
; Break end prepare time start
; Long Break end prepare time start
; blink shade gui & wake screen
if( at_clock<=Pre_Time ) && !( time_index&1 ) {
    SetTimer, PRE_BLINK, 450
    if( wake ) && WinActive(AppName "-Locker") {
        Send {RCtrl}
        wake=0
    }
}
if !(at_clock) {        ; time is up
; who's end ?
    ; Pomodoro end ?
    ; hide alert gui & show shade gui
    gosub shadeGUI_START
    if(time_index&1) {
        SetTimer, ESCAPE_FROM_MOUSE, Off
        Gui, alertGUI:Hide
        Pomodoro_cnt++
        IniWrite, %Pomodoro_cnt%, %iniFile%, achieve, Pomodoro_cnt
        Gui, shadeGUI:Show, x0 y0 w%A_ScreenWidth% h%A_ScreenHeight% , %AppName%-Locker
        loop 100 {
            WinSet, Transparent,% A_Index*2.55, %AppName%-Locker
            sleep %Fade_Delay%
        }
        WinSet, Transparent, Off, %AppName%-Locker
        gosub shadeGUI_TEXT
        if Turn_Off_Screen
            SetTimer, SCREEN_OFF,-2000
    }
    ; Break or Long Break end ?
    ; turn off blink & hide shade gui
    else{
        SetTimer, PRE_BLINK, Off
        if(time_index!=time_array.Length()) {
            Break_cnt++
            IniWrite, %Break_cnt%, %iniFile%, achieve, Break_cnt
        }else{
            Long_Break_cnt++
            IniWrite, %Long_Break_cnt%, %iniFile%, achieve, Long_Break_cnt
        }
        gosub shadeGUI_START
        loop 100{
            WinSet, Transparent,% 255-A_Index*2.55, %AppName%-Locker
            sleep %Fade_Delay%
        }
        Gui, shadeGUI:Hide
    }
    goto CLOCK_START
}
return

PRE_BLINK:
Gui, shadeGUI:Default
if( blink:=!blink ) {
    loop, 3
        GuiControl, Hide, Bar%A_Index%
}else{
    loop, 3
        GuiControl, Show, Bar%A_Index%
}
return

shadeGUI_VIVID: ; colorful bar
Gui, shadeGUI:Default
loop, 3 {
    Random, color_t, 1, color_table.Length()
    Random,, color_t ; new seed
    Gui, font, % " c" color_table[color_t],
    GuiControl, font, Bar%A_Index%
}
return

shadeGUI_TEXT:
Gui, shadeGUI:Default
GuiControl,, Bar1, % Format("  {1:}{2: 5d}  ", Pomodoro_sym, Pomodoro_cnt)
if !(time_index=time_array.Length()-1) {
    GuiControl,, Bar2, % Format("{1: 2s}{2:}{3: 5d}{4: 2s}"
                        , Hint_L_sym, Break_sym, Break_cnt, Hint_R_sym)
    GuiControl,, Bar3, % Format("  {1:}{2: 5d}  ", Long_Break_sym, Long_Break_cnt)
} else {
    GuiControl,, Bar2, % Format("  {1:}{2: 5d}  ", Break_sym, Break_cnt)
    GuiControl,, Bar3, % Format("{1: 2s}{2:}{3: 5d}{4: 2s}"
                        , Hint_L_sym, Long_Break_sym, Long_Break_cnt, Hint_R_sym)
}
loop, 3
    GuiControl, Show, Bar%A_Index%
return

shadeGUI_START:
Gui, shadeGUI:Default
GuiControl,, Bar3, % Format("  {1:}{2: 5d}  ", Long_Break_sym, Long_Break_cnt)
GuiControl,, Bar2, % Format("  {1:}{2: 5d}  ", Break_sym, Break_cnt)
GuiControl,, Bar1, % Format("{1: 2s}{2:}{3: 5d}{4: 2s}"
                    , Hint_L_sym, Pomodoro_sym, Pomodoro_cnt, Hint_R_sym)
loop, 3
    GuiControl, Show, Bar%A_Index%
return


alertGUI_VIVID:
Gui, alertGUI:Default
GuiControl,,CountDown, % round(at_clock)
Gui, Show, NoActivate AutoSize , %AppName%-Alert_Time ; prompt
WinSet, Transparent, 200, %AppName%-Alert_Time
SetTimer, ESCAPE_FROM_MOUSE, 80
return

ESCAPE_FROM_MOUSE:
WinGetPos , alertGUI_X, alertGUI_Y, alertGUI_W, alertGUI_H, %AppName%-Alert_Time
MouseGetPos, mouseX, mouseY
if (mouseX>alertGUI_X && mouseX<(alertGUI_X+alertGUI_W))
    && (mouseY>alertGUI_Y && mouseY<(alertGUI_Y+alertGUI_H))
{
    Random, aGUI_X, alertGUI_W, A_ScreenWidth-alertGUI_W
    Random, aGUI_Y, alertGUI_H, A_ScreenHeight-alertGUI_H
    WinMove,%AppName%-Alert_Time,,aGUI_X,aGUI_Y
}
return

shadeGUIGuiContextMenu:
SCREEN_OFF: ; turn off screen
SendMessage, 0x112, 0xF170, 2,, Program Manager 
return

MENU_SHOW:  ; menu key action
Menu, Tray, show
return

HANDLELIST: ; ini_read_all iniScan button action
iniFile := iniList[SubStr(A_GuiControl,2)]
Gui, iniScan: Destroy
return

#include LazyTomato_menu_label.ahk
