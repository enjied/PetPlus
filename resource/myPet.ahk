#NoTrayIcon ; 禁用系统托盘图标
#SingleInstance Ignore ; 跳过对话框并让旧实例继续运行. 换句话说, 试图启动已经运行的脚本会被忽略.
; #MaxHotkeysPerInterval 1000
; #Persistent
InstallKeybdHook()
; SendMode "Input" ; default Input
; SetKeyDelay -1 ; -1 is default
; SetBatchLines -1 ; -1 is default
; ListLines Off
ProcessSetPriority "High"
SetStoreCapslockMode false
;Suspend 1 ; 禁用或启用所有的或选择的热键和热字串.
SetWorkingDir A_ScriptDir
CoordMode "Mouse", "Screen"
global SpaceFire := 0
global SpaceMode := 0
global SpaceCure := 0
global CapsLockState := 0
global RewardState := 0
/**配置文件路径 */
global ConfigPath := A_ScriptDir "\Pet.ini"
global Tray_Disabled := "临时禁用 | Win+Esc"
global Tray_Visible := "隐藏图标 | Win+CapsLock"
global Tray_Exit := "退出软件 | CapsLock+A"
global Tray_Menu := "显示菜单 | CapsLock+G"
global Tray_StartUp := "开机启动 | CapsLock+\"
global Tray_Restart := "重启软件 | CapsLock+R"
global Tray_Reward := "扫码打赏 | CapsLock+Z"
global Tray_Position := "所在位置 | CapsLock+V"
global Tray_Profile := "配置文件 | CapsLock+X"
global _PetLock := 0
global _TrayVisible := 1
global _StartUp := 0
global _Welcome := 1
global _Stranger := 1
global _CapsLock := 1
global Tray_CapsLock := "方法模式(长按CapsLock触发)"
global _Space := 1
global Tray_Space := "热键模式(长按Space触发)"
global _Command := 1
global Tray_Command := "命令模式(长按引号触发)"
FileInstall "Pet.ini", ConfigPath, 0
if (A_IsAdmin) {
    global ListSpace1 := ["_a", "_b", "_c", "_d", "_e", "_f", "_g", "_h", "_i", "_j", "_k", "_l", "_m", "_n", "_o", "_p", "_q", "_r", "_s", "_t", "_u", "_v", "_w", "_x", "_y", "_z", "_1", "_2", "_3", "_4", "_5", "_6", "_7", "_8", "_9", "_0"]
    global ListSpace2 := ["_@fyh", "_Tab", "_@jh", "_@dyh", "_@dh", "_@juh", "_@xg", "_@fh", "_@yh", "_@zzkh", "_@yzkh", "_@fxg", "_Enter", "_Backspace", "_Delete", "_Insert", "_Home", "_End", "_PgUp", "_PgDn", "_Up", "_Down", "_Left", "_Right", "_Esc", "_F1", "_F2", "_F3", "_F4", "_F5", "_F6", "_F7", "_F8", "_F9", "_F10", "_F11", "_F12"]
    global ListCapsLock1 := ["$a", "$b", "$c", "$d", "$e", "$f", "$g", "$h", "$i", "$j", "$k", "$l", "$m", "$n", "$o", "$p", "$q", "$r", "$s", "$t", "$u", "$v", "$w", "$x", "$y", "$z", "$1", "$2", "$3", "$4", "$5", "$6", "$7", "$8", "$9", "$0"]
    global ListCapsLock2 := ["$@fyh", "$Tab", "$@jh", "$@dyh", "$@dh", "$@juh", "$@xg", "$@fh", "$@yh", "$@zzkh", "$@yzkh", "$@fxg", "$Enter", "$Backspace", "$Delete", "$Insert", "$Home", "$End", "$PgUp", "$PgDn", "$Up", "$Down", "$Left", "$Right", "$Esc", "$F1", "$F2", "$F3", "$F4", "$F5", "$F6", "$F7", "$F8", "$F9", "$F10", "$F11", "$F12"]
    global ListKey1 := ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z", "1", "2", "3", "4", "5", "6", "7", "8", "9", "0"]
    global ListKey2 := ["_fyh", "Tab", "-", "_dyh", ",", ".", "/", "_;", "_yh", "_[", "_]", "\", "Enter", "Backspace", "Delete", "Insert", "Home", "End", "PgUp", "PgDn", "Up", "Down", "Left", "Right", "Esc", "F1", "F2", "F3", "F4", "F5", "F6", "F7", "F8", "F9", "F10", "F11", "F12"]

    ;
    _TrayVisible := PetRead("TrayVisible")
    _Welcome := PetRead("Welcome")
    _Stranger := PetRead("Stranger")
    _StartUp := PetRead("StartUp")
    _CapsLock := PetRead("CapsLock")
    _Space := PetRead("Space")
    _Command := PetRead("Command")
    global ArraySpace1 := []
    global ArraySpace2 := []
    global ArrayCapsLock1 := []
    global ArrayCapsLock2 := []

    for index, element in ListSpace1
    {
        element := SpaceRead(ListKey1[index])
        ArraySpace1.insert(ListKey1[index] "=" %element%)
    }

    for index, element in ListSpace2
    {
        element := SpaceRead(ListKey2[index])
        ArraySpace2.insert(ListKey2[index] "=" %element%)
    }

    for index, element in ListCapsLock1
    {
        element := CapsLockRead(ListKey1[index])
        ArrayCapsLock1.insert(ListKey1[index] "=" %element%)
    }
    for index, element in ListCapsLock2
    {
        element := CapsLockRead(ListKey2[index])
        ArrayCapsLock2.insert(ListKey2[index] "=" %element%)
    }
    /**
     * 读写ini中space setction中的配置
     * @param value 要读取的配置
     */
    SpaceRead(value) {
        return IniRead(%ConfigPath%, "Space", %value%)
    }

    /**
     * 读写ini中space setction中的配置
     * @param value 要读取的配置
     */
    CapsLockRead(value) {
        return IniRead(%ConfigPath%, "CapsLock", %value%)
    }

    /**
     * 读写ini中Pet setction中的配置
     * @param value 要读取的配置
     */
    PetRead(value) {
        return IniRead(%ConfigPath%, "Pet", %value%)
    }

    /**
     * 读写ini中Pet setction中的配置
     * @param key 要写入的配置
     * @param value 要写入的值
     */
    PetWrite(key, value) {
        IniWrite %value%, %ConfigPath%, "Pet", %key%
    }

    ; 判断是否第一次在生产活动中运行
    if (A_IsCompiled = 1 and _Stranger != 0) {
        Run "notepad %A_ScriptDir%\Pet.ini"
        PetWrite("Stranger", "0")
    }
    Welcome()
    ; TrayMenu()
    ; Suspend, Off
    ; GetColor() {
    ;     MouseGetPos x, y
    ;     PixelGetColor rgb, x, y, RGB
    ;     stringreplace, out, rgb, 0x, , All
    ;     if (A_PriorHotkey = A_ThisLabel and A_TimeSincePriorHotkey < 400) {
    ;         Clipboard = %out%
    ;         ToolTip %out% 已复制
    ;     }
    ;     SetTimer, RemoveToolTip, 1000
    ; }
    Run(data) {
        position := InStr(data, "{Pet}")
        if (position > 0) {
            value :=
                (
                    "%Clipboard%"
                )
            data := StrReplace(data, "{Pet}", value)
        }
        Run %data%
    }
    CopyRun(data) {
        ClipSaved := ClipboardAll
        Send("{Ctrl down}c{Ctrl up}")
        Sleep(100)
        Run(data)
        Sleep(100)
        Clipboard := ClipSaved
        ClipSaved := ""
    }
    ReplaceText(data) {
        ClipSaved := ClipboardAll
        Send("{Ctrl down}c{Ctrl up}")
        Sleep(100)
        data := StrReplace(data, "{Pet}", Clipboard)
        Clipboard := data
        Send("{Ctrl down}v{Ctrl up}")
        Sleep(100)
        Clipboard := ClipSaved
        ClipSaved := ""
    }
    MouseUp(data) {
        if (GetKeyState("J", "P") = 1) {
            MouseMove(-%data%, -%data%, 0, 'R')
        } else if (GetKeyState("L", "P") = 1) {
            MouseMove(%data%, -%data%, 0, 'R')
        } else {
            MouseMove(0, -%data%, 0, 'R')
        }
    }
    MouseDown(data) {
        if (GetKeyState("J", "P") = 1) {
            MouseMove(-%data%, %data%, 0, 'R')
        } else if (GetKeyState("L", "P") = 1) {
            MouseMove(%data%, %data%, 0, 'R')
        } else {
            MouseMove(0, %data%, 0, 'R')
        }
    }
    MouseLeft(data) {
        if (GetKeyState("I", "P") = 1) {
            MouseMove(-%data%, -%data%, 0, 'R')
        } else if (GetKeyState("K", "P") = 1) {
            MouseMove(-%data%, %data%, 0, 'R')
        } else {
            MouseMove(-%data%, 0, 0, 'R')
        }
    }
    MouseRight(data) {
        if (GetKeyState("I", "P") = 1) {
            MouseMove(%data%, -%data%, 0, 'R')
        } else if (GetKeyState("K", "P") = 1) {
            MouseMove(%data%, %data%, 0, 'R')
        } else {
            MouseMove(%data%, 0, 0, 'R')
        }
    }
    SendInput(data) {
        Send "{Blind}%data%"
    }
    WheelUp() {
        MouseClick(WheelUp)
    }
    WheelDown() {
        MouseClick(WheelDown)
    }
    LeftClick() {
        MouseClick("Left", , , , , 'D')
        KeyWait("LeftClick")
        MouseClick("Left", , , , , 'U')
    }
    RightClick() {
        MouseClick("Right", , , , , 'D')
        KeyWait("RightClick")
        MouseClick("Right", , , , , 'U')
    }

    ; /**
    ;  * 窗口置顶功能
    ;  */
    ; TopMost() {
    ;     WinGet, ExStyle, ExStyle, A
    ;     if (ExStyle & 0x8) {
    ;         WinSet AlwaysOnTop, Off, A
    ;         ToolTip, 取消置顶
    ;     } else {
    ;         WinSet AlwaysOnTop, On, A
    ;         ToolTip, 设置置顶
    ;     }
    ;     SetTimer, RemoveToolTip, 1000
    ; }
    ; SetTransparent(data) {
    ;     WinGet, _Transparent, Transparent, A
    ;     if (_Transparent = "") {
    ;         _Transparent := 255
    ;     }
    ;     ToolTip, %_Transparent% / 255
    ;     if (data > 0) {
    ;         if (_Transparent + 5 <= 255) {
    ;             WinSet, Transparent, %_Transparent + 5, A
    ;         }
    ;     } Else {
    ;         if (_Transparent - 5 >= 0) {
    ;             WinSet, Transparent, %_Transparent - 5, A
    ;         }
    ;     }
    ;     SetTimer, RemoveToolTip, 1000
    ; }
    RunWaitOne(command) {
        shell := ComObject("WScript.Shell")
        exec := shell.Exec("ComSpec  /C  command")
        return exec.StdOut.ReadAll()
    }
    global ClickState := 0
    MouseClicks(data) {
        if (ClickState) {
            SetTimer(MouseClickTimer, 0)
            ClickState := 0
            ToolTip
        } Else {
            SetTimer(MouseClickTimer, %data%)
            ClickState := 1
        }
    }
    ; KeepSpace() {
    ;     if (SpaceMode) {
    ;         SpaceMode := 0
    ;         ToolTip, 关闭Space增强模式
    ;     } else {
    ;         SpaceMode := 1
    ;         ToolTip, 开启Space增强模式
    ;     }
    ;     SetTimer, RemoveToolTip, 1000
    ; }

    PetLock() {
        KeyWait("CapsLock")
        if (_PetLock) {
            ToolTip("禁用锁")
            BlockInput("Off")
            _PetLock := 0
        } Else {
            ToolTip("启用锁")
            BlockInput("On")
            _PetLock := 1
        }
        SetTimer(RemoveToolTip, 1000)
    }

    ; GetClassName() {
    ;     WinGetClass, out, A
    ;     ToolTip, %out% 双击复制
    ;     if (A_PriorHotkey = A_ThisLabel and A_TimeSincePriorHotkey < 400) {
    ;         Clipboard = %out%
    ;         ToolTip %out% 已复制
    ;     }
    ;     SetTimer, RemoveToolTip, 1000
    ; }

    ; GetProcessPath() {
    ;     WinGet, out, ProcessPath, A
    ;     ToolTip, %out% 双击定位
    ;     if (A_PriorHotkey = A_ThisLabel and A_TimeSincePriorHotkey < 400) {
    ;         ToolTip, 定位中
    ;         Run explorer / select`, %out%
    ;     }
    ;     SetTimer, RemoveToolTip, 1000
    ; }

    ; /**
    ;  * 开机自启
    ;  */
    ; StartUp() {
    ;     if (_StartUp = 1) {
    ;         Run schtasks / delete / tn Pet / f, , Hide
    ;         ToolTip, 取消开机自启
    ;         Menu, Tray, UnCheck, %Tray_StartUp%
    ;         PetWrite("StartUp", "0")
    ;     } else {
    ;         Run schtasks / create / sc onlogon / tn Pet / tr %A_ScriptFullPath% / rl highest / f, , Hide
    ;         ToolTip, 设置开机自启
    ;         Menu, Tray, Check, %Tray_StartUp%
    ;         PetWrite("StartUp", "1")
    ;     }
    ;     PetRead("_StartUp", "StartUp")
    ;     SetTimer, RemoveToolTip, 1000
    ; }


    ExitPet(data) {
        ExitApp(%data%)
    }
    ReloadPet() {
        try
        {
            if A_IsCompiled
                Run '*RunAs %A_ScriptFullPath% / restart'
            else
                Run '*RunAs %A_AhkPath% / restart %A_ScriptFullPath%'
        }
        ExitApp
    }

    ; HideTray() {
    ;     if A_IconHidden {
    ;         Menu, Tray, Icon
    ;         PetWrite("TrayVisible", "1")
    ;         ToolTip, 显示托盘图标
    ;         Menu, Tray, UnCheck, %Tray_Visible%
    ;     } else {
    ;         Menu, Tray, NoIcon
    ;         PetWrite("TrayVisible", "0")
    ;         ToolTip, 隐藏托盘图标
    ;         Menu, Tray, Check, %Tray_Visible%
    ;     }
    ;     SetTimer, RemoveToolTip, 1000
    ; }

    ; ShowMenu() {
    ;     Menu, Tray, Show
    ; }
    ; Suspend(data) {
    ;         if (data) {
    ;                 Suspend
    ;         }
    ;         if A_IsSuspended {
    ;                 ToolTip, 禁用功能
    ;                 Menu, Tray, Check, %Tray_Disabled%
    ;         } else {
    ;                 ToolTip, 启用功能
    ;                 Menu, Tray, UnCheck, %Tray_Disabled%
    ;         }
    ;         SetTimer, RemoveToolTip, 1000
    ; }

    SpacePower() {
        if (_Space != 0) {
            ; Menu, SubMenu, UnCheck, %Tray_Space%
            _Space := 0
        } Else {
            ; Menu, SubMenu, Check, %Tray_Space%
            _Space := 1
        }
        PetWrite("Space", _Space)
    }

    CapsLockPower() {
        if (_CapsLock != 0) {
            ; Menu, SubMenu, UnCheck, %Tray_CapsLock%
            _CapsLock := 0
        } Else {
            ; Menu, SubMenu, Check, %Tray_CapsLock%
            _CapsLock := 1
        }
        PetWrite("CapsLock", _CapsLock)
    }
    CommandPower() {
        if (_Command != 0) {
            ; Menu, SubMenu, UnCheck, %Tray_Command%
            _Command := 0
        } Else {
            ; Menu, SubMenu, Check, %Tray_Command%
            _Command := 1
        }
        PetWrite("Command", _Command)
    }

    /**
     * 自定义托盘菜单
     */
    ; TrayMenu() {
    ;     trayMenu := Menu()
    ;     trayMenu.Delete()
    ;     ; Menu, Tray, NoStandard
    ;     ; Menu, Tray, Click, 1
    ;     Menu, Tray, Tip, Pet
    ;     Menu, Tray, Add, Pet, ShowMenu
    ;     Menu, Tray, Disable, Pet
    ;     Menu, Tray, Add
    ;     Menu, SubMenu, Add, %Tray_Space%, SpacePower
    ;     Menu, SubMenu, Add, %Tray_CapsLock%, CapsLockPower
    ;     Menu, SubMenu, Add, %Tray_Command%, CommandPower
    ;     Menu, Tray, Add, 功能启用, : SubMenu
    ;     MethodMenu("Space配置主要预览", ArraySpace1, "ShowSpace1")
    ;     MethodMenu("Space配置拓展预览", ArraySpace2, "ShowSpace2")
    ;     MethodMenu("CapsLock配置主要预览", ArrayCapsLock1, "ShowCapsLock1")
    ;     MethodMenu("CapsLock配置拓展预览", ArrayCapsLock2, "ShowCapsLock2")
    ;     Menu, Tray, Add
    ;     Menu, Tray, Add, %Tray_Disabled%, Suspend
    ;     Menu, Tray, Add, %Tray_Visible%, HideTray
    ;     Menu, Tray, Add
    ;     Menu, Tray, Add, %Tray_Exit%, ExitPet
    ;     Menu, Tray, Add, %Tray_Menu%, ShowMenu
    ;     Menu, Tray, Add, %Tray_StartUp%, StartUp
    ;     Menu, Tray, Add
    ;     Menu, Tray, Add, %Tray_Restart%, ReloadPet
    ;     Menu, Tray, Add, %Tray_Reward%, Reward
    ;     Menu, Tray, Add
    ;     Menu, Tray, Add, %Tray_Position%, Position
    ;     Menu, Tray, Add, %Tray_Profile%, Profile
    ;     Menu, Tray, Default, Pet
    ;     if (_TrayVisible != 0) {
    ;         Menu, Tray, Icon
    ;         Menu, Tray, UnCheck, %Tray_Visible%
    ;     } else {
    ;         Menu, Tray, Check, %Tray_Visible%
    ;     }
    ;     if (_StartUp = 1) {
    ;         Menu, Tray, Check, %Tray_StartUp%
    ;     }
    ;     if (_CapsLock != 0) {
    ;         Menu, SubMenu, Check, %Tray_CapsLock%
    ;     }
    ;     if (_Space != 0) {
    ;         Menu, SubMenu, Check, %Tray_Space%
    ;     }
    ;     if (_Command != 0) {
    ;         Menu, SubMenu, Check, %Tray_Command%
    ;     }
    ; }
    ; MethodMenu(name, Array, SubMenu) {
    ;     for index, element in Array
    ;     {
    ;         Menu, %SubMenu%, Add, %element%, ShowMenu
    ;     }
    ;     Menu, Tray, Add, %name%, : %SubMenu%
    ; }
    ; Welcome() {
    ;     if (_Welcome != 0) {
    ;         Gui, welcome: +LastFound + AlwaysOnTop - Caption + ToolWindow
    ;         Gui, welcome: Color, EB6796
    ;         Gui, welcome: Font, cwhite s60 wbold q5, Segoe UI
    ;         Gui, welcome: Add, Text, , Pet
    ;         Gui, welcome: Show, AutoSize Center NoActivate
    ;         Sleep, 800
    ;         Gui, welcome: Destroy
    ;     }
    ; }

    /**
     * 重写 Welcome 方法
     * 开屏界面
     */
    Welcome() {
        if (_Welcome != 0) {
            welcomeGui := Gui("+LastFound + AlwaysOnTop - Caption + ToolWindow")
            welcomeGui.BackColor := "EB6796"
            welcomeGui.SetFont("cwhite s60 wbold q5", "Segoe UI")
            welcomeGui.Add("Text", , "Pet")
            welcomeGui.Show("AutoSize Center NoActivate")
            Sleep(800)
            welcomeGui.Destroy()
        }
    }

    ; Reward() {
    ;     if (RewardState) {
    ;         Gui, PowerSpaceLayout: Destroy
    ;         RewardState := 0
    ;         Menu, Tray, UnCheck, %Tray_Reward%
    ;     } else {
    ;         FileInstall, Pet\Reward.png, %A_Temp%\Reward.png, 1
    ;         Gui, PowerSpaceLayout: Add, pic, w700 h350, %A_Temp%\Reward.png
    ;         Gui, PowerSpaceLayout: Color, FFFFFF
    ;         Gui, PowerSpaceLayout: +LastFound + AlwaysOnTop - Caption + ToolWindow + DPIScale
    ;         Gui, PowerSpaceLayout: Show, AutoSize Center NoActivate
    ;         Gui, PowerSpaceLayout: +LastFound
    ;         RewardState := 1
    ;         Menu, Tray, Check, %Tray_Reward%
    ;     }
    ; }
    Position() {
        Run "%A_ScriptDir%"
    }
    Profile() {
        Run "%A_ScriptDir%\Pet.ini"
    }



    #HotIf _Space = 1 and _PetLock = 0
    Space:: {
        SetTimer("SpaceGuard, 100, 2000")
        SetTimer("SpaceLock, 300, 1000")
        SpaceFire := 1
        SpaceMode := 0
        SpaceCure := 1
        KeyWait("Space")
        SetTimer("SpaceGuard, Delete")
        SetTimer("SpaceLock, Delete")
        if (SpaceFire) {
            Send "{Space}"
        }
        SpaceFire := 0
        SpaceMode := 0
        SpaceCure := 0
        return
    }
    #HotIf
    SpaceGuard() {
        SetTimer(SpaceGuard, 0)
        SpaceCure := 0
        SpaceMode := 1
        return
    }
    SpaceLock() {
        SetTimer("SpaceLock", 0)
        SpaceFire := 0
        return
    }
    #HotIf SpaceMode
    *a:: Send "{Blind}%_a%"
    *b:: Send "{Blind}%_b%"
    *c:: Send "{Blind}%_c%"
    *d:: Send "{Blind}%_d%"
    *e:: Send "{Blind}%_e%"
    *f:: Send "{Blind}%_f%"
    *g:: Send "{Blind}%_g%"
    *h:: Send "{Blind}%_h%"
    *i:: Send "{Blind}%_i%"
    *j:: Send "{Blind}%_j%"
    *k:: Send "{Blind}%_k%"
    *l:: Send "{Blind}%_l%"
    *m:: Send "{Blind}%_m%"
    *n:: Send "{Blind}%_n%"
    *o:: Send "{Blind}%_o%"
    *p:: Send "{Blind}%_p%"
    *q:: Send "{Blind}%_q%"
    *r:: Send "{Blind}%_r%"
    *s:: Send "{Blind}%_s%"
    *t:: Send "{Blind}%_t%"
    *u:: Send "{Blind}%_u%"
    *v:: Send "{Blind}%_v%"
    *w:: Send "{Blind}%_w%"
    *x:: Send "{Blind}%_x%"
    *y:: Send "{Blind}%_y%"
    *z:: Send "{Blind}%_z%"
    *`:: Send "{Blind}%_@fyh%"
    *Tab:: Send "{Blind}%_Tab%"
    *1:: Send "{Blind}%_1%"
    *2:: Send "{Blind}%_2%"
    *3:: Send "{Blind}%_3%"
    *4:: Send "{Blind}%_4%"
    *5:: Send "{Blind}%_5%"
    *6:: Send "{Blind}%_6%"
    *7:: Send "{Blind}%_7%"
    *8:: Send "{Blind}%_8%"
    *9:: Send "{Blind}%_9%"
    *0:: Send "{Blind}%_0%"
    *-:: Send "{Blind}%_@jh%"
    *=:: Send "{Blind}%_@dyh%"
    *,:: Send "{Blind}%_@dh%"
    *.:: Send "{Blind}%_@juh%"
    */:: Send "{Blind}%_@xg%"
    *`;:: Send "{Blind}%_@fh%"
    *':: Send "{Blind}%_@yh%"
    *[:: Send "{Blind}%_@zzkh%"
    *]:: Send "{Blind}%_@yzkh%"
    *\:: Send "{Blind}%_@fxg%"
    *Enter:: Send "{Blind}%_Enter%"
    *Backspace:: Send "{Blind}%_Backspace%"
    *Delete:: Send "{Blind}%_Delete%"
    *Insert:: Send "{Blind}%_Insert%"
    *Home:: Send "{Blind}%_Home%"
    *End:: Send "{Blind}%_End%"
    *PgUp:: Send "{Blind}%_PgUp%"
    *PgDn:: Send "{Blind}%_PgDn%"
    *Up:: Send "{Blind}%_Up%"
    *Down:: Send "{Blind}%_Down%"
    *Left:: Send "{Blind}%_Left%"
    *Right:: Send "{Blind}%_Right%"
    Esc:: Send "{Blind}%_Esc%"
    F1:: Send "{Blind}%_F1%"
    F2:: Send "{Blind}%_F2%"
    F3:: Send "{Blind}%_F3%"
    F4:: Send "{Blind}%_F4%"
    F5:: Send "{Blind}%_F5%"
    F6:: Send "{Blind}%_F6%"
    F7:: Send "{Blind}%_F7%"
    F8:: Send "{Blind}%_F8%"
    F9:: Send "{Blind}%_F9%"
    F10:: Send "{Blind}%_F10%"
    F11:: Send "{Blind}%_F11%"
    F12:: Send "{Blind}%_F12%"
    #HotIf
    #HotIf SpaceCure
    a::
    b::
    c::
    d::
    e::
    f::
    g::
    h::
    i::
    j::
    k::
    l::
    m::
    n::
    o::
    p::
    q::
    r::
    s::
    t::
    u::
    v::
    w::
    x::
    y::
    z::
    1::
    2::
    3::
    4::
    5::
    6::
    7::
    8::
    9::
    0::
    ,::
    .::
    '::
    [::
    ]::
    /::
    \::
    -::
    =::
    Enter::
    Backspace::
    Delete::
    Insert::
    Home::
    End::
    PgUp::
    PgDn::
    Up::
    Down::
    Left::
    Right::
    {
        SetTimer(SpaceGuard, 0)
        SpaceFire := 0
        Send "{Space} {%A_ThisLabel%}"
        return
    }
    #HotIf
    #HotIf _CapsLock != 0
    $CapsLock::
    {
        CapsLockState := 1
        KeyWait("CapsLock")
        CapsLockState := 0
        Return
    }
    #HotIf
    Method(data) {
        position := InStr(data, "$")
        name := data
        if (position > 0) {
            name := SubStr(data, 1, position - 1)
            value := SubStr(data, position + 1)
        }
        if (name = "StartUp") {
            ; StartUp()
            Return
        }
        %name%(value)
        Return
    }
    ; try {
    ;     %name%(value)
    ; } catch {
    ;     Tooltip("Error: %data%")
    ; }
    SetTimer(RemoveToolTip, 1000)
    #HotIf CapsLockState
    ; MsgBox("$a")
    a:: Method("$a")
    b:: Method("$b")
    c:: Method("$c")
    d:: Method("$d")
    e:: Method("$e")
    f:: Method("$f")
    g:: Method("$g")
    h:: Method("$h")
    i:: Method("$i")
    j:: Method("$j")
    k:: Method("$k")
    l:: Method("$l")
    m:: Method("$m")
    n:: Method("$n")
    o:: Method("$o")
    p:: Method("$p")
    q:: Method("$q")
    r:: Method("$r")
    s:: Method("$s")
    t:: Method("$t")
    u:: Method("$u")
    v:: Method("$v")
    w:: Method("$w")
    x:: Method("$x")
    y:: Method("$y")
    z:: Method("$z")
    `:: Method("$@fyh")
    Tab:: Method("$Tab")
    1:: Method("$1")
    2:: Method("$2")
    3:: Method("$3")
    4:: Method("$4")
    5:: Method("$5")
    6:: Method("$6")
    7:: Method("$7")
    8:: Method("$8")
    9:: Method("$9")
    0:: Method("$0")
    -:: Method("$@jh")
    =:: Method("$@dyh")
    ,:: Method("$@dh")
    .:: Method("$@juh")
    /:: Method("$@xg")
    `;:: Method("$@fh")
    ':: Method("$@yh")
    [:: Method("$@zzkh")
    ]:: Method("$@yzkh")
    \:: Method("$@fxg")
    Enter:: Method("$Enter")
    Backspace:: Method("$Backspace")
    Delete:: Method("$Delete")
    Insert:: Method("$Insert")
    Home:: Method("$Home")
    End:: Method("$End")
    PgUp:: Method("$PgUp")
    PgDn:: Method("$PgDn")
    Up:: Method("$Up")
    Down:: Method("$Down")
    Left:: Method("$Left")
    Right:: Method("$Right")
    Esc:: Method("$Esc")
    F1:: Method("$F1")
    F2:: Method("$F2")
    F3:: Method("$F3")
    F4:: Method("$F4")
    F5:: Method("$F5")
    F6:: Method("$F6")
    F7:: Method("$F7")
    F8:: Method("$F8")
    F9:: Method("$F9")
    F10:: Method("$F10")
    F11:: Method("$F11")
    F12:: Method("$F12")
    Return
    #HotIf
} else {
    ReloadPet()
}
RemoveToolTip() {
    SetTimer(RemoveToolTip, 0)
    ToolTip
    Return
}
MouseClickTimer() {
    MouseClick("Left")
    ToolTip("鼠标点击中...")
    Return
}

#Esc:: {
    Suspend
    Suspend(0)
    Return
}

