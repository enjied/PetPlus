#Include globalVar.ahk

#HotIf _Command and !SpaceMode
$'::
{
    global UserInput := InputHook()
    ; SetTimer(FastKey, 100)
    UserInput.Start()
    KeyWait("'")
    UserInput.Stop()
    if (A_TimeSinceThisHotkey < 300) {
        SendInput("{Blind}{'}")
    } else {
        ; Lisrary(UserInput.Input)
        extendAbbr(UserInput.Input)
    }
    Return
}

/**
 * 将解释的字符串通过Run打开
 * @param input 接受的字符串
 */
Lisrary(input) {
    if (input == "")
        return
    try {
        Run input
    } catch {
        ToolTip "don't run: " input
        SetTimer(() => ToolTip(), -3000)
    }
}

/**
 * 指定缩写与对应的行为
 * @param input 接受的字符串
 */
extendAbbr(input) {
    if (input = "JS")
        Send("JavaScript")
    else if (input = "otoh")
        Send("{on the other hand")
    else if (input = "fl")
        Send("Florida")
    else if (input = "ca")
        Send("California")
    else if (input = "ahk")
        Run("https://www.autohotkey.com")
    else {
        ToolTip "not set: " input
        SetTimer(() => ToolTip(), -3000)
    }
}

