#Include globalVar.ahk
/**空格监听 */
#HotIf _Space = 1 and _PetLock = 0
Space:: {
    global
    SetTimer(SpaceGuard, -100, 2000)
    ; SetTimer(SpaceLock, 300, 1000)
    SetTimer(SpaceLock, -300, 1000)
    SpaceFire := 1
    SpaceMode := 0
    SpaceCure := 1
    KeyWait("Space")
    SetTimer(SpaceGuard, 0)
    SetTimer(SpaceLock, 0)
    if (SpaceFire) {
        Send "{Space}"
    }
    SpaceFire := 0
    SpaceMode := 0
    SpaceCure := 0
    return
}
#HotIf
SpaceGuard() {
    global
    SetTimer(SpaceGuard, 0)
    SpaceCure := 0
    SpaceMode := 1
    return
}
SpaceLock() {
    global SpaceFire
    SetTimer(SpaceLock, 0)
    SpaceFire := 0
    return
}
isSpaceMode(*)
{
    if SpaceMode
        return true
    else
        return false
}

HotIf isSpaceMode
; for (k, v in SpaceMap) {
;     cb(key) 
;     {
;         Send("{Blind}" . SpaceMap.Get(key))
;     }
;     Hotkey k , cb
; }
cb(key) 
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
for (k, v in SpaceMap) {
    Hotkey k, cb
}
; '::
; {
;     Send "{Text}'"
; }
+'::
{
    Send "{Text}`""
}
HotIf
