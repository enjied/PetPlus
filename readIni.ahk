/**
 * 从ini中读取配置
 * @param ConfigPath 文件路径
 * @param section 片段
 * @param ischeck 是否对键进行检查 0 不检查 1 检查符号缩写和结果空值 2 检查$符号 
 * @returns {Map} 将所有键值对包装进Map返回
 */
readFromIni(ConfigPath, section, ischeck) {
    confStr := IniRead(ConfigPath, section)
    confStrArray := StrSplit(confStr, '`n')
    confMap := Map()
    for elem in confStrArray {
        ; 找到最右边的等号
        lastdh := InStr(elem, '=', , 1,)
        ; 截取等号两边的字符串
        k := SubStr(elem, 1, lastdh - 1)
        if (ischeck == 1 || ischeck == 2) {
            k := kCheck(k)
        }
        v := SubStr(elem, lastdh + 1, StrLen(elem) - lastdh)
        if (ischeck == 1 && v = "")
            v := "{Text}noconifg"
        if (ischeck == 2)
        {
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
        }
        confMap.Set(k, v)
    }
    return confMap

    kCheck(k) {
        if (k = "_fyh")
            k := "``"
        if (k = "_dyh")
            k := "="
        if (k = "_;")
            k := ";"
        if (k = "_yh")
            k := "`'"
        return k
    }

}