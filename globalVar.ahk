#Include iniRead.ahk

global ConfigPath := A_ScriptDir "\test.ini"
global PetMap := readFromIni(ConfigPath, "Pet")
Temp := ReadSpaceMap(ConfigPath)
global SpaceMap := Temp[1]
global ShiftSpaceMap := Temp[2]
global CapsLockMap := ReadCapsLockMap(ConfigPath)
/**是否显示托盘图标 */
global _TrayVisible := PetMap.Get("TrayVisible")
/**是否显示欢迎界面 */
global _Welcome := PetMap.Get("Welcome")
/**是否是首次启动 */
global _Stranger := PetMap.Get("Stranger")
/**是否开机自启(手动修改无效) */
global _StartUp := PetMap.Get("StartUp")
/**否启用CapsLock方法模式 */
global _CapsLock := PetMap.Get("CapsLock")
/**是否启用引号命令模式 */
global _Command := PetMap.Get("Command")
global _PunctuationZh2En := PetMap.Get("PunctuationZh2En")


; 未使用
global SpaceFire := 0
global SpaceMode := 0
global SpaceCure := 0
global CapsLockState := 0
global RewardState := 0
/**配置文件路径 */
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
