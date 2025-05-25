```
git remote add origin git@github.com:SUqerBrave/nvim.git
git branch -M main
git push -u origin main
```

#nvim #lazyvim
```
git clone https://github.com/SUqerBrave/nvim.git ~/.config/nvim
```

还需要pyenv配合

```
require("config.lazy")

vim.g.python3_host_prog = "/home/att/.pyenv/versions/3.12.7/bin/python3"
vim.g.python_host_prog = "/home/att/.pyenv/versions/3.12.7/bin/python"
```

#nvim #clean

```
rm -rf ~/.cache/nvim*
rm -rf ~/.local/share/nvim*
rm -rf ~/.config/nvim*
```

#Mason
```
:MasonInstall gopls pyright jdtls clangd 
```


有个插件需要手动去改代码
/home/att/.local/share/nvim/lazy/nui.nvim/lua/nui/utils/init.lua
```
function _.get_default_winborder()
  return "none"
end

if _.feature.v0_11 then
  function _.get_default_winborder()
    local ok, style = pcall(vim.api.nvim_get_option_value, "winborder", {})
    if not ok or style == "" then
      return "none"
    end
    return style
  end
end

```

#dap 
```
:MasonInstall delve debugpy codelldb
```


#win 
```
git clone https://github.com/SUqerBrave/nvim.git $env:LOCALAPPDATA\nvim
```


```
vim.g.python3_host_prog = "C:/Users/do/.pyenv/pyenv-win/versions/3.10.11/python3.exe"

vim.g.python_host_prog = "C:/Users/do/.pyenv/pyenv-win/versions/3.10.11/python.exe"

vim.g.pythonw_host_prog = "C:/Users/do/.pyenv/pyenv-win/versions/3.10.11/pythonw.exe"
```


#终端复制 #换一个terminal就行 #wezterm
```
scoop bucket add extras
scoop install wezterm
```


wez.bat
```
@echo off
wezterm-gui %*
```
`.wezterm.lua`
```lua
local wezterm = require("wezterm")

local config = {}

if wezterm.config_builder then
  config = wezterm.config_builder()
end

-- 设置默认 shell
config.default_prog = { "pwsh.exe", "-NoLogo" }

-- 使用 GUI 启动目录继承
wezterm.on("gui-startup", function(cmd)
  local cwd = wezterm.gui.get_startup_dir()
  local tab, pane, window = wezterm.mux.spawn_window({
    cwd = cwd,
    args = cmd.args,
  })
end)

-- 避免启动空窗口
config.enable_tab_bar = false

return config

```

#nvim #OSC52
```lua
return {
  {
    "ojroques/nvim-osc52",
    event = "VeryLazy",
    config = function()
      local osc52 = require("osc52")

      osc52.setup({
        max_length = 0, -- 0 表示不限制长度
        silent = false,
        trim = false,
      })

      -- 封装 copy 以适配 Neovim clipboard 传入的是 table 的情况
      local function copy(lines, _)
        osc52.copy(table.concat(lines, "\n"))
      end

      vim.g.clipboard = {
        name = "osc52",
        copy = {
          ["+"] = copy,
          ["*"] = copy,
        },
        paste = {
          ["+"] = function()
            return {}
          end,
          ["*"] = function()
            return {}
          end,
        },
      }
    end,
  },
}

```

#tmux #OSC52 
`~/.tmux.conf`

```
# 启用 clipboard 支持（OSC52）
set-option -g set-clipboard on

# 允许 tmux 把复制的内容发到终端（WezTerm）剪贴板
set-option -g terminal-overrides ',xterm-256color:clipboard:enable'

```

```
# 让 tmux 的复制模式更符合常用习惯（可选）
setw -g mode-keys vi
bind-key -T copy-mode-vi y send-keys -X copy-pipe-and-cancel 'tmux save-buffer - | xclip -i -selection clipboard'
```
