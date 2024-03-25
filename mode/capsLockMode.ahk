#Include ../globalVar.ahk
#Include ../toolkit.ahk

global isCapsLock := 0
global _PetLock := 0
$CapsLock::
{
    global
    isCapsLock := 1
    KeyWait("CapsLock")
    isCapsLock := 0
}

HotIf isModifierKeysUpAndCapsLockDown
for (k, v in CapsLockMap) {

    Hotkey k , cbCapsLock
}
HotIf

/**
 * HotIf的回调函数
 * @param n 不清楚
 */
isModifierKeysUpAndCapsLockDown(n)
{
    return
    !(
        !isCapsLock ||
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
cbCapsLock(key)
{
    v := CapsLockMap.Get(key)
    methodName := v[1]
    methodParam := v[2]
    try {
        if v[2] = '' {
            %methodName%()
        } else {
            %methodName%(methodParam)
        }
    } catch Error as e {
        ToolTip("failure to execute "  methodName " param is " methodParam "ERROR" e.Message)
        SetTimer(() => ToolTip(), -5000)
    }
}
