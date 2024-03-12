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
for (k, v in SpaceMap) {
    ; MsgBox(k " : " SpaceMap.Get(k))
    cb(key) 
    {
        Send("{Blind}" . SpaceMap.Get(key))
    }
    Hotkey k , cb
}
HotIf
