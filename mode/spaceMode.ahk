/**空格监听 */
#Include ../globalVar.ahk

; HotIF不支持表达式，只支持回调函数
HotIf  isModifierKeysUpAndSpacePower
Space::
{
    Send "{Space}"
}
for (k, v in SpaceMap) {
    Hotkey k, cbSpace
}
HotIf

if (_PunctuationZh2En)
{
    #HotIf GetKeyState("Shift", 'P')
    Space & `;::
    {
        Send("{Text}:")
    }
    Space & /::
    {
        Send("{Text}?")
    }
    Space & '::
    {
        Send("{Text}`"")
    }
    Space & -::
    {
        Send("{Text}_")
    }
    #HotIf
    
}

/**
 * HotIf的回调函数
 * @param n 不清楚
 */
isModifierKeysUpAndSpacePower(n)
{
    return 
    !(
        !_Space ||
        GetKeyState("LWin", 'P') || 
        GetKeyState("RWin", 'P') ||
        GetKeyState("Ctrl", 'P') || 
        GetKeyState("Alt", 'P') ||
        GetKeyState("Shift", 'P')
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
