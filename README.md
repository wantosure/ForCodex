# Logitech Flow 显示器联动切换

这是一个 Windows 双电脑、双显示器场景下的开源方案：使用 Logitech Options+ / Logi Options+ 的按键动作启动脚本，同时用 ControlMyMonitor 通过 DDC/CI 切换显示器输入源。

适合这样的桌面：

- 两台电脑共用一套罗技键盘鼠标，例如 MX Keys、MX Master 3S。
- 两台显示器分别连接两台电脑，例如台式机走 DP，笔记本走 HDMI。
- 想在切换罗技 Easy-Switch / Flow 操作时，让显示器输入源也一起切换。

## 原理

Logitech Flow 本身只负责键盘、鼠标、剪贴板在电脑之间切换，不会控制显示器输入源。

本方案把显示器切换拆成两部分：

1. 在 Logitech Options+ 里给鼠标手势、按键或 Easy-Switch 相关动作绑定“打开文件”。
2. 这个文件是一个 `.bat` 脚本，脚本调用 ControlMyMonitor。
3. ControlMyMonitor 通过显示器的 DDC/CI 功能写入 `VCP Code 60 / Input Select`，实现 DP/HDMI 输入源切换。

## 必要条件

- Windows。
- 显示器支持并开启 DDC/CI。
- 已安装或复制 [ControlMyMonitor](https://www.nirsoft.net/utils/control_my_monitor.html)。
- 两台电脑都要能运行切换脚本。实际使用中，显示器切到另一台电脑后，原电脑可能无法再通过已经失去信号的输入通道把它切回来。

## 快速测试

打开 ControlMyMonitor，选择一台显示器，找到：

```text
VCP Code: 60
VCP Code Name: Input Select
Possible Values: 15, 17, 18 ...
```

记录每个值对应的输入源。常见但不保证通用的映射：

```text
15 = DisplayPort
17 = HDMI
18 = HDMI 2
```

不同品牌和型号可能不一样，必须以自己的机器实测为准。

## 脚本示例

参考 [examples/switch-to-computer-b.bat](examples/switch-to-computer-b.bat)。

示例逻辑：

```bat
先切副屏
等待 3 秒
再切主屏
```

这样做的原因是：主屏一旦切走，当前电脑可能失去主要显示环境，后续命令更容易受影响。

## 配合 Logitech Options+

在 Logitech Options+ 里可以这样绑定：

1. 打开鼠标或键盘设备。
2. 选择一个按钮、手势方向或 Easy-Switch 相关操作。
3. 选择“打开文件”。
4. 选择你的 `.bat` 脚本。
5. 如果需要同时切换键鼠频道，给 MX Keys / MX Master 3S 配置相同目标电脑或同一个 Flow 方向。

实测配置示例：

```text
设备：MX Keys + MX Master 3S
动作：打开文件
文件：切换显示器输入源的 .bat 脚本
```

## 双电脑切回

建议两台电脑各自放一套脚本：

- 电脑 A：切到电脑 B 的输入源。
- 电脑 B：切回电脑 A 的输入源。

不要假设电脑 A 切走显示器以后，还能继续控制这台显示器切回来。很多显示器在输入源切走后，DDC/CI 通道也会跟着当前输入源变化。

## 本仓库内容

```text
examples/
  switch-to-computer-b.bat      通用模板：切到另一台电脑
  switch-back-to-computer-a.bat 通用模板：切回本电脑
docs/
  other-computer-ai-notes.md    给另一台电脑 AI/操作者的配置说明
local/
  desktop-to-laptop.bat         本机实测脚本，仅作参考
```

## 注意

- 不要直接照抄别人的 `\\.\DISPLAY1\Monitor0`，显示器 ID 在不同电脑上可能不同。
- 不要直接照抄 `15/17/18`，输入源编号必须实测。
- 第一次测试时只切一台副屏，确认能用显示器实体按键切回来。
- 如果黑屏，使用显示器菜单手动切回原输入源。

## 许可证

MIT License。
