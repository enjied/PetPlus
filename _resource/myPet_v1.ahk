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
global ListSpace := ["_a", "_b", "_c", "_d", "_e", "_f", "_g", "_h", "_i", "_j", "_k", "_l", "_m", "_n", "_o", "_p", "_q", "_r", "_s", "_t", "_u", "_v", "_w", "_x", "_y", "_z", "_1", "_2", "_3", "_4", "_5", "_6", "_7", "_8", "_9", "_0", "_@fyh", "_Tab", "_@jh", "_@dyh", "_@dh", "_@juh", "_@xg", "_@fh", "_@yh", "_@zzkh", "_@yzkh", "_@fxg", "_Enter", "_Backspace", "_Delete", "_Insert", "_Home", "_End", "_PgUp", "_PgDn", "_Up", "_Down", "_Left", "_Right", "_Esc", "_F1", "_F2", "_F3", "_F4", "_F5", "_F6", "_F7", "_F8", "_F9", "_F10", "_F11", "_F12"]
global ListCapsLock := ["$a", "$b", "$c", "$d", "$e", "$f", "$g", "$h", "$i", "$j", "$k", "$l", "$m", "$n", "$o", "$p", "$q", "$r", "$s", "$t", "$u", "$v", "$w", "$x", "$y", "$z", "$1", "$2", "$3", "$4", "$5", "$6", "$7", "$8", "$9", "$0", "$@fyh", "$Tab", "$@jh", "$@dyh", "$@dh", "$@juh", "$@xg", "$@fh", "$@yh", "$@zzkh", "$@yzkh", "$@fxg", "$Enter", "$Backspace", "$Delete", "$Insert", "$Home", "$End", "$PgUp", "$PgDn", "$Up", "$Down", "$Left", "$Right", "$Esc", "$F1", "$F2", "$F3", "$F4", "$F5", "$F6", "$F7", "$F8", "$F9", "$F10", "$F11", "$F12"]
global ListKeyIni := ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z", "1", "2", "3", "4", "5", "6", "7", "8", "9", "0", "_fyh", "Tab", "-", "_dyh", ",", ".", "/", "_;", "_yh", "_[", "_]", "\", "Enter", "Backspace", "Delete", "Insert", "Home", "End", "PgUp", "PgDn", "Up", "Down", "Left", "Right", "Esc", "F1", "F2", "F3", "F4", "F5", "F6", "F7", "F8", "F9", "F10", "F11", "F12"]

global ListKey := ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z", "1", "2", "3", "4", "5", "6", "7", "8", "9", "0", "``", "Tab", "-", "=", ",", ".", "/", ";", "`'", "[", "]", "\", "Enter", "Backspace", "Delete", "Insert", "Home", "End", "PgUp", "PgDn", "Up", "Down", "Left", "Right", "Esc", "F1", "F2", "F3", "F4", "F5", "F6", "F7", "F8", "F9", "F10", "F11", "F12"]

_TrayVisible := PetRead("TrayVisible")
_Welcome := PetRead("Welcome")
_Stranger := PetRead("Stranger")
_StartUp := PetRead("StartUp")
_CapsLock := PetRead("CapsLock")
_Space := PetRead("Space")
_Command := PetRead("Command")
global mapSpace := Map()
global mapCapsLock := Map()


for index, element in ListKey
{
    mapSpace.Set(element, SpaceRead(ListKeyIni[index]))
}


for index, element in ListKey
{
    mapCapsLock.Set(element, SpaceRead(ListKeyIni[index]))
}

/**
 * 读写ini中space setction中的配置
 * @param value 要读取的配置
 */
SpaceRead(value) {
    return IniRead(ConfigPath, "Space", value)
}

/**
 * 读写ini中space setction中的配置
 * @param value 要读取的配置
 */
CapsLockRead(value) {
    return IniRead(ConfigPath, "CapsLock", value)
}

/**
 * 读写ini中Pet setction中的配置
 * @param value 要读取的配置
 */
PetRead(value) {
    return IniRead(ConfigPath, "Pet", value)
}

/**
 * 读写ini中Pet setction中的配置
 * @param key 要写入的配置
 * @param value 要写入的值
 */
PetWrite(key, value) {
    IniWrite value, ConfigPath, "Pet", key
}

; 判断是否第一次在生产活动中运行
if (A_IsCompiled = 1 and _Stranger != 0) {
    Run "notepad %A_ScriptDir%\Pet.ini"
    PetWrite("Stranger", "0")
}

; 启动界面界面
Welcome()

/**
 * 重写 Welcome 方法
 * 绘制启动界面
 */
Welcome() {
    if (_Welcome != 0) {
        welcomeGui := Gui("+LastFound + AlwaysOnTop - Caption + ToolWindow")
        welcomeGui.BackColor := "EB6796"
        welcomeGui.SetFont("cwhite s60 bold q5", "Segoe UI")
        welcomeGui.Add("Text", , "Pet")
        welcomeGui.Show("AutoSize Center NoActivate")
        Sleep(800)
        welcomeGui.Destroy()
    }
}

/**空格监听 */
#HotIf _Space = 1 and _PetLock = 0
Space:: {
    global
    SetTimer(SpaceGuard, 100, 2000)
    SetTimer(SpaceLock, 300, 1000)
    SpaceFire := 1
    SpaceMode := 0
    SpaceCure := 1
    KeyWait("Space")
    SetTimer(SpaceGuard, 0)
    SetTimer(SpaceLock, 0)
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
    global
    SetTimer(SpaceGuard, 0)
    SpaceCure := 0
    SpaceMode := 1
    return
}
SpaceLock() {
    global SpaceFire
    SetTimer(SpaceLock, 0)
    SpaceFire := 0
    return
}
isSpaceMode(*)
{
    if SpaceMode
        return true
    else
        return false
}

HotIf isSpaceMode
; Hotkey("n", cb)
; cb(key){
;     Send("{Blind}" . mapSpace.Get(key))
; }

; for k, v in mapSpace
; {
;     ; MsgBox(k)
;     ; MsgBox(v)
;     Hotkey '*' k, (*) => Send("Blind" v)
; }
Hotkey '*n' , (*) => Send("{Blind}" mapSpace.Get('n'))

; *a:: Send "{Blind}" . mapSpace.Get("a")
; *b:: Send "{Blind}" . mapSpace.Get("b")
; *c:: Send "{Blind}" . mapSpace.Get("c")
; *d:: Send "{Blind}" . mapSpace.Get("d")
; *e:: Send "{Blind}" . mapSpace.Get("e")
; *f:: Send "{Blind}" . mapSpace.Get("f")
; *g:: Send "{Blind}" . mapSpace.Get("g")
; *h:: Send "{Blind}" . mapSpace.Get("h")
; *i:: Send "{Blind}" . mapSpace.Get("i")
; *j:: Send "{Blind}" . mapSpace.Get("j")
; *k:: Send "{Blind}" . mapSpace.Get("k")
; *l:: Send "{Blind}" . mapSpace.Get("l")
; *m:: Send "{Blind}" . mapSpace.Get("m")
; *n:: Send "{Blind}" . mapSpace.Get("n")
; *o:: Send "{Blind}" . mapSpace.Get("o")
; *p:: Send "{Blind}" . mapSpace.Get("p")
; *q:: Send "{Blind}" . mapSpace.Get("q")
; *r:: Send "{Blind}" . mapSpace.Get("r")
; *s:: Send "{Blind}" . mapSpace.Get("s")
; *t:: Send "{Blind}" . mapSpace.Get("t")
; *u:: Send "{Blind}" . mapSpace.Get("u")
; *v:: Send "{Blind}" . mapSpace.Get("v")
; *w:: Send "{Blind}" . mapSpace.Get("w")
; *x:: Send "{Blind}" . mapSpace.Get("x")
; *y:: Send "{Blind}" . mapSpace.Get("y")
; *z:: Send "{Blind}" . mapSpace.Get("z")
; *`:: Send "{Blind}" . mapSpace.Get("``")
; *Tab:: Send "{Blind}" . mapSpace.Get("Tab")
; *1:: Send "{Blind}" . mapSpace.Get("1")
; *2:: Send "{Blind}" . mapSpace.Get("2")
; *3:: Send "{Blind}" . mapSpace.Get("3")
; *4:: Send "{Blind}" . mapSpace.Get("4")
; *5:: Send "{Blind}" . mapSpace.Get("5")
; *6:: Send "{Blind}" . mapSpace.Get("6")
; *7:: Send "{Blind}" . mapSpace.Get("7")
; *8:: Send "{Blind}" . mapSpace.Get("8")
; *9:: Send "{Blind}" . mapSpace.Get("9")
; *0:: Send "{Blind}" . mapSpace.Get("0")
; *-:: Send "{Blind}" . mapSpace.Get("-")
; *=:: Send "{Blind}" . mapSpace.Get("=")
; *,:: Send "{Blind}" . mapSpace.Get(",")
; *.:: Send "{Blind}" . mapSpace.Get(".")
; */:: Send "{Blind}" . mapSpace.Get("/")
; *`;:: Send "{Blind}" . mapSpace.Get(";")
; *':: Send "{Blind}" . mapSpace.Get("`'")
; *[:: Send "{Blind}" . mapSpace.Get("[")
; *]:: Send "{Blind}" . mapSpace.Get("]")
; *\:: Send "{Blind}" . mapSpace.Get("\")
; *Enter:: Send "{Blind}" . mapSpace.Get("Enter")
; *Backspace:: Send "{Blind}" . mapSpace.Get("Backspace")
; *Delete:: Send "{Blind}" . mapSpace.Get("Delete")
; *Insert:: Send "{Blind}" . mapSpace.Get("Insert")
; *Home:: Send "{Blind}" . mapSpace.Get("Home")
; *End:: Send "{Blind}" . mapSpace.Get("End")
; *PgUp:: Send "{Blind}" . mapSpace.Get("PgUp")
; *PgDn:: Send "{Blind}" . mapSpace.Get("PgDn")
; *Up:: Send "{Blind}" . mapSpace.Get("Up")
; *Down:: Send "{Blind}" . mapSpace.Get("Down")
; *Left:: Send "{Blind}" . mapSpace.Get("Left")
; *Right:: Send "{Blind}" . mapSpace.Get("Right")
; Esc:: Send "{Blind}" . mapSpace.Get("Esc")
; F1:: Send "{Blind}" . mapSpace.Get("F1")
; F2:: Send "{Blind}" . mapSpace.Get("F2")
; F3:: Send "{Blind}" . mapSpace.Get("F3")
; F4:: Send "{Blind}" . mapSpace.Get("F4")
; F5:: Send "{Blind}" . mapSpace.Get("F5")
; F6:: Send "{Blind}" . mapSpace.Get("F6")
; F7:: Send "{Blind}" . mapSpace.Get("F7")
; F8:: Send "{Blind}" . mapSpace.Get("F8")
; F9:: Send "{Blind}" . mapSpace.Get("F9")
; F10:: Send "{Blind}" . mapSpace.Get("F10")
; F11:: Send "{Blind}" . mapSpace.Get("F11")
; F12:: Send "{Blind}" . mapSpace.Get("F12")
#HotIf
