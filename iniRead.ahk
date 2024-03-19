/**
 * 读写ini中Pet setction中的配置
 * @param key 要写入的配置
 * @param value 要写入的值
 * @param ConfigPath 文件位置
 */
PetWrite(key, value, ConfigPath) {
    IniWrite value, ConfigPath, "Pet", key
}

readFromIni(ConfigPath, section) {
    confStr := IniRead(ConfigPath, section)
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

ReadSpaceMap(ConfigPath) {
    confMap := readFromIni(ConfigPath, "Space")
    spaceMap := Map()
    shiftSpaceMap := Map()
    for k, v in confMap {
        if (InStr(k, "shift")) {
            k := StrReplace(k, "shift")
            shiftSpaceMap.Set(k, v)
        } else {
            spaceMap.set(k, v)
        }
    }
    SpaceMap := ProcessSpaceMap(spaceMap)
    ShiftSpaceMap := ProcessSpaceMap(shiftSpaceMap)
    return [spaceMap, shiftSpaceMap]

    ProcessSpaceMap(confMap) {
        resultMap := Map()
        for k, v in confMap {
            k := kCheck(k)
            K := "Space & " K
            v := vProcess(v)
            resultMap.Set(k, v)
        }
        return resultMap
    }
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
        v := vProcess(v)
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