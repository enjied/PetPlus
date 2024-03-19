/**
 * 读写ini中Pet setction中的配置
 * @param key 要写入的配置
 * @param value 要写入的值
 * @param ConfigPath 文件位置
 */
PetWrite(key, value, ConfigPath) {
    IniWrite value, ConfigPath, "Pet", key
}


/**
 * 从ini中读取配置
 * @param ConfigPath 文件路径
 * @param section 片段
 * @returns {Map} 将所有键值对包装进Map返回
 */
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

/**
 * 从ini中读取按键配置
 * @param ConfigPath 文件路径
 * @returns {Array} [spaceMap, shiftSpaceMap]
 */
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
            resultMap.Set(k, v)
        }
        return resultMap
    }
}

/**
 * 从ini中读取按键配置
 * @param ConfigPath 文件路径
 * @returns {Map} 将所有键值对包装进Map返回
 */
ReadCapsLockMap(ConfigPath) {
    confMap := readFromIni(ConfigPath, "CapsLock")
    resultMap := Map()
    for k, v in confMap {
        k := kCheck(k)
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
        resultMap.Set(k, v)
    }
    return resultMap

}




/**
 * 从ini中读取按键配置
 * @param ConfigPath 文件路径
 * @param section 片段
 * @param ischeck 是否对键进行方法检查 0 不检查 1 检查$符号 
 * @returns {Map} 将所有键值对包装进Map返回
 */
readCommondMap(ConfigPath, section) {
    confMap := readFromIni(ConfigPath, "Space")
    for k, v in confMap {
        k := kCheck(k)
        K := section " & " K
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
        confMap.Set(k, v)
    }
    return confMap

    kCheck(k) {
        if (k = "_fyh") {
            k := "``"
            return k
        }
        if (k = "_dyh") {
            k := "="
            return k
        }
        if (k = "_;") {
            k := ";"
            return k
        }
        if (k = "_'") {
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