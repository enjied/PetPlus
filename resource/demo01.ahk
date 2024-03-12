TrayMenu()

Suspend, Off

GetColor(){
MouseGetPos x, y
PixelGetColor rgb, x, y, RGB
stringreplace, out, rgb, 0x, , All
if(A_PriorHotkey = A_ThisLabel and A_TimeSincePriorHotkey < 400) {
Clipboard = %out%
ToolTip %out% 已复制
}
SetTimer, RemoveToolTip, 1000
}

Run(data){
position:=InStr(data,"{Pet}")
if(position > 0){
value =
        (
        "%Clipboard%"
)
data= % StrReplace(data,"{Pet}",value)
}
Run %data%
}

CopyRun(data){
ClipSaved := ClipboardAll
Send, ^c
Sleep,100
Run(data)
Sleep,100
Clipboard := ClipSaved
ClipSaved := ""
}

ReplaceText(data){
ClipSaved := ClipboardAll
Send, ^c
Sleep,100
data= % StrReplace(data,"{Pet}",Clipboard)
Clipboard :=data
Send, ^v
Sleep,100
Clipboard := ClipSaved
ClipSaved := ""
}

MouseUp(data){
if(GetKeyState("J", "P") = 1) {
MouseMove, -%data%, -%data%, 0, R
} else if (GetKeyState("L", "P") = 1) {
MouseMove, %data%, -%data%, 0, R
} else {
MouseMove, 0, -%data%, 0, R
}
}

MouseDown(data){
if(GetKeyState("J", "P") = 1) {
MouseMove, -%data%, %data%, 0, R
} else if (GetKeyState("L", "P") = 1) {
MouseMove, %data%, %data%, 0, R
} else {
MouseMove, 0, %data%, 0, R
}
}

MouseLeft(data){
if(GetKeyState("I", "P") = 1) {
MouseMove, -%data%, -%data%, 0, R
} else if (GetKeyState("K", "P") = 1) {
MouseMove, -%data%, %data%, 0, R
} else {
MouseMove, -%data%, 0, 0, R
}
}

MouseRight(data){
if(GetKeyState("I", "P") = 1) {
MouseMove, %data%, -%data%, 0, R
} else if (GetKeyState("K", "P") = 1) {
MouseMove, %data%, %data%, 0, R
} else {
MouseMove, %data%, 0, 0, R
}
}

SendInput(data){
Send {Blind}%data%
}

WheelUp(){
MouseClick, WheelUp
}


WheelDown(){
MouseClick, WheelDown
}

LeftClick(){
MouseClick, Left, , , , , D
KeyWait, %A_ThisLabel%
MouseClick, Left, , , , , U
}

RightClick(){
MouseClick, Right, , , , , D
KeyWait, %A_ThisLabel%
MouseClick, Right, , , , , U
}

TopMost(){
WinGet, ExStyle, ExStyle, A
if (ExStyle & 0x8) {
WinSet AlwaysOnTop, Off, A
ToolTip, 取消置顶
} else {
WinSet AlwaysOnTop, On, A
ToolTip, 设置置顶
}
SetTimer, RemoveToolTip, 1000
}

SetTransparent(data){
WinGet, _Transparent, Transparent,A
if(_Transparent=""){
_Transparent:=255
}
ToolTip, %_Transparent%/255
if(data > 0){
if(_Transparent+5 <= 255){
WinSet, Transparent, % _Transparent+5 , A
}
}Else{
if(_Transparent-5 >= 0){
WinSet, Transparent, % _Transparent-5 , A
}
}
SetTimer, RemoveToolTip, 1000
}

RunWaitOne(command) {
shell := ComObjCreate("WScript.Shell")
exec := shell.Exec(ComSpec " /C " command)
return exec.StdOut.ReadAll()
}

global ClickState:=0
MouseClicks(data){
if(ClickState){
SetTimer, MouseClickTimer, Off
ClickState:=0
ToolTip
}Else{
SetTimer, MouseClickTimer, %data%
ClickState:=1
}
}

KeepSpace(){
if(SpaceMode){
SpaceMode:=0
ToolTip,关闭Space增强模式
}else{
SpaceMode:=1
ToolTip,开启Space增强模式
}
SetTimer, RemoveToolTip, 1000
}

PetLock(){
KeyWait, CapsLock
if(_PetLock){
ToolTip, 禁用锁
BlockInput,Off
_PetLock := 0
}Else{
ToolTip, 启用锁
BlockInput,On
_PetLock := 1
}
SetTimer, RemoveToolTip, 1000
}

GetClassName(){
WinGetClass, out, A
ToolTip, %out% 双击复制
if(A_PriorHotkey = A_ThisLabel and A_TimeSincePriorHotkey < 400) {
Clipboard = %out%
ToolTip %out% 已复制
}
SetTimer, RemoveToolTip, 1000
}

GetProcessPath(){
WinGet, out, ProcessPath, A
ToolTip, %out% 双击定位
if(A_PriorHotkey = A_ThisLabel and A_TimeSincePriorHotkey < 400) {
ToolTip, 定位中
Run explorer /select`, %out%
}
SetTimer, RemoveToolTip, 1000
}

StartUp(){
if(_StartUp = 1){
Run schtasks /delete /tn Pet /f ,,Hide
ToolTip, 取消开机自启
Menu,Tray,UnCheck,%Tray_StartUp%
PetWrite("StartUp","0")
}else{
Run schtasks /create /sc onlogon /tn Pet /tr %A_ScriptFullPath% /rl highest /f ,,Hide
ToolTip, 设置开机自启
Menu,Tray,Check,%Tray_StartUp%
PetWrite("StartUp","1")
}
PetRead("_StartUp","StartUp")
SetTimer, RemoveToolTip, 1000
}

TrayMenu(){
Menu,Tray,DeleteAll
Menu,Tray,NoStandard
Menu, Tray, Click, 1
Menu,Tray,Tip,Pet
Menu,Tray,Add,Pet,ShowMenu
Menu,Tray,Disable,Pet
Menu,Tray,Add
Menu, SubMenu, Add, %Tray_Space%, SpacePower
Menu, SubMenu, Add, %Tray_CapsLock%, CapsLockPower
Menu, SubMenu, Add, %Tray_Command%, CommandPower
Menu,Tray,Add,功能启用, :SubMenu
MethodMenu("Space配置主要预览",ArraySpace1,"ShowSpace1")
MethodMenu("Space配置拓展预览",ArraySpace2,"ShowSpace2")
MethodMenu("CapsLock配置主要预览",ArrayCapsLock1,"ShowCapsLock1")
MethodMenu("CapsLock配置拓展预览",ArrayCapsLock2,"ShowCapsLock2")
Menu,Tray,Add
Menu,Tray,Add,%Tray_Disabled%,Suspend
Menu,Tray,Add,%Tray_Visible%,HideTray
Menu,Tray,Add
Menu,Tray,Add,%Tray_Exit%,ExitPet
Menu,Tray,Add,%Tray_Menu%,ShowMenu
Menu,Tray,Add,%Tray_StartUp%,StartUp
Menu,Tray,Add
Menu,Tray,Add,%Tray_Restart%,ReloadPet
Menu,Tray,Add,%Tray_Reward%,Reward
Menu,Tray,Add
Menu,Tray,Add,%Tray_Position%,Position
Menu,Tray,Add,%Tray_Profile%,Profile
Menu, Tray, Default, Pet
if(_TrayVisible != 0){
Menu, Tray, Icon
Menu,Tray,UnCheck,%Tray_Visible%
}else{
Menu,Tray,Check,%Tray_Visible%
}
if(_StartUp = 1){
Menu,Tray,Check,%Tray_StartUp%
}
if(_CapsLock != 0){
Menu,SubMenu,Check,%Tray_CapsLock%
}
if(_Space != 0){
Menu,SubMenu,Check,%Tray_Space%
}
if(_Command != 0){
Menu,SubMenu,Check,%Tray_Command%
}
}

MethodMenu(name,Array,SubMenu){
for index, element in Array
{
Menu, %SubMenu%, Add, %element%, ShowMenu
}
Menu, Tray, Add, %name%, :%SubMenu%
}

Reward(){
if(RewardState){
Gui,PowerSpaceLayout: Destroy
RewardState:=0
Menu,Tray,UnCheck,%Tray_Reward%
}else{
FileInstall,Pet\Reward.png, %A_Temp%\Reward.png,1
Gui,PowerSpaceLayout:Add,pic,w700 h350,%A_Temp%\Reward.png
Gui,PowerSpaceLayout:Color,FFFFFF
Gui,PowerSpaceLayout:+LastFound +AlwaysOnTop -Caption +ToolWindow +DPIScale
Gui,PowerSpaceLayout:Show,AutoSize Center NoActivate
Gui,PowerSpaceLayout:+LastFound
RewardState:=1
Menu,Tray,Check,%Tray_Reward%
}
}



#if _Space=1 and _PetLock=0
Space::
SetTimer,SpaceGuard,100,2000
SetTimer,SpaceLock,300,1000
SpaceFire:=1
SpaceMode:=0
SpaceCure:=1
KeyWait, Space
SetTimer,SpaceGuard,Delete
SetTimer,SpaceLock,Delete
if (SpaceFire){
Send {Space}
}
SpaceFire:=0
SpaceMode:=0
SpaceCure:=0
return
#if
SpaceGuard:
SetTimer,SpaceGuard,Delete
SpaceCure:=0
SpaceMode:=1
return
SpaceLock:
SetTimer,SpaceLock,Delete
SpaceFire:=0
return


#if SpaceCure
a::
...
SetTimer,SpaceGuard,Delete
SpaceFire:=0
Send {Space}{%A_ThisLabel%}
return
#if




MouseClickTimer:
MouseClick, Left
ToolTip,鼠标点击中...
Return
;================= END SCRIPT ===================
