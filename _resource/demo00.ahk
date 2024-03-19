; ^j::是热键
; ^代表Ctrl
; ::左边的字符表示你需要安下的热键
; Send 是函数，任何在空格之后包括在引号内的内容都将被键入
^j::
{
    Send "Hello World"
}

; ::ftw:: 表示热字串
; 什么是热字串? 当你键入它们时, 热字串主要用于扩展缩写(自动替换). 当然, 它也可以用来启动任何脚本动作. 
; 需要按下一个默认的结束符，才会触发热字串
::ftw::Free the whales"

; 热字串也可以启动脚本动作. 和热键一样 "几乎能做任何事情".
::btw::
{
    MsgBox "You typed btw."
}

; 可以通过在两个按键(除控制器按键) 之间, 使用  &  来定义一个组合热键. 在下面的例子中, 你要按下Numpad0, 再按下Numpad1 或 Numpad2, 才能触发热键
Numpad0 & Numpad1::
{
    MsgBox "You pressed Numpad1 while holding down Numpad0."
}

Numpad0 & Numpad2::
{
    Run "notepad.exe"
}

; 有时候你也许想要热键或热字串只在某些特定窗口上工作(或禁用). 要做到这一点, 您需要使用其中的任意一个 "高级" 命令, 在它们前面带有一个 #, 即 #HotIf, 结合内置函数 WinActive 或 WinExist:
#HotIf WinActive("Untitled - Notepad")
#Space::
{
    MsgBox "You pressed WIN+SPACE in Notepad."
}

; 要关闭后续热键或热字串的上下文敏感性, 请指定 #HotIf 指令, 但不带参数.
; #HotIf 指令是与位置相关的: 它会影响脚本中实际在它下面的所有热键和热字串, 直到下一个 #HotIf 指令.
#HotIf WinActive("Untitled - Notepad")
!q::
{
    MsgBox "You pressed ALT+Q in Notepad."
}
#HotIf
!q::
{
    MsgBox "You pressed ALT+Q in any window."
}

Send "This text has been typed{!}" ;  注意大括号中的感叹号? 这是因为, 如果没有 {}, AHK 将按下 Alt 键.

; 下面这个例子表示按下一个键的时候再按下另一个键(或多个键)..
; 如果其中一个方法不奏效, 试试另一个.
Send "^s"                     ; 表示发送 CTRL+S
Send "{Ctrl down}s{Ctrl up}"  ; 表示发送 CTRL+S
Send "{Ctrl down}c{Ctrl up}"
Send "{b down}{b up}"
Send "{Tab down}{Tab up}"
Send "{Up down}"  ; 按下向上键.
Sleep 1000        ; 保持 1 秒.
Send "{Up up}"    ; 然后松开向上键.