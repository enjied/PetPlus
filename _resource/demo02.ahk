global isCapsLock := 0
#HotIf
$CapsLock::
{
    global
    isCapsLock := 1
    ; MsgBox(isCapsLock)
    KeyWait("CapsLock")
    isCapsLock := 0
    ; MsgBox(isCapsLock)
    return
}
#HotIf

#HotIf isCapsLock
a::{
    MsgBox("ok")
}
#HotIf