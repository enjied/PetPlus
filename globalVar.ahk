global ConfigPath := A_ScriptDir "\petconfig.ini"

global PetMap := readFromIni(ConfigPath, "Pet")
global SpaceMap := ReadSpaceMap(ConfigPath)
global CapsLockMap := ReadCapsLockMap(ConfigPath)
global CommandMap := ReadCommandkMap(ConfigPath)
/**是否显示托盘图标 */
global _TrayVisible := PetMap.Get("TrayVisible")
/**是否显示欢迎界面 */
global _Welcome := PetMap.Get("Welcome")
/**否启用Space方法模式 */
global _Space := PetMap.Get("Space")
/**否启用CapsLock方法模式 */
global _CapsLock := PetMap.Get("CapsLock")
/**是否启用引号命令模式 */
global _Command := PetMap.Get("Command")


; 下面是读取配置相关的函数
ReadSpaceMap(ConfigPath) {
    confMap := readFromIni(ConfigPath, "Space")
    resultMap := Map()
    for k, v in confMap {
        k := kCheck(k)
        K := "Space & " K
        v := vProcess(v)
        resultMap.Set(k, v)
    }
    return resultMap
}

ReadCapsLockMap(ConfigPath) {
    confMap := readFromIni(ConfigPath, "CapsLock")
    resultMap := Map()
    for k, v in confMap {
        k := kCheck(k)
        v := vProcess(v)
        resultMap.Set(k, v)
    }
    return resultMap
}

ReadCommandkMap(ConfigPath) {
    confMap := readFromIni(ConfigPath, "Command")
    for k, v in confMap {
        confMap.Set(k, vProcess(v))
    }
    return confMap

}

/**
 * 
 * @param k 键位字符串
 * @returns {String} 要替换的键位
 */
kCheck(k) {
    if (k = "_fyh") {
        k := "``"
        return k
    }
    if (k = "_dyh") {
        k := "="
        return k
    }
    if (k = "_fh") {
        k := ";"
        return k
    }
    if (k = "_yh") {
        k := "`'"
        return k
    }
    if (k = "_[") {
        k := "["
        return k
    }
    if (k = "_]") {
        K := "]"
        return k
    }
    return k
}

vProcess(v) {
    position := InStr(v, "$")
    if (position > 0) {
        methodName := SubStr(v, 1, position - 1)
        methodParam := SubStr(v, position + 1)
        v := [methodName, methodParam]
    } else if (position = 0) {
        v := [v, '']
    } else {
        v := ["MsgBox", "not set"]
    }
    return v
}

readFromIni(ConfigPath, section) {
    try {
        confStr := IniRead(ConfigPath, section)
    } catch Error as e {
        MsgBox("没有找到配置文件，脚本将退出")
        ExitApp
    }
    confStrArray := StrSplit(confStr, '`n')
    confMap := Map()
    for elem in confStrArray {
        ; 找到最右边的等号
        lastdh := InStr(elem, '=', , 1,)
        ; 截取等号两边的字符串
        k := SubStr(elem, 1, lastdh - 1)
        v := SubStr(elem, lastdh + 1, StrLen(elem) - lastdh)
        confMap.Set(k, v)
    }
    return confMap
}