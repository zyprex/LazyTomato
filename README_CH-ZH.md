# 懒番茄 
简单的番茄钟软件

功能： 防止长时间连续使用电脑


## build 环境
OS:  windows10-1903

LANG: Autohotkey Version 1.1.30.03

## 使用方法
运行程序

程序自动生成 `LazyTomato.ini` 配置文件

左键点击托盘图标暂时停止程序，右键点击托盘图标有更多选项

## 配置文件说明

### --- 基本设定 ---
<b>以分钟为单位</b>

- (作业时间) `Pomodoro = 5`
- (打断时间) `Break = 1`
- (放松时间) `Long_Break = 10`
- (放松频率) `Long_Break_Frequency = 4`
- (延长时间) `Extended_Time = 3`

e.g. 5m->1m->5m->1m->5m->1m->5m->10m


<b>以秒为单位</b>

- (休息预警) `Alert_Time = 10`
- (作业准备) `Pre_Time= 10`

<b>以0.1秒为单位</b>
- (淡入淡出延迟) `Fade_Delay = 10`

<b>其他</b>

- (是否自动关闭屏幕) `Turn_Off_Screen = false`

- (快捷键) `Menu_Key=Pause`
    - ! 代表 Alt 键
    - ^ 代表 ctrl键，如 ^c
    - \+ 代表 Shift 键
    - \# 代表 win 键
    - \>^ 代表 Lctrl键
    - <^ 代表 Rctrl键

注意：某些特殊键可能无法使用!

### --- 界面设定 ---
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
    ; 建议等宽字体
    Text_Pos=0.1
    ; 屏幕上端留空百分比
```

依照上述设置界面大致如下

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

为了居中时左右对齐 `Hint_L_sym` 与 `Hint_R_sym` 始终是两个字符宽

提示：可以使用 Unicode 字符 🍅 (win+.)

### --- 用户记录 ---
```
; count
    ; (作业完成次数记录)
     Pomodoro_cnt=15

    ; (中断完成次数记录) 
    Break_cnt=11

    ; (休息完成次数记录)
    Long_Break_cnt=3
```

## 使用多个配置文件
放入程序启动目录即可，程序自动扫描所有.ini 文件（包括子文件夹内的）

