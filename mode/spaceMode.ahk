/**空格监听 */
#Include ../globalVar.ahk

; HotIF不支持表达式，只支持回调函数
HotIf  isModifierKeysUp
Space::
{
    Send "{Space}"
}
for (k, v in SpaceMap) {
    Hotkey k, cbSpace
}
HotIf



HotIf isShiftDown
for (k, v in SpaceMap) {
    Hotkey k, cbSpace
}
HotIf
    


/**
 * 修饰键状态，当所有修饰键都没按下时，返回true
 * @param n 不清楚
 */
isModifierKeysUp(n)
{
    return 
    !(
        GetKeyState("LWin", 'P') || 
        GetKeyState("RWin", 'P') ||
        GetKeyState("Ctrl", 'P') || 
        GetKeyState("Alt", 'P') ||
        GetKeyState("Shift", 'P')
    )
}

/**
 * 修饰键状态，当只有shift按下时时，返回true
 * @param n 不清楚
 */
isShiftDown(n)
{
    return 
    !(
        GetKeyState("LWin", 'P') || 
        GetKeyState("RWin", 'P') ||
        GetKeyState("Ctrl", 'P') || 
        GetKeyState("Alt", 'P') ||
        !GetKeyState("Shift", 'P')
    )
}

/**
 * HotKey回调函数
 * @param key 按下的键
 * 执行 Map 中与 key 对应的方法
 */
cbSpace(key) 
{
    v := SpaceMap.Get(key)
    methodName := v[1]
    methodParam := v[2]
    try {
        %methodName%(methodParam)
    } catch Error as e {
        ToolTip("failure to execute "  methodName " param is " methodParam)
        SetTimer(() => ToolTip(), -5000)
    }
}
