#Include ../globalVar.ahk
#Include ../toolkit.ahk

#HotIf isModifierAndSpaceKeysUp()
$'::
{
    global UserInput := InputHook()
    UserInput.Start()
    KeyWait("'")
    UserInput.Stop()
    if (A_TimeSinceThisHotkey < 300) {
        SendInput("{Blind}{'}")
    } else {
        extendAbbr(UserInput.Input)
    }
    Return
}
#HotIf

/**
 * 指定缩写与对应的行为
 * @param input 接受的字符串
 */
extendAbbr(input) {
    if (CommandMap.Has(input)){
        v := CommandMap.Get(input)
        methodName := v[1]
        methodParam := v[2]
        try {
            if v[2] = '' {
                %methodName%()
            } else {
                %methodName%(methodParam)
            }
        } catch Error as e {
            ToolTip("failure to execute "  methodName " param is " methodParam "`nERROR" e.Message)
            SetTimer(() => ToolTip(), -5000)
        }
    }
    else {
        ToolTip "not set: " input
        SetTimer(() => ToolTip(), -3000)
    }
}


isModifierAndSpaceKeysUp()
{
    return 
    !(
        GetKeyState("LWin") || 
        GetKeyState("RWin") ||
        GetKeyState("Ctrl") || 
        GetKeyState("Alt")  ||
        GetKeyState("Shift") ||
        GetKeyState("Space")
    )
}
