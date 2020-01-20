;~ *********************************************************************************************************************
;~ |    Author: elModo7                                                                                                |
;~ |    Description: Allows for bluetooth connected Wiimote controllers to quickly remapp its buttons to AHK functions.|
;~ |    Version: 0.1                                                                                                   |
;~ |    Credits: AHKHID - An AHK implementation of the HID functions by TheGood.                                       |
;~ |                                                                                                                   |
;~ |	WiiMote Button HID Codes:                                                                                      |
;~ |	None: 00000                                                                                                    |
;~ |	A: 00008                                                                                                       |
;~ |	B: 00004                                                                                                       |
;~ |	1: 00002                                                                                                       |
;~ |	2: 00001                                                                                                       |
;~ |	+: 01000                                                                                                       |
;~ |	-: 00010                                                                                                       |
;~ |	Home: 00080                                                                                                    |
;~ |	Up: 00800                                                                                                      |
;~ |	Down: 00400                                                                                                    |
;~ |	Left: 00100                                                                                                    |
;~ |	Right: 00200                                                                                                   |
;~ *********************************************************************************************************************
#NoEnv
#SingleInstance, Force
ListLines, Off
SetBatchLines, -1
global editUp, editDown, editLeft, editRight, editA, editB, edit1, edit2, editAdd, editSub, editHome, pestanya
FileRead, editUp, btn\Up.ahk
FileRead, editSub, btn\-.ahk
FileRead, editAdd, btn\+.ahk
FileRead, edit1, btn\1.ahk
FileRead, edit2, btn\2.ahk
FileRead, editA, btn\A.ahk
FileRead, editB, btn\B.ahk
FileRead, editDown, btn\Down.ahk
FileRead, editHome, btn\Home.ahk
FileRead, editLeft, btn\Left.ahk
FileRead, editRight, btn\Right.ahk
; GUI
Gui +LastFound -Resize -MaximizeBox
Gui Add, Button, x3 y536 w80 h23 glimpiar, CLEAR
Gui Add, Button, x91 y536 w80 h23 gcancelar, CANCEL
Gui Add, Button, x179 y536 w80 h23 gguardar, SAVE
Gui Font, c0x0000FF
Gui Add, Text, vtxt x264 y536 w197 h23 +0x200 +Right
Gui Font
Gui Add, Tab3, x0 y0 w467 h531, Up|Down|Left|Right|A|B|1|2|+|-|Home
Gui Tab, 1
Gui Add, Edit, x0 y21 w465 h508 geditUp veditUp
Gui Tab                                   
Gui Tab, 2                                
Gui Add, Edit, x0 y21 w465 h508 geditDown veditDown
Gui Tab                                   
Gui Tab, 3                                
Gui Add, Edit, x0 y21 w465 h508 geditLeft veditLeft
Gui Tab                                   
Gui Tab, 4                                
Gui Add, Edit, x0 y21 w465 h508 geditRight veditRight
Gui Tab                                   
Gui Tab, 5                                
Gui Add, Edit, x0 y21 w465 h508 geditA veditA
Gui Tab                                   
Gui Tab, 6                                
Gui Add, Edit, x0 y21 w465 h508 geditB veditB
Gui Tab                                   
Gui Tab, 7                                
Gui Add, Edit, x0 y21 w465 h508 gedit1 vedit1
Gui Tab                                   
Gui Tab, 8                                
Gui Add, Edit, x0 y21 w465 h508 gedit2 vedit2
Gui Tab                                   
Gui Tab, 9                                
Gui Add, Edit, x0 y21 w465 h508 geditAdd veditAdd
Gui Tab                                   
Gui Tab, 10                               
Gui Add, Edit, x0 y21 w465 h508 geditSub veditSub
Gui Tab                                   
Gui Tab, 11                               
Gui Add, Edit, x0 y21 w465 h508 geditHome veditHome
Gui Tab
Gui Show, w465 h564, Wiimote Gui Remapper
GuiControl, Text, editA, % editA
GuiControl, Text, editB, % editB
GuiControl, Text, edit1, % edit1
GuiControl, Text, edit2, % edit2
GuiControl, Text, editAdd, % editAdd
GuiControl, Text, editSub, % editSub
GuiControl, Text, editHome, % editHome
GuiControl, Text, editUp, % editUp
GuiControl, Text, editDown, % editDown
GuiControl, Text, editLeft, % editLeft
GuiControl, Text, editRight, % editRight
GuiHandle := WinExist()
AHKHID_UseConstants()
OnMessage(0x00FF, "InputMsg")
AHKHID_AddRegister(1)
r := AHKHID_AddRegister(1, 5, GuiHandle, 256)
AHKHID_Register()
#Include, btn\Up.ahk
#Include, btn\-.ahk
#Include, btn\+.ahk
#Include, btn\1.ahk
#Include, btn\2.ahk
#Include, btn\A.ahk
#Include, btn\B.ahk
#Include, btn\Down.ahk
#Include, btn\Home.ahk
#Include, btn\Left.ahk
#Include, btn\Right.ahk
Return

InputMsg(wParam, lParam) {
    Local r, h
    Critical
	r := AHKHID_GetInputData(lParam, uData)
	if(SubStr(Bin2Hex(&uData, r), 2, 5) = "00008")
	{
		;~ A
        gosub, A
	}else if(SubStr(Bin2Hex(&uData, r), 2, 5) = "00004")
	{
		;~ B
		gosub, B
	}else if(SubStr(Bin2Hex(&uData, r), 2, 5) = "00002")
	{
		;~ 1
		gosub, 1
	}else if(SubStr(Bin2Hex(&uData, r), 2, 5) = "00001")
	{
		;~ 2
		gosub, 2
	}else if(SubStr(Bin2Hex(&uData, r), 2, 5) = "01000")
	{
		;~ +
		gosub, Add
	}else if(SubStr(Bin2Hex(&uData, r), 2, 5) = "00010")
	{
		;~ -
		gosub, Sub
	}else if(SubStr(Bin2Hex(&uData, r), 2, 5) = "00080")
	{
		;~ Home
		gosub, Home
	}else if(SubStr(Bin2Hex(&uData, r), 2, 5) = "00800")
	{
		;~ Up
		gosub, Up
	}else if(SubStr(Bin2Hex(&uData, r), 2, 5) = "00400")
	{
		;~ Down
		gosub, Down
	}else if(SubStr(Bin2Hex(&uData, r), 2, 5) = "00100")
	{
		;~ Left
		gosub, Left
	}else if(SubStr(Bin2Hex(&uData, r), 2, 5) = "00200")
	{
		;~ Right
        gosub, Right
    }
}


editUp:
	pestanya := "Up"
return

editDown:
	pestanya := "Down"
return

editLeft:
	pestanya := "Left"
return

editRight:
	pestanya := "Right"
return

editA:
	pestanya := "A"
return

editB:
	pestanya := "B"
return

edit1:
	pestanya := "1"
return

edit2:
	pestanya := "2"
return

editAdd:
	pestanya := "Add"
return

editSub:
	pestanya := "Sub"
return

editHome:
	pestanya := "Home"
return

guardar:
	gui, Submit, NoHide
	if(pestanya = "Up"){
		FileDelete, btn\Up.ahk
		FileAppend, % editUp, btn\Up.ahk
	}
	else if(pestanya = "Sub"){
		FileDelete, btn\-.ahk
		FileAppend, % editSub, btn\-.ahk
	}
	else if(pestanya = "Add"){
		FileDelete, btn\+.ahk
		FileAppend, % editAdd, btn\+.ahk
	}
	else if(pestanya = "1"){
		FileDelete, btn\1.ahk
		FileAppend, % edit1, btn\1.ahk
	}
	else if(pestanya = "2"){
		FileDelete, btn\2.ahk
		FileAppend, % edit2, btn\2.ahk
	}
	else if(pestanya = "A"){
		FileDelete, btn\A.ahk
		FileAppend, % editA, btn\A.ahk
	}
	else if(pestanya = "B"){
		FileDelete, btn\B.ahk
		FileAppend, % editB, btn\B.ahk
	}
	else if(pestanya = "Down"){
		FileDelete, btn\Down.ahk
		FileAppend, % editDown, btn\Down.ahk
	}
	else if(pestanya = "Home"){
		FileDelete, btn\Home.ahk
		FileAppend, % editHome, btn\Home.ahk
	}
	else if(pestanya = "Left"){
		FileDelete, btn\Left.ahk
		FileAppend, % editLeft, btn\Left.ahk
	}
	else if(pestanya = "Right"){
		FileDelete, btn\Right.ahk
		FileAppend, % editRight, btn\Right.ahk
	}
	GuiControl, Text, txt, Control + Shift + R: Aplicar cambios.
return

limpiar:
	if(pestanya = "Up")
		GuiControl, Text, editUp,Up:`n`nreturn
	else if(pestanya = "Down")
		GuiControl, Text, editDown,Down:`n`nreturn
	else if(pestanya = "Left")
		GuiControl, Text, editLeft,Left:`n`nreturn
	else if(pestanya = "Right")
		GuiControl, Text, editRight,Right:`n`nreturn
	else if(pestanya = "A")
		GuiControl, Text, editA,A:`n`nreturn
	else if(pestanya = "B")
		GuiControl, Text, editB,B:`n`nreturn
	else if(pestanya = "1")
		GuiControl, Text, edit1,1:`n`nreturn
	else if(pestanya = "2")
		GuiControl, Text, edit2,2:`n`nreturn
	else if(pestanya = "Add")
		GuiControl, Text, editAdd,Add:`n`nreturn
	else if(pestanya = "Sub")
		GuiControl, Text, editSub,Sub:`n`nreturn
	else if(pestanya = "Home")
		GuiControl, Text, editHome,Home:`n`nreturn
return

cancelar:
	FileRead, editUp, btn\Up.ahk
	FileRead, editSub, btn\-.ahk
	FileRead, editAdd, btn\+.ahk
	FileRead, edit1, btn\1.ahk
	FileRead, edit2, btn\2.ahk
	FileRead, editA, btn\A.ahk
	FileRead, editB, btn\B.ahk
	FileRead, editDown, btn\Down.ahk
	FileRead, editHome, btn\Home.ahk
	FileRead, editLeft, btn\Left.ahk
	FileRead, editRight, btn\Right.ahk
	if(pestanya = "A")
		GuiControl, Text, editA, % editA
	else if(pestanya = "B")
		GuiControl, Text, editB, % editB
	else if(pestanya = "1")
		GuiControl, Text, edit1, % edit1
	else if(pestanya = "2")
		GuiControl, Text, edit2, % edit2
	else if(pestanya = "Add")
		GuiControl, Text, editAdd, % editAdd
	else if(pestanya = "Sub")
		GuiControl, Text, editSub, % editSub
	else if(pestanya = "Home")
		GuiControl, Text, editHome, % editHome
	else if(pestanya = "Up")
		GuiControl, Text, editUp, % editUp
	else if(pestanya = "Down")
		GuiControl, Text, editDown, % editDown
	else if(pestanya = "Left")
		GuiControl, Text, editLeft, % editLeft
	else if(pestanya = "Right")
		GuiControl, Text, editRight, % editRight
return

^+r::
reload

GuiEscape:
GuiClose:
    ExitApp
	
	Bin2Hex(addr,len) {
    Static fun, ptr 
    If (fun = "") {
        If A_IsUnicode
            If (A_PtrSize = 8)
                h=4533c94c8bd14585c07e63458bd86690440fb60248ffc2418bc9410fb6c0c0e8043c090fb6c00f97c14180e00f66f7d96683e1076603c8410fb6c06683c1304180f8096641890a418bc90f97c166f7d94983c2046683e1076603c86683c13049ffcb6641894afe75a76645890ac366448909c3
            Else h=558B6C241085ED7E5F568B74240C578B7C24148A078AC8C0E90447BA090000003AD11BD2F7DA66F7DA0FB6C96683E2076603D16683C230668916240FB2093AD01BC9F7D966F7D96683E1070FB6D06603CA6683C13066894E0283C6044D75B433C05F6689065E5DC38B54240833C966890A5DC3
        Else h=558B6C241085ED7E45568B74240C578B7C24148A078AC8C0E9044780F9090F97C2F6DA80E20702D1240F80C2303C090F97C1F6D980E10702C880C1308816884E0183C6024D75CC5FC606005E5DC38B542408C602005DC3
        VarSetCapacity(fun, StrLen(h) // 2)
        Loop % StrLen(h) // 2
            NumPut("0x" . SubStr(h, 2 * A_Index - 1, 2), fun, A_Index - 1, "Char")
        ptr := A_PtrSize ? "Ptr" : "UInt"
        DllCall("VirtualProtect", ptr, &fun, ptr, VarSetCapacity(fun), "UInt", 0x40, "UInt*", 0)
    }
    VarSetCapacity(hex, A_IsUnicode ? 4 * len + 2 : 2 * len + 1)
    DllCall(&fun, ptr, &hex, ptr, addr, "UInt", len, "CDecl")
    VarSetCapacity(hex, -1) ; update StrLen
    Return hex
}

AHKHID_Included := True
AHKHID_SetConstants:
;______________________________________
;Flags you can use in AHKHID_GetDevInfo
;http://msdn.microsoft.com/en-us/library/ms645581
DI_DEVTYPE                  := 4    ;Type of the device. See RIM_ constants.

DI_MSE_ID                   := 8    ;ID for the mouse device.
DI_MSE_NUMBEROFBUTTONS      := 12   ;Number of buttons for the mouse.
DI_MSE_SAMPLERATE           := 16   ;Number of data points per second. This information may not be applicable for every
                                    ;mouse device.
DI_MSE_HASHORIZONTALWHEEL   := 20   ;Vista and later only: TRUE if the mouse has a wheel for horizontal scrolling;
                                    ;otherwise, FALSE.

DI_KBD_TYPE                 := 8    ;Type of the keyboard. 
DI_KBD_SUBTYPE              := 12   ;Subtype of the keyboard. 
DI_KBD_KEYBOARDMODE         := 16   ;Scan code mode. 
DI_KBD_NUMBEROFFUNCTIONKEYS := 20   ;Number of function keys on the keyboard.
DI_KBD_NUMBEROFINDICATORS   := 24   ;Number of LED indicators on the keyboard.
DI_KBD_NUMBEROFKEYSTOTAL    := 28   ;Total number of keys on the keyboard. 

DI_HID_VENDORID             := 8    ;Vendor ID for the HID.
DI_HID_PRODUCTID            := 12   ;Product ID for the HID. 
DI_HID_VERSIONNUMBER        := 16   ;Version number for the HID. 
DI_HID_USAGEPAGE            := 20 | 0x0100  ;Top-level collection Usage Page for the device.
DI_HID_USAGE                := 22 | 0x0100  ;Top-level collection Usage for the device.
;________________________________________
;Flags you can use in AHKHID_GetInputInfo
;http://msdn.microsoft.com/en-us/library/ms645562
II_DEVTYPE          := 0    ;Type of the device generating the raw input data. See RIM_ constants.
II_DEVHANDLE        := 8    ;Handle to the device generating the raw input data.

II_MSE_FLAGS        := (08+A_PtrSize*2) | 0x0100  ;Mouse state. This member can be any reasonable combination of the
                                    ;following values -> see MOUSE constants.
II_MSE_BUTTONFLAGS  := (12+A_PtrSize*2) | 0x0100  ;Transition state of the mouse buttons. This member can be one or more of
                                    ;the following values -> see RI_MOUSE constants.
II_MSE_BUTTONDATA   := (14+A_PtrSize*2) | 0x1100  ;If usButtonFlags is RI_MOUSE_WHEEL, this member is a signed value that
                                    ;specifies the wheel delta.
II_MSE_RAWBUTTONS   := (16+A_PtrSize*2)           ;Raw state of the mouse buttons. 
II_MSE_LASTX        := (20+A_PtrSize*2) | 0x1000  ;Motion in the X direction. This is signed relative motion or absolute
                                    ;motion, depending on the value of usFlags.
II_MSE_LASTY        := (24+A_PtrSize*2) | 0x1000  ;Motion in the Y direction. This is signed relative motion or absolute
                                    ;motion, depending on the value of usFlags. 
II_MSE_EXTRAINFO    := (28+A_PtrSize*2)           ;Device-specific additional information for the event. 

II_KBD_MAKECODE     := (08+A_PtrSize*2) | 0x0100  ;Scan code from the key depression. The scan code for keyboard overrun is
                                    ;KEYBOARD_OVERRUN_MAKE_CODE.
II_KBD_FLAGS        := (10+A_PtrSize*2) | 0x0100  ;Flags for scan code information. It can be one or more of the following
                                    ;values -> see RI_KEY constants.
II_KBD_VKEY         := (14+A_PtrSize*2) | 0x0100  ;Microsoft Windows message compatible virtual-key code.
II_KBD_MSG          := (16+A_PtrSize*2)           ;Corresponding window message, for example WM_KEYDOWN, WM_SYSKEYDOWN, and
                                                  ;so forth.
II_KBD_EXTRAINFO    := (20+A_PtrSize*2)           ;Device-specific additional information for the event.

II_HID_SIZE         := (08+A_PtrSize*2)           ;Size, in bytes, of each HID input in bRawData.
II_HID_COUNT        := (12+A_PtrSize*2)           ;Number of HID inputs in bRawData.

;DO NOT USE WITH AHKHID_GetInputInfo. Use AHKHID_GetInputData instead to retrieve the raw data.
II_HID_DATA         := (16+A_PtrSize*2)           ;Raw input data as an array of bytes.
;__________________________________________________________________________________
;Device type values returned by AHKHID_GetDevType as well as DI_DEVTYPE and II_DEVTYPE
;http://msdn.microsoft.com/en-us/library/ms645568
RIM_TYPEMOUSE       := 0    ;The device is a mouse.
RIM_TYPEKEYBOARD    := 1    ;The device is a keyboard.
RIM_TYPEHID         := 2    ;The device is an Human Interface Device (HID) that is not a keyboard and not a mouse.
;_______________________________________________________________________________________________
;Different flags for RAWINPUTDEVICE structure (to be used with AHKHID_AddRegister and AHKHID_Register)
;http://msdn.microsoft.com/en-us/library/ms645565
RIDEV_REMOVE        := 0x00000001   ;If set, this removes the top level collection from the inclusion list. This tells the
                                    ;operating system to stop reading from a device which matches the top level collection.
RIDEV_EXCLUDE       := 0x00000010   ;If set, this specifies the top level collections to exclude when reading a complete
                                    ;usage page. This flag only affects a TLC whose usage page is already specified with
                                    ;RIDEV_PAGEONLY.
RIDEV_PAGEONLY      := 0x00000020   ;If set, this specifies all devices whose top level collection is from the specified
                                    ;usUsagePage. Note that usUsage must be zero. To exclude a particular top level
                                    ;collection, use RIDEV_EXCLUDE.
RIDEV_NOLEGACY      := 0x00000030   ;If set, this prevents any devices specified by usUsagePage or usUsage from generating
                                    ;legacy messages. This is only for the mouse and keyboard. See Remarks.
RIDEV_INPUTSINK     := 0x00000100   ;If set, this enables the caller to receive the input even when the caller is not in
                                    ;the foreground. Note that hwndTarget must be specified.
RIDEV_CAPTUREMOUSE  := 0x00000200   ;If set, the mouse button click does not activate the other window.
RIDEV_NOHOTKEYS     := 0x00000200   ;If set, the application-defined keyboard device hotkeys are not handled. However, the
                                    ;system hotkeys; for example, ALT+TAB and CTRL+ALT+DEL, are still handled. By default,
                                    ;all keyboard hotkeys are handled. RIDEV_NOHOTKEYS can be specified even if
                                    ;RIDEV_NOLEGACY is not specified and hwndTarget is NULL.
RIDEV_APPKEYS       := 0x00000400   ;Microsoft Windows XP Service Pack 1 (SP1): If set, the application command keys are
                                    ;handled. RIDEV_APPKEYS can be specified only if RIDEV_NOLEGACY is specified for a
                                    ;keyboard device.
RIDEV_EXINPUTSINK   := 0x00001000   ;Vista and later only: If set, this enables the caller to receive input in the
                                    ;background only if the foreground application does not process it. In other words, if
                                    ;the foreground application is not registered for raw input, then the background
                                    ;application that is registered will receive the input.
RIDEV_DEVNOTIFY     := 0x00002000   ;Vista and later only: If set, this enables the caller to receive WM_INPUT_DEVICE_CHANGE
                                    ;notifications for device arrival and device removal.
;__________________________________________________
;Different values of wParam in the WM_INPUT message
;http://msdn.microsoft.com/en-us/library/ms645590
RIM_INPUT       := 0    ;Input occurred while the application was in the foreground. The application must call
                        ;DefWindowProc so the system can perform cleanup.
RIM_INPUTSINK   := 1    ;Input occurred while the application was not in the foreground. The application must call
                        ;DefWindowProc so the system can perform the cleanup.
;__________________________________
;Flags for GetRawInputData API call
;http://msdn.microsoft.com/en-us/library/ms645596
RID_INPUT    := 0x10000003    ;Get the raw data from the RAWINPUT structure.
RID_HEADER   := 0x10000005    ;Get the header information from the RAWINPUT structure.
;_____________________________________
;Flags for RAWMOUSE (part of RAWINPUT)
;http://msdn.microsoft.com/en-us/library/ms645578

;Flags for the II_MSE_FLAGS member
MOUSE_MOVE_RELATIVE         := 0     ;Mouse movement data is relative to the last mouse position.
MOUSE_MOVE_ABSOLUTE         := 1     ;Mouse movement data is based on absolute position.
MOUSE_VIRTUAL_DESKTOP       := 0x02  ;Mouse coordinates are mapped to the virtual desktop (for a multiple monitor system)
MOUSE_ATTRIBUTES_CHANGED    := 0x04  ;Mouse attributes changed; application needs to query the mouse attributes.

;Flags for the II_MSE_BUTTONFLAGS member
RI_MOUSE_LEFT_BUTTON_DOWN   := 0x0001   ;Self-explanatory
RI_MOUSE_LEFT_BUTTON_UP     := 0x0002   ;Self-explanatory
RI_MOUSE_RIGHT_BUTTON_DOWN  := 0x0004   ;Self-explanatory
RI_MOUSE_RIGHT_BUTTON_UP    := 0x0008   ;Self-explanatory
RI_MOUSE_MIDDLE_BUTTON_DOWN := 0x0010   ;Self-explanatory
RI_MOUSE_MIDDLE_BUTTON_UP   := 0x0020   ;Self-explanatory
RI_MOUSE_BUTTON_4_DOWN      := 0x0040   ;XBUTTON1 changed to down.
RI_MOUSE_BUTTON_4_UP        := 0x0080   ;XBUTTON1 changed to up.
RI_MOUSE_BUTTON_5_DOWN      := 0x0100   ;XBUTTON2 changed to down.
RI_MOUSE_BUTTON_5_UP        := 0x0200   ;XBUTTON2 changed to up.
RI_MOUSE_WHEEL              := 0x0400   ;Raw input comes from a mouse wheel. The wheel delta is stored in usButtonData.
;____________________________________________
;Flags for the RAWKEYBOARD (part of RAWINPUT)
;http://msdn.microsoft.com/en-us/library/ms645575

;Flag for the II_KBD_MAKECODE member in the event of a keyboard overrun
KEYBOARD_OVERRUN_MAKE_CODE  := 0xFF

;Flags for the II_KBD_FLAGS member
RI_KEY_MAKE             := 0
RI_KEY_BREAK            := 1
RI_KEY_E0               := 2
RI_KEY_E1               := 4
RI_KEY_TERMSRV_SET_LED  := 8
RI_KEY_TERMSRV_SHADOW   := 0x10
;____________________________________
;AHKHID FUNCTIONS

If Not AHKHID_Included
    Return

AHKHID_UseConstants() {
    Global ;To make the constants global
    AHKHID_Included := False
    Gosub, AHKHID_SetConstants
}

AHKHID_Initialize(bRefresh = False) {
    Static uHIDList, bInitialized := False
    
    If bInitialized And Not bRefresh
        Return &uHIDList
    
    ;Get the device count
    r := DllCall("GetRawInputDeviceList", "Ptr", 0, "UInt*", iCount, "UInt", A_PtrSize * 2)
    
    ;Check for error
    If (r = -1) Or ErrorLevel {
        ErrorLevel = GetRawInputDeviceList call failed.`nReturn value: %r%`nErrorLevel: %ErrorLevel%`nLine: %A_LineNumber%`nLast Error: %A_LastError%
        Return -1
    }
    
    ;Prep var
    VarSetCapacity(uHIDList, iCount * (A_PtrSize * 2))
    r := DllCall("GetRawInputDeviceList", "Ptr", &uHIDList, "UInt*", iCount, "UInt", A_PtrSize * 2)
    If (r = -1) Or ErrorLevel {
        ErrorLevel = GetRawInputDeviceList call failed.`nReturn value: %r%`nErrorLevel: %ErrorLevel%`nLine: %A_LineNumber%`nLast Error: %A_LastError%
        Return -1
    }
    
    bInitialized := True
    Return &uHIDList
}

AHKHID_GetDevCount() {
    
    ;Get the device count
    r := DllCall("GetRawInputDeviceList", "Ptr", 0, "UInt*", iCount, "UInt", A_PtrSize * 2)
    
    ;Check for error
    If (r = -1) Or ErrorLevel {
        ErrorLevel = GetRawInputDeviceList call failed.`nReturn value: %r%`nErrorLevel: %ErrorLevel%`nLine: %A_LineNumber%`nLast Error: %A_LastError%
        Return -1
    } Else Return iCount
}

AHKHID_GetDevHandle(i) {
    Return NumGet(AHKHID_Initialize(), (i - 1) * (A_PtrSize * 2))
}

AHKHID_GetDevIndex(Handle) {
    Loop % AHKHID_GetDevCount()
        If (NumGet(AHKHID_Initialize(), (A_Index - 1) * (A_PtrSize * 2)) = Handle)
            Return A_Index
    Return 0
}

AHKHID_GetDevType(i, IsHandle = False) {
    Return Not IsHandle ? NumGet(AHKHID_Initialize(), ((i - 1) * (A_PtrSize * 2)) + A_PtrSize, "UInt")
    : NumGet(AHKHID_Initialize(), ((AHKHID_GetDevIndex(i) - 1) * (A_PtrSize * 2)) + A_PtrSize, "UInt")
}

AHKHID_GetDevName(i, IsHandle = False) {
    
    ;Get index if i is handle
    h := IsHandle ? i : AHKHID_GetDevHandle(i)
    
    ;Get device name length.                                RIDI_DEVICENAME
    r := DllCall("GetRawInputDeviceInfo", "Ptr", h, "UInt", 0x20000007, "Ptr", 0, "UInt*", iLength)
    If (r = -1) Or ErrorLevel {
        ErrorLevel = GetRawInputDeviceInfo call failed.`nReturn value: %r%`nErrorLevel: %ErrorLevel%`nLine: %A_LineNumber%`nLast Error: %A_LastError%
        Return ""
    }
	
    ;Get device name.
    VarSetCapacity(s, (iLength + 1) * 2)                         ;RIDI_DEVICENAME
    r := DllCall("GetRawInputDeviceInfo", "Ptr", h, "UInt", 0x20000007, "Str", s, "UInt*", iLength)
    If (r = -1) Or ErrorLevel {
        ErrorLevel = GetRawInputDeviceInfo call failed.`nReturn value: %r%`nErrorLevel: %ErrorLevel%`nLine: %A_LineNumber%`nLast Error: %A_LastError%
        Return ""
    }
    
    Return s
}

AHKHID_GetDevInfo(i, Flag, IsHandle = False) {
    Static uInfo, iLastHandle := 0
    
    ;Get index if i is handle
    h := IsHandle ? i : AHKHID_GetDevHandle(i)
    
    ;Check if the handle changed
    If (h = iLastHandle) ;It's the same device. No need to call again
        Return NumGet(uInfo, Flag, AHKHID_NumIsShort(Flag) ? "UShort" : "UInt")
    Else {
        
        ;Get device info buffer size.                           RIDI_DEVICEINFO
        r := DllCall("GetRawInputDeviceInfo", "Ptr", h, "UInt", 0x2000000b, "Ptr", 0, "UInt*", iLength)
        If (r = -1) Or ErrorLevel {
            ErrorLevel = GetRawInputDeviceInfo call failed.`nReturn value: %r%`nErrorLevel: %ErrorLevel%`nLine: %A_LineNumber%`nLast Error: %A_LastError%
            Return -1
        }
        
        ;Get device info
        VarSetCapacity(uInfo, iLength)
        NumPut(iLength, uInfo, 0, "UInt") ;Put length in struct RIDI_DEVICEINFO
        r := DllCall("GetRawInputDeviceInfo", "Ptr", h, "UInt", 0x2000000b, "Ptr", &uInfo, "UInt*", iLength)
        If (r = -1) Or ErrorLevel {
            ErrorLevel = GetRawInputDeviceInfo call failed.`nReturn value: %r%`nErrorLevel: %ErrorLevel%`nLine: %A_LineNumber%`nLast Error: %A_LastError%
            Return -1
        }
        
        ;Successful. Keep handle.
        iLastHandle := h
        
        ;Retrieve data
        Return NumGet(uInfo, Flag, AHKHID_NumIsShort(Flag) ? "UShort" : "UInt")
    }
    
    Return 0
}

AHKHID_AddRegister(UsagePage = False, Usage = False, Handle = False, Flags = 0) {
    Static uDev, iIndex := 0, iCount := 0
    
    ;Check if we just want the address
    If Not (UsagePage Or Usage Or Handle Or Flags)
        Return &uDev
    ;Check if we just want the count
    Else If (UsagePage = "Count")
        Return iCount
    ;Check if we're dimensioning the struct
    Else If UsagePage And Not (Usage Or Handle Or Flags) {
        iCount := UsagePage
        iIndex := 0
        VarSetCapacity(uDev, iCount * (8 + A_PtrSize))
        Return &uDev
    }
    
    ;Check if there's space before adding data to struct
    If (iIndex = iCount)
        Return -1    ;Full capacity
    
    ;Check if hwnd needs to be null. RIDEV_REMOVE, RIDEV_EXCLUDE
    Handle := ((Flags & 0x00000001) Or (Flags & 0x00000010)) ? 0 : Handle

    ;Put in struct
    NumPut(UsagePage, uDev, (iIndex * (8 + A_PtrSize)) + 0, "UShort")
    NumPut(Usage,     uDev, (iIndex * (8 + A_PtrSize)) + 2, "UShort")
    NumPut(Flags,     uDev, (iIndex * (8 + A_PtrSize)) + 4, "UInt")
    NumPut(Handle,    uDev, (iIndex * (8 + A_PtrSize)) + 8, "Ptr")
    
    ;Move to next slot
    iIndex += 1
    
    Return &uDev
}

AHKHID_Register(UsagePage = False, Usage = False, Handle = False, Flags = 0) {
    
    ;Check if we're using the AddRegister array or only a single struct
    If Not (UsagePage Or Usage Or Handle Or Flags) {
        
        ;Call
        r := DllCall("RegisterRawInputDevices", "Ptr", AHKHID_AddRegister(), "UInt", AHKHID_AddRegister("Count"), "UInt", 8 + A_PtrSize)
        
        ;Check for error
        If Not r {
            ErrorLevel = RegisterRawInputDevices call failed.`nReturn value: %r%`nErrorLevel: %ErrorLevel%`nLine: %A_LineNumber%`nLast Error: %A_LastError%
            Return -1
        }
        
    ;Build struct and call
    } Else {
        
        ;Prep var
        VarSetCapacity(uDev, (8 + A_PtrSize), 0)
        
        ;Check if hwnd needs to be null. RIDEV_REMOVE, RIDEV_EXCLUDE
        Handle := ((Flags & 0x00000001) Or (Flags & 0x00000010)) ? 0 : Handle
        
        NumPut(UsagePage, uDev, 0, "UShort")
        NumPut(Usage,     uDev, 2, "UShort")
        NumPut(Flags,     uDev, 4, "UInt")
        NumPut(Handle,    uDev, 8, "Ptr")
        
        ;Call
        r := DllCall("RegisterRawInputDevices", "Ptr", &uDev, "UInt", 1, "UInt", 8 + A_PtrSize)
        
        ;Check for error
        If Not r Or ErrorLevel {
            ErrorLevel = RegisterRawInputDevices call failed.`nReturn value: %r%`nErrorLevel: %ErrorLevel%`nLine: %A_LineNumber%`nLast Error: %A_LastError%
            Return -1
        }
    }
    
    Return 0
}

AHKHID_GetRegisteredDevs(ByRef uDev) {
    
    ;Get length
    VarSetCapacity(iCount, 4, 0)
    r := DllCall("GetRegisteredRawInputDevices", "Ptr", 0, "UInt*", iCount, "UInt", 8 + A_PtrSize)
    If ErrorLevel {
        ErrorLevel = GetRegisteredRawInputDevices call failed.`nReturn value: %r%`nErrorLevel: %ErrorLevel%`nLine: %A_LineNumber%`nLast Error: %A_LastError%
        Return -1
    }
    
    If (iCount > 0) {
        
        ;Prep var
        VarSetCapacity(uDev, iCount * (8 + A_PtrSize))
        
        ;Call
        r := DllCall("GetRegisteredRawInputDevices", "Ptr", &uDev, "UInt*", iCount, "UInt", 8 + A_PtrSize)
        If (r = -1) Or ErrorLevel {
            ErrorLevel = GetRegisteredRawInputDevices call failed.`nReturn value: %r%`nErrorLevel: %ErrorLevel%`nLine: %A_LineNumber%`nLast Error: %A_LastError%
            Return -1
        }
    }
    
    Return iCount
}

AHKHID_GetInputInfo(InputHandle, Flag) {
    Static uRawInput, iLastHandle := 0
    
    ;Check if it's the same handle
    If (InputHandle = iLastHandle) ;We can retrieve the data without having to call again
        Return NumGet(uRawInput, Flag, AHKHID_NumIsShort(Flag) ? (AHKHID_NumIsSigned(Flag) ? "Short" : "UShort") : (AHKHID_NumIsSigned(Flag) ? "Int" : (Flag = 8 ? "Ptr" : "UInt")))
    Else {    ;We need to get a fresh copy
        
        ;Get raw data size                                           RID_INPUT
        r := DllCall("GetRawInputData", "UInt", InputHandle, "UInt", 0x10000003, "Ptr", 0, "UInt*", iSize, "UInt", 8 + A_PtrSize * 2)
        If (r = -1) Or ErrorLevel {
            ErrorLevel = GetRawInputData call failed.`nReturn value: %r%`nErrorLevel: %ErrorLevel%`nLine: %A_LineNumber%`nLast Error: %A_LastError%
            Return -1
        }
        
        ;Prep var
        VarSetCapacity(uRawInput, iSize)
        
        ;Get raw data                                                RID_INPUT
        r := DllCall("GetRawInputData", "UInt", InputHandle, "UInt", 0x10000003, "Ptr", &uRawInput, "UInt*", iSize, "UInt", 8 + A_PtrSize * 2)
        If (r = -1) Or ErrorLevel {
            ErrorLevel = GetRawInputData call failed.`nReturn value: %r%`nErrorLevel: %ErrorLevel%`nLine: %A_LineNumber%`nLast Error: %A_LastError%
            Return -1
        } Else If (r <> iSize) {
            ErrorLevel = GetRawInputData did not return the correct size.`nSize returned: %r%`nSize allocated: %iSize%
            Return -1
        }
        
        ;Keep handle reference of current uRawInput
        iLastHandle := InputHandle
        
        ;Retrieve data
        Return NumGet(uRawInput, Flag, AHKHID_NumIsShort(Flag) ? (AHKHID_NumIsSigned(Flag) ? "Short" : "UShort") : (AHKHID_NumIsSigned(Flag) ? "Int" : (Flag = 8 ? "Ptr" : "UInt")))
    }
    
    Return 0
}

AHKHID_GetInputData(InputHandle, ByRef uData) {
    
    ;Get raw data size                                           RID_INPUT
    r := DllCall("GetRawInputData", "UInt", InputHandle, "UInt", 0x10000003, "Ptr", 0, "UInt*", iSize, "UInt", 8 + A_PtrSize * 2)
    If (r = -1) Or ErrorLevel {
        ErrorLevel = GetRawInputData call failed.`nReturn value: %r%`nErrorLevel: %ErrorLevel%`nLine: %A_LineNumber%`nLast Error: %A_LastError%
        Return -1
    }
    
    ;Prep var
    VarSetCapacity(uRawInput, iSize)
    
    ;Get raw data                                                RID_INPUT
    r := DllCall("GetRawInputData", "UInt", InputHandle, "UInt", 0x10000003, "Ptr", &uRawInput, "UInt*", iSize, "UInt", 8 + A_PtrSize * 2)
    If (r = -1) Or ErrorLevel {
        ErrorLevel = GetRawInputData call failed.`nReturn value: %r%`nErrorLevel: %ErrorLevel%`nLine: %A_LineNumber%`nLast Error: %A_LastError%
        Return -1
    } Else If (r <> iSize) {
        ErrorLevel = GetRawInputData did not return the correct size.`nSize returned: %r%`nSize allocated: %iSize%
        Return -1
    }
    
    ;Get the size of each HID input and the number of them
    iSize   := NumGet(uRawInput, 8 + A_PtrSize * 2 + 0, "UInt") ;ID_HID_SIZE
    iCount  := NumGet(uRawInput, 8 + A_PtrSize * 2 + 4, "UInt") ;ID_HID_COUNT
    
    ;Allocate memory
    VarSetCapacity(uData, iSize * iCount)
    
    ;Copy bytes
    DllCall("RtlMoveMemory", UInt, &uData, UInt, &uRawInput + 8 + A_PtrSize * 2 + 8, UInt, iSize * iCount)
    
    Return (iSize * iCount)
}

;Internal use only
AHKHID_NumIsShort(ByRef Flag) {
    If (Flag & 0x0100) {
        Flag ^= 0x0100    ;Remove it
        Return True
    } Return False
}

;Internal use only
AHKHID_NumIsSigned(ByRef Flag) {
    If (Flag & 0x1000) {
        Flag ^= 0x1000    ;Remove it
        Return True
    } Return False
}
