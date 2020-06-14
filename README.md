# LazyTomato

[中文版](./README_CH-ZH.md)

simple pomodoro clock for windows

propose: prevent use computer for a long time

## build environment
OS:  windows10-1903

LANG: Autohotkey Version 1.1.30.03


## usage
run executable file

program will generate `LazyTomato.ini` automatically

Left click on the tray icon to temporarily stop the program

right click on the tray icon for more options


## configure

### --- basic ---
<b>unit: minutes</b>

- (work  time) `Pomodoro = 5`
- (break time) `Break = 1`
- (relax time) `Long_Break = 10`
- (break freq) `Long_Break_Frequency = 4`
- (extend time) `Extended_Time = 3`

e.g. 5m->1m->5m->1m->5m->1m->5m->10m

<b>unit: seconds</b>

- (warn  for next break ) `Alert_Time = 10`
- (prepare for next work) `Pre_Time= 10`

<b>unit: 0.1s</b>

- (fade effect) `Fade_Delay = 10`

<b>misc</b>

- (Whether to turn off the screen automatically) `Turn_Off_Screen = false`

- (menu shortcut) `Menu_Key=Pause`
    - !  Alt
    - ^  ctrl，e.g ^c
    - \+  Shift
    - \#  win
    - \>^ Lctrl
    - <^  Rctrl

caution: some special key cannot be use!

### --- interface settings ---
```
; symbol
    Pomodoro_sym=WORK
    Break_sym=REST
    Long_Break_sym=LONG
    Alert_sym=Notice!
    Hint_L_sym="> "
    Hint_R_sym=" <"
    Font_Size=32
    Font_Family=Consolas
    ; monospaced font is recommanded
    Text_Pos=0.1
    ; percentage of margin from screen top
```

According to the above settings interface show as follows

```
----------------------------------------
|                                      |
|             WORK  15                 |
|           > REST  11 <               |
|             LONG   3                 |
|                                      |
|                                      |
|                                      |
|                                      |
|                                      |
_----------------------------------------
```

for alignment, `Hint_L_sym` and `Hint_R_sym` are TWO characters wide

hint: can apply Unicode char 🍅 (win+.)

### --- user record ---
```
; count
    ; (work finished)
     Pomodoro_cnt=15

    ; (break finished)
    Break_cnt=11

    ; (relax finished)
    Long_Break_cnt=3
```

## about multi-configure
the program automatically scans all `.ini` files (including subfolders)

