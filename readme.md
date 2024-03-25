# PetPlus

这是一款能为**空格键✔**、**CapLock键✔**和**引号键✔**添加强力功能的脚本😎

## 使用指南：

1. 下载配置文件 `petconfig.ini` 和脚本并放在相同的目录中，启动脚本即可。修改配置后重启脚本生效。
2. 在配置文件中有三个片区：`Space`，`CapsLock`，`Command`。在任一片区添加你想绑定的按键和相对应的功能
3. `Space` 片区中的按键，在同时按住空格键和你绑定的按键后触发
4. `CapsLock` 片区中的按键，在同时按住大小写切换键和你绑定的按键后触发
5. `Command` 片区中的按键，在按住引号键后，输入你编写的字符串，松开引号键触发
6. 可以在配置文件中的 `Pet` 片区，启用或禁用相应的模块。
7. Win+ESC临时禁用/启用所有脚本功能
8. 配置文件中介绍了一些AutoHotKey原有的功能和我编写的功能，你可以根据需要自由组合😘
9. 如果启用了 `CapsLock` 模式，就不能再通过它切换大小写状态❗，你需要在配置文件中绑定其他的按键来切换大小写

> 你也可以安装 `AutoHotKey V2`，直接运行源代码

脚本参考了Pet，项目地址：[Pet效率工具，热键用户自定义](https://github.com/majorworld/Pet)

