/**
 * 绘制启动界面
 */
Welcome() {
    welcomeGui := Gui("+LastFound + AlwaysOnTop - Caption + ToolWindow")
    welcomeGui.BackColor := "67a9eb"
    welcomeGui.SetFont("cwhite s60 bold q5", "Segoe UI")
    welcomeGui.Add("Text", , "PetPlus")
    welcomeGui.Show("AutoSize Center NoActivate")
    Sleep(800)
    welcomeGui.Destroy()
}