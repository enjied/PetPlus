; 将data中的{pet}替换为粘贴板的内容并运行
Open(data) {
    position := InStr(data, "{Pet}")
    if (position > 0) {
        value := A_Clipboard

        data := StrReplace(data, "{Pet}", value)
    }
    Run data
}

CopyOpen(data) {
    Send "^c"
    Sleep 100
    Open(data)

}

TopMost() {

    ; 参数A指定活动窗口
    ExStyle := WinGetExStyle('A')
    WinSetAlwaysOnTop -1, 'A'
    ; 0x8 为 WS_EX_TOPMOST
    if (ExStyle & 0x8) {
        ToolTip("取消置顶")
    } else {
        ToolTip("窗口置顶")
    }
    SetTimer(ToolTip, -1000)
}

PetLock() {
    MsgBox("lock")
}

SetTransparent(data) {
    MsgBox(data)
}

MouseClick(data) {
    MsgBox(data)
}


Config() {
    Run A_ScriptDir "\petconfig.ini"
}

OpenFilePath() {
    Run A_ScriptDir
}

/**
 * 切换托盘图标的显示并显示提示
 */
HideTray() {
    if A_IconHidden {
        A_IconHidden := 0
        IniWrite(1, ConfigPath, "Pet", "TrayVisible")
        ToolTip("显示托盘图标")
        ; Menu,Tray,UnCheck,%Tray_Visible%
    } else {
        A_IconHidden := 1
        IniWrite(0, ConfigPath, "Pet", "TrayVisible")
        ToolTip("隐藏托盘图标")
        ; Menu,Tray,Check,%Tray_Visible%
    }
    SetTimer(ToolTip, -1000)
}

/**
 * 以管理员身份重启应用
 */
ReloadPet() {
    try
    {
        if A_IsCompiled
            Run '"' A_ScriptFullPath '" /restart'
        else
            Run "`"" A_AhkPath "`"" " /restart " "`"" A_ScriptFullPath "`""
    }
    catch as e
    {
        MsgBox e.Message
        Exit
    }
    ExitApp
}

ExitPet(data) {
    ToolTip("关闭脚本")
    Sleep(1000)
    ToolTip
    ExitApp(data)
}


ShowMenu() {
    myMenu := A_TrayMenu
    ; myMenu.AddStandard()
    myMenu.show()
}