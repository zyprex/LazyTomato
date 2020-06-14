iniList := {} ; configure file list
iniCnt  := 0  ; configure file count
iniFile :=    ; configure file name
iniConf := [ "Pomodoro"
            ,"Break"
            ,"Long_Break"
            ,"Long_Break_Frequency"
            ,"Extended_Time"
            ,"Alert_Time"
            ,"Pre_Time"
            ,"Fade_Delay"
            ,"Turn_Off_Screen"
            ,"Menu_Key" ]

iniUI := [ "Pomodoro_sym", "Break_sym", "Long_Break_sym"
          , "Alert_sym", "Hint_L_sym", "Hint_R_sym"
          , "Font_Size", "Font_Family", "Text_Pos" ]
iniAchieve:= ["Pomodoro_cnt", "Break_cnt" , "Long_Break_cnt"]

; create configure file list
Loop, Files, *.ini, R
{
    iniList[A_LoopFileName] := A_LoopFileFullPath
    iniFile := A_LoopFileFullPath
}
; show configure file with gui
for key,val in iniList
{
    Gui, iniScan: font, s18, Comic Sans MS
    Gui, iniScan: add, Button, Default w280 y+4 Center gHANDLELIST, &%key%
    iniCnt++
}

if (iniCnt > 1) {
    Gui, iniScan:Show, ,%AppName%-iniScan
    WinWaitClose, %AppName%-iniScan
}

INI_HEAD:
If FileExist(iniFile){
    Loop % iniConf.Length() {
      conf_name := % iniConf[A_Index]
      IniRead, %conf_name%, %iniFile% ,conf, %conf_name%
      if %conf_name%=ERROR
      {
        MsgBox CAN'T READ THIS INI FILE !
        ExitApp
      }
    }
    Loop % iniUI.Length() {
      conf_name := % iniUI[A_Index]
      IniRead, %conf_name%, %iniFile% ,UI, %conf_name%
    }
    Loop % iniAchieve.Length() {
      conf_name := % iniAchieve[A_Index]
      IniRead, %conf_name%, %iniFile% ,achieve, %conf_name%
    }
}else{ ; the defalut value
; create sample configure file
FileAppend,
(
[conf]
; unit: 1m,
    Pomodoro = 25
    Break = 5
    Long_Break = 15
    Long_Break_Frequency = 4
    Extended_Time = 3
; unit: 1s
    Alert_Time = 35
    Pre_Time=30
; unit: 0.1s
    Fade_Delay = 10
    Turn_Off_Screen = true
; menu key
    Menu_Key=Pause
[UI]
; symbol
    Pomodoro_sym=WORK
    Break_sym=REST
    Long_Break_sym=LONG
    Alert_sym=Notice!
    Hint_L_sym="> "
    Hint_R_sym="  "
    Font_Size=32
    Font_Family=Consolas
    Text_Pos=0.1
[achieve]
; count
    Pomodoro_cnt=0
    Break_cnt=0
    Long_Break_cnt=0
), LazyTomato.ini, UTF-16
iniFile=LazyTomato.ini
goto, INI_HEAD
}
if Turn_Off_Screen = false
    Turn_Off_Screen =

Hotkey, %Menu_Key%, MENU_SHOW
