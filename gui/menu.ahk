SpacePower() {
    global
    if (_Space != 0) {
        ; Menu,SubMenu,UnCheck,%Tray_Space%
        _Space := 0
    } Else {
        ; Menu,SubMenu,Check,%Tray_Space%
        _Space := 1
    }
    ; PetWrite("Space",_Space, ConfigPath)
}


CapsLockPower() {
    if (_CapsLock != 0) {
        ; Menu,SubMenu,UnCheck,%Tray_CapsLock%
        _CapsLock := 0
    } Else {
        ; Menu,SubMenu,Check,%Tray_CapsLock%
        _CapsLock := 1
    }
    ; PetWrite("CapsLock",_CapsLock, ConfigPath)
}


CommandPower() {
    if (_Command != 0) {
        ; Menu,SubMenu,UnCheck,%Tray_Command%
        _Command := 0
    } Else {
        ; Menu,SubMenu,Check,%Tray_Command%
        _Command := 1
    }
    ; PetWrite("Command",_Command)
}