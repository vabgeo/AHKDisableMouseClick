#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

;#Exit the application
BtnExt()
{
 ExitApp
}

;#Create the GUI and assign variables to check boxes
Gui +LastFound
Gui, Add, CheckBox, vRBtnCheck, Tick Yes to disable Right Click
Gui, Add, CheckBox, vMBtnCheck, Tick Yes to disable Middle Click
Gui, Add, CheckBox, vWBtnCheck, Tick Yes to disable Scrolling Wheel

Gui, Add, Button, Default w80 gBtnExt, Stop and Exit
Gui, Add, Text,,Press Ctrl+Escape key together to exit the application
Gui, Add, Text,,v0.2 Build 20022021
Gui, Add, Text,,(c) Va.B.Geo https://github.com/vabgeo/AHKDisableMouseClick

;#Show the GUI here
Gui, Show, , Mouse Enable/Disable

;# Hotkey shortcut to exit application with a quick key
^Esc::ExitApp

;# TODO - Optimize as a single function
;# Handle Middle button, return if Middle button is disabled and show a tool tip
MButton::
{
	GuiControlGet, MyVar, , MBtnCheck
	if( %MyVar% == 0 )
		Send {MButton}
	else
		Tooltip, Middle click is disabled Press ctrl+esc to exit
		SetTimer,RemoveToolTip,1000
return
}

;# Handle Right button, return if button is disabled and show a tool tip
RButton::
{
	GuiControlGet, MyVar, , RBtnCheck
	if( %MyVar% == 0 )
		Send {RButton}
	else
		Tooltip, Right click is disabled Press ctrl+esc to exit
		SetTimer,RemoveToolTip,1000
return
}

;# Handle Wheel scroll, return if button is disabled and show a tool tip
WheelDown::
{
	GuiControlGet, MyVar, , WBtnCheck
	if( %MyVar% == 0 ) 
			Send {WheelDown}
	else
	{
		Tooltip, Mouse Scrolling is disabled Press ctrl+esc to exit
		SetTimer,RemoveToolTip,1000
	}
}
Return

;# Handle Wheel scroll, return if button is disabled and show a tool tip
WheelUp::
{
	GuiControlGet, MyVar, , WBtnCheck
	if( %MyVar% == 0 ) {
			Send {WheelUp}
	}
	else
	{
		Tooltip, Mouse Scrolling is disabled Press ctrl+esc to exit
		SetTimer,RemoveToolTip,1000
	}
}
return

RemoveToolTip:
{
	Tooltip
	SetTimer, RemoveToolTip, Off
	return
}

GUIClose:
	; MsgBox, Press CTRL and ESC keys together to Stop and Exit this application
	ExitApp
return
