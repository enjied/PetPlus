#Include globalVar.ahk
#Include toolkit.ahk

; capslock状态
CapsLockState := 0

#HotIf _CapsLock = 1

/**
 * 改变CapsLockState
 * @param ThisHotkey CapsLock
 */
$CapsLock::
{
    global
    CapsLockState := 1
    KeyWait("CapsLock")
    CapsLockState := 0
    Return
}
#HotIf

isCapsLockState(*)
{
    if CapsLockState
        return true
    else
        return false
}

HotIf isCapsLockState
for (k, v in CapsLockMap) {
    ; MsgBox(k " : " SpaceMap.Get(k))
    cbSend(key) 
    {
        Send("{Blind}" . SpaceMap.Get(key))
    }
    cbMethod(key)
    {
        v := CapsLockMap.Get(key)
        methodName := v[1]
        methodParam := v[2]
        try {
            %methodName%(methodParam)
        } catch Error as e {
            ToolTip("failure to execute "  methodName " param is " methodParam)
            SetTimer(() => ToolTip(), -5000)
        }
    }
    Hotkey k , cbMethod
}
HotIf

