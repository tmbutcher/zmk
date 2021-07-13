#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

SetNumLockState, AlwaysOn

; General Keys
	F17::WheelDown
	F18::WheelUp
	F19::,
	+F20::SendRaw `;
    F24::DllCall("PowrProf\SetSuspendState", "int", 0, "int", 0, "int", 0) ; Computer sleep button

; Mouse Stuff
    Numpad8::
    Numpad5::
    Numpad4::
    Numpad6::
        moveTheMouse()

    !Numpad8::
    !Numpad5::
    !Numpad4::
    !Numpad6::
        moveTheMouse(50,5,10)

    ^Numpad8::
    ^Numpad5::
    ^Numpad4::
    ^Numpad6::
        moveTheMouse(1,0.01,10)

    Numpad7::Click, WheelLeft
    Numpad9:: Click, WheelRight
    NumpadDiv::Click, Middle
    NumpadSub::Click
    NumpadMult::Click, Right

moveTheMouse(defaultRate:=1, acceleration:=2, sleepvar:=20) {
    xrate := defaultRate
    yrate := defaultRate
    CoordMode, Mouse, Screen
    
    Loop
    {
        MouseGetPos, X, Y ; X := Y := 0
        if GetKeyState("Numpad4", "P"){
            xrate := xrate + acceleration
            X := X-xrate
            xIsOn := true
        }else if GetKeyState("Numpad6", "P"){
            xrate := xrate + acceleration
            X := X+xrate + acceleration
            xIsOn := true
        }
        if GetKeyState("Numpad8", "P"){
            yrate := yrate + acceleration
            Y := Y-yrate
            yIsOn := true
        }else if GetKeyState("Numpad5", "P"){
            yrate := yrate + acceleration
            Y := Y+yrate
            yIsOn := true
        }
        if (!xIsOn and !yIsOn){
            xrate := defaultxrate
            yrate := defaultyrate
            return
        }
        else
            DllCall("SetCursorPos", "int", X, "int", Y) ; MouseMove, X, Y, 0, R ; MouseMove, 0, 80, 0, R
            xIsOn := False
            yIsOn := False
            Sleep sleepvar
    }
    return
}