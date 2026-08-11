# 通用配置说明

这份说明用于在第二台电脑上配置“切回来”的脚本，也适用于从零配置任意一台电脑。

## 配置步骤

1. 安装或复制 ControlMyMonitor。
2. 在显示器 OSD 菜单中开启 DDC/CI。
3. 打开 ControlMyMonitor，分别选择每一台显示器。
4. 找到 `VCP Code 60 / Input Select`。
5. 记录每台显示器的设备 ID，例如 `\\.\DISPLAY1\Monitor0`。
6. 逐个测试输入源值，例如 `15`、`17`、`18`。
7. 把测试成功的设备 ID 和输入源值填入 `examples/` 里的 bat 模板。

## 推荐测试顺序

先只测试副屏，不要一开始同时切两台显示器。

```bat
"D:\Program Files\controlmymonitor\ControlMyMonitor.exe" /SetValue "\\.\DISPLAY2\Monitor0" 60 17
```

如果显示器黑屏，使用显示器实体菜单切回原输入源。

## 为什么两台电脑都需要脚本

显示器切到另一台电脑输入源后，原电脑的 DP/HDMI DDC/CI 通道可能失效。  
因此，切回脚本通常应该由当前正在显示画面的那台电脑执行。

## Logitech Options+ 绑定方式

在 Logitech Options+ 中，把鼠标按钮、手势方向或键盘快捷动作设置为“打开文件”，然后选择对应的 `.bat` 脚本。

建议把切换脚本绑定到不容易误触的手势或按键上。第一次使用时，旁边保留显示器实体菜单的手动切回路径。
