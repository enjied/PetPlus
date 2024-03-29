#Include globalVar.ahk

InstallKeybdHook()
ProcessSetPriority "High"
SetStoreCapslockMode false
;Suspend 1 ; 禁用或启用所有的或选择的热键和热字串.
SetWorkingDir A_ScriptDir
CoordMode "Mouse", "Screen"

; 判断是否启用Space热键模式
if (_Space)
{
    #Include mode\spaceMode.ahk
}
; 判断是否启用CpasLock热键模式
if (_CapsLock) {

    #Include mode\capsLockMode.ahk
}
; 判断是否启用引号命令模式
if (_Command){
    #Include mode\commandMode.ahk
}

; 添加热键开关
#SuspendExempt true
#Esc::
{
    Suspend(-1)
    if A_IsSuspended {
        ToolTip("禁用功能")
        ; Menu,Tray,Check,%Tray_Disabled%
    } else {
        ToolTip("启用功能")
        ; Menu,Tray,UnCheck,%Tray_Disabled%
    }
    SetTimer(() => ToolTip(), -1000)
    Return
}

; 启动欢迎界面
if (_Welcome) {
    #Include gui\welcome.ahk
    Welcome()
}

;================= END SCRIPT ===================
