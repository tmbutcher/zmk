#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#NoTrayIcon ;As it says.

SetNumLockState, AlwaysOn

; Ctrl-Hold Stuff
	^#z::
		Send ^z
		; Sleep 1000
		; While GetKeyState("z", "P")
		; 	Send ^z
        ;     Sleep 500
		return
	^#x::
		Send ^x
		Sleep 1000
		If GetKeyState("x", "P")
			Send ^x
		return
	^#c::
		Send ^c
		Sleep 1000
		If GetKeyState("c", "P")
			Send ^c
		return
	^#v::
		Send ^v
		Sleep 5000
		; While GetKeyState("v", "P")  Maybe use a while loop that uses a variable rather than a function?
			; Send ^v
            ; Sleep 500
		return
	^#y::
		Send ^y
		; Sleep 1000
		; While GetKeyState("y", "P")
		; 	Send ^y
        ;     Sleep 500
		return

; General Keys
	F18::=
	F19::,
	+F20::SendRaw `;
    #^+!'::DllCall("PowrProf\SetSuspendState", "int", 0, "int", 1, "int", 0) ; Computer sleep button

; Mouse Stuff
    Numpad8::        ;Regular mouse movement
    Numpad5::
    Numpad4::
    Numpad6::
        moveTheMouse()
		return

    !Numpad8::       ;Faster mouse movement w/ ALT
    !Numpad5::
    !Numpad4::
    !Numpad6::
        moveTheMouse(50,5,10)
		return

    !#^Numpad8::       ;Slower mouse movement w/ HYPER
    !#^Numpad5::
    !#^Numpad4::
    !#^Numpad6::
        moveTheMouse(1,0.01,10)
		return

	F16::Click, WheelDown
	F17::Click, WheelUp
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
        } else if GetKeyState("Numpad6", "P") {
            xrate := xrate + acceleration
            X := X+xrate + acceleration
            xIsOn := true
        }
        if GetKeyState("Numpad8", "P") {
            yrate := yrate + acceleration
            Y := Y-yrate
            yIsOn := true
        } else if GetKeyState("Numpad5", "P") {
            yrate := yrate + acceleration
            Y := Y+yrate
            yIsOn := true
        }
        if (!xIsOn and !yIsOn){
            xrate := defaultxrate
            yrate := defaultyrate
            return
        } else {
            DllCall("SetCursorPos", "int", X, "int", Y) ; MouseMove, %xrate%, %yrate%, 2, R ; MouseMove, 0, 80, 0, R
            xIsOn := False
            yIsOn := False
            Sleep sleepvar
        }    
    }
    return
}
