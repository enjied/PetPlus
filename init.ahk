#Include globalVar.ahk
#Include tool.ahk
#Include welcome.ahk

InstallKeybdHook()
ProcessSetPriority "High"
SetStoreCapslockMode false
;Suspend 1 ; 禁用或启用所有的或选择的热键和热字串.
SetWorkingDir A_ScriptDir
CoordMode "Mouse", "Screen"
; FileInstall "Pet.ini", ConfigPath, 0

; 判断是否第一次在生产活动中运行
if (A_IsCompiled = 1 and _Stranger != 0) {
    Run "notepad %A_ScriptDir%\Pet.ini"
    PetWrite("Stranger", "0", ConfigPath)
}

; 启动界面界面
Welcome()

#Include spaceWatch.ahk
#Include capsLockWatch.ahk
#Include commandMode.ahk

/**
 * 隐藏托盘图标
 * @param ThisHotkey win + CapsLock
 */
#CapsLock:: {
    HideTray()
    Return

    HideTray() {
        if A_IconHidden {
            A_IconHidden := 0
            PetWrite("TrayVisible", 1, ConfigPath)
            ToolTip("显示托盘图标")
            ; Menu,Tray,UnCheck,%Tray_Visible%
        } else {
            A_IconHidden := 1
            PetWrite("TrayVisible", 0, ConfigPath)
            ToolTip("隐藏托盘图标")
            ; Menu,Tray,Check,%Tray_Visible%
        }
        SetTimer(() => ToolTip(), -1000)
    }
}

#SuspendExempt true
#Esc::
{
    toggleSuspend(1)
    Return
}

/**
 * 以管理员身份重启应用
 */
ReloadAsAdmin() {
    if !A_IsAdmin {
        try
        {
            if A_IsCompiled
                Run '*RunAs "' A_ScriptFullPath '" /restart'
            else
                Run "*RunAs " "`"" A_AhkPath "`"" " /restart " "`"" A_ScriptFullPath "`""
        }
        ExitApp
    }
    MsgBox("已经以管理员身份运行")
}

toggleSuspend(data) {
    ; 反转所有热键启用状态
    Suspend(-1)
    if A_IsSuspended {
        ToolTip("禁用功能")
        ; Menu,Tray,Check,%Tray_Disabled%
    } else {
        ToolTip("启用功能")
        ; Menu,Tray,UnCheck,%Tray_Disabled%
    }
    SetTimer(() => ToolTip(), -1000)
}

SpacePower() {
    global
    if (_Space != 0) {
        ; Menu,SubMenu,UnCheck,%Tray_Space%
        _Space := 0
    } Else {
        ; Menu,SubMenu,Check,%Tray_Space%
        _Space := 1
    }
    ; PetWrite("Space",_Space, ConfigPath)
}


CapsLockPower() {
    if (_CapsLock != 0) {
        ; Menu,SubMenu,UnCheck,%Tray_CapsLock%
        _CapsLock := 0
    } Else {
        ; Menu,SubMenu,Check,%Tray_CapsLock%
        _CapsLock := 1
    }
    ; PetWrite("CapsLock",_CapsLock, ConfigPath)
}


CommandPower() {
    if (_Command != 0) {
        ; Menu,SubMenu,UnCheck,%Tray_Command%
        _Command := 0
    } Else {
        ; Menu,SubMenu,Check,%Tray_Command%
        _Command := 1
    }
    ; PetWrite("Command",_Command)
}



;================= END SCRIPT ===================
