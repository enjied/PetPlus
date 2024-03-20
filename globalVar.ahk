global ConfigPath := A_ScriptDir "\petconfig.ini"
try {
    FileInstall "Config.ini", ConfigPath, 0
} catch Error as e {

}
#Include iniRead.ahk

global PetMap := readFromIni(ConfigPath, "Pet")
Temp := ReadSpaceMap(ConfigPath)
global SpaceMap := Temp[1]
global ShiftSpaceMap := Temp[2]
global CapsLockMap := ReadCapsLockMap(ConfigPath)
global CommandMap := ReadCommandkMap(ConfigPath)
/**是否显示托盘图标 */
global _TrayVisible := PetMap.Get("TrayVisible")
/**是否显示欢迎界面 */
global _Welcome := PetMap.Get("Welcome")
/**是否是首次启动 */
/**否启用Space方法模式 */
global _Space := PetMap.Get("Space")
global _Stranger := PetMap.Get("Stranger")
/**否启用CapsLock方法模式 */
global _CapsLock := PetMap.Get("CapsLock")
/**是否启用引号命令模式 */
global _Command := PetMap.Get("Command")
