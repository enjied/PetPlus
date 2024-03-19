/**
 * 重写 Welcome 方法
 * 绘制启动界面
 */
Welcome() {
    welcomeGui := Gui("+LastFound + AlwaysOnTop - Caption + ToolWindow")
    welcomeGui.BackColor := "EB6796"
    welcomeGui.SetFont("cwhite s60 bold q5", "Segoe UI")
    welcomeGui.Add("Text", , "Pet")
    welcomeGui.Show("AutoSize Center NoActivate")
    Sleep(800)
    welcomeGui.Destroy()
}