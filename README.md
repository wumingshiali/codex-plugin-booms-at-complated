# Booms at Completed 🎵

当 Codex 模型输出 EOL token（会话结束 / Stop 事件）时，自动播放 **creeper 爆炸音效** 💥

> 本插件是 [claude-plugin-booms-at-complated](../claude-plugin-booms-at-complated) 的 Codex 移植版，
> 使用 Codex 的 `Stop` hook 机制实现，行为与 Claude Code 版一致。

## 功能

- 监听 `Stop` hook，在模型完成响应时触发
- 播放 creeper 爆炸音效 (`assets/creeper_booms.mp3`)
- 使用 Windows PresentationCore 播放，无需额外依赖
- 使用 `async` 后台执行，不阻塞 Codex 对话

## 项目结构

```
.
├── .codex-plugin/
│   └── plugin.json          # 插件清单
├── .agents/plugins/
│   └── marketplace.json     # 本地 marketplace（便于安装）
├── hooks/
│   └── hooks.json           # Stop hook 配置
├── assets/
│   └── creeper_booms.mp3    # 音效文件
├── hook-play.ps1            # Hook 脚本（后台播放）
├── play-sound.ps1           # 手动播放脚本
├── test-sound.ps1           # 测试脚本
├── README.md
└── LICENSE
```

## 安装

本目录本身就是一个本地 marketplace + 插件。安装步骤：

```powershell
# 1. 添加本地 marketplace
codex plugin marketplace add "D:\Ali\plugin\codex-plugin-booms-at-complated"

# 2. 安装并启用插件
codex plugin add booms-at-completed@booms

# 3. 重启 Codex（或新开对话），用 /hooks 信任该 hook
```

> hook 属于非托管 hook，首次运行前需要在 Codex 中使用 `/hooks` 查看并信任它。

## 测试

运行测试脚本验证音频播放功能：

```powershell
powershell -ExecutionPolicy Bypass -File .\test-sound.ps1
```

手动播放：

```powershell
powershell -ExecutionPolicy Bypass -File .\play-sound.ps1 -Duration 5
```

## 工作原理

插件通过 Codex 的 `Stop` hook 机制工作：

1. 模型完成响应（输出 EOL token）
2. Codex 触发 `Stop` hook
3. Hook 执行 PowerShell 命令，使用 `System.Windows.Media.MediaPlayer` 播放 MP3
4. Hook 声明为 `async`，在后台执行，不阻塞 Codex

## 注意事项

- 仅支持 Windows 平台（依赖 PresentationCore）
- 需要 PowerShell 5.0+
- 音效文件约 321 KB，完整时长约 8 秒（hook 默认播放 5 秒）
