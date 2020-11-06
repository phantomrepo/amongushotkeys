#NoEnv ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
#SingleInstance, force
SendMode Input ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir% ; Ensures a consistent starting directory.
SetDefaultMouseSpeed, 100

ColorArr := {0x0000FF:"Red", 0x04EBFF:"Yellow", 0xFF2626:"Blue", 0xFF00FF:"Purple"}
LocArr := {5:"270", 6:"460", 7:"650", 8:"830"}

ShieldXArr := [800, 1000, 810, 980, 1160, 920, 1150]
ShieldYArr := [450, 350, 650, 555, 420, 730, 620]

Medbay := [730, 850, 960, 1075, 1190]
Exit

; Debug is Control+Alt+Z
^!z::
    MouseGetPos, MouseX, MouseY
    PixelGetColor, color, %MouseX%, %MouseY%
    MsgBox The color at the %MouseX%, %MouseY% position is %color%.
    ;clipboard := %MouseX%, %MouseY% %color%
return

; Wires are Control+Alt+X
^!x::
    Send, {Space}
    Sleep, 300
    ; Left side is 1-4
    PixelGetColor, color1, 570, 270 ;-810
    PixelGetColor, color2, 570, 460 ;-620
    PixelGetColor, color3, 570, 650 ;-430
    PixelGetColor, color4, 570, 830 ; -240
    ; Right side is 5-8
    PixelGetColor, color5, 1350, 270 ;-810
    PixelGetColor, color6, 1350, 460 ;-620
    PixelGetColor, color7, 1350, 650 ;-430
    PixelGetColor, color8, 1350, 830 ; -240

    colorNum = 5
    while colorNum != True {
        ;MsgBox, colorNum
        if(color1 == color%colorNum%) {
            MouseClick, Left, 570, 270, , 75, D
            Sleep, 40
            MouseMove, 1350, LocArr[colorNum], 75
            Sleep, 40
            MouseClick, Left, 1350, LocArr[colorNum], , 75, U
            Sleep, 40
            colorNum = True
        } else {
            colorNum++
        }
    }
    colorNum = 5
    while colorNum != True {
        if(color2 == color%colorNum%) {
            MouseClick, Left, 570, 460, , 75, D
            Sleep, 40
            MouseMove, 1350, LocArr[colorNum], 75
            Sleep, 40
            MouseClick, Left, 1350, LocArr[colorNum], , 75, U
            Sleep, 40
            colorNum = True
        } else {
            colorNum++
        }
    }
    colorNum = 5
    while colorNum != True {
        if(color3 == color%colorNum%) {
            MouseClick, Left, 570, 650, , 75, D
            Sleep, 40
            MouseMove, 1350, LocArr[colorNum], 75
            Sleep, 40
            MouseClick, Left, 1350, LocArr[colorNum], , 75, U
            Sleep, 40
            colorNum = True
        } else {
            colorNum++
        }
    }
    colorNum = 5
    while colorNum != True {
        if(color4 == color%colorNum%) {
            MouseClick, Left, 570, 830, , 75, D
            Sleep, 40
            MouseMove, 1350, LocArr[colorNum], 75
            Sleep, 40
            MouseClick, Left, 1350, LocArr[colorNum], , 75, U
            Sleep, 40
            colorNum = True
        } else {
            colorNum++
        }
    }
return

;Card Swipe Control+Alt+C
^!c::
    Send, {Space}
    Sleep, 300
    MouseClick, Left, 760, 820, , 75, D
    Sleep, 2
    MouseClick, Left, 760, 820, , 75, U
    Sleep, 1000
    MouseMove, 540, 450, 75
    Sleep, 25
    MouseClick, Left, 540, 450, , 75, D
    Sleep, 25
    Loop, 30 {
        MouseMove, 33, 0, 75, R
        Sleep, 1
    }
    MouseClick, Left, 1420, 450, , 75, U

return

;Down/Up-Load Control+Alt+V
^!v::
    Send, {Space}
    Sleep, 300
    MouseClick, Left, 970, 660, , 75, D
    Sleep, 15
    MouseClick, Left, 970, 660, , 75, U
return

;Shields Control+Alt+V
^!b::
    Send, {Space}
    Sleep, 300
    PixelGetColor, shield1, 800, 450
    PixelGetColor, shield2, 1000, 350
    PixelGetColor, shield3, 810, 650
    PixelGetColor, shield4, 980, 555
    PixelGetColor, shield5, 1160, 420
    PixelGetColor, shield6, 920, 730
    PixelGetColor, shield7, 1150, 620
    Loop, 7 {
        ColorCode := SubStr(Format(shield%A_Index%), 3, 1)
        Test := ShieldXArr[A_Index]
        If (ColorCode == 7 or ColorCode == 6) {
            MouseClick, Left, ShieldXArr[A_Index], ShieldYArr[A_Index], , 75, D
            Sleep, 25
            MouseClick, Left, ShieldXArr[A_Index], ShieldYArr[A_Index], , 75, U
            Sleep, 25
        }
    }
return

;Align Navigation Control+Alt+N
^!n::
    Send, {Space}
    Sleep, 300
    MouseClick, Left, 960, 540, , 75, D
    Sleep, 35
    MouseClick, Left, 960, 540, , 75, U
    Sleep, 35
return

;Empty Trash Control+Alt+M
^!m::
    Send, {Space}
    Sleep, 300
    MouseClick, Left, 1270, 420, , 75, D
    Sleep, 40
    MouseMove, 1260, 730, 75
    Sleep, 1250
    MouseClick, Left, 1260, 730, , 75, U
    Sleep, 40
return

;Empty Trash Control+Alt+M
^!a::
    Send, {Space}
    Sleep, 750
    PixelGetColor, color, 1190, 845
    If (color == 0xADADAD) {
        MouseClick, Left, 1255, 940, , 75, D
        Sleep, 35
        MouseClick, Left, 1255, 940, , 75, U
        Sleep, 500
    } Else {
        Loop, 5{
            PixelGetColor, medColor, Medbay[A_Index], 590
            ; MsgBox, %medColor% %medNum%
            if(medColor == 0x8686F6) {
                MouseClick, Left, Medbay[A_Index], 850, , 75, D
                Sleep, 25
                MouseClick, Left, Medbay[A_Index], 850, , 75, U
                Sleep, 25
            }
        }
    }
    Send, {Escape down}
    Sleep, 50
    Send, {Escape up}
return