ExitPet(data){
    ExitApp(data)
}



CopyRun(data) {
    MsgBox(data)
}

ShowMenu(data) {
    myMenu := Menu()
    ; myMenu.AddStandard()
    myMenu.show()
}

PetLock(data) {
    MsgBox("lock")
}

SetTransparent(data) {
    MsgBox(data)
}

MouseClick(data) {
    MsgBox(data)
}

StartUp(data) {
    MsgBox(data)
}

Reward(data) {
    MsgBox(data)
}

Config(data) {
    Run A_ScriptDir " \Pet.ini"
}

keepSpace(data) {
    MsgBox(data)
}