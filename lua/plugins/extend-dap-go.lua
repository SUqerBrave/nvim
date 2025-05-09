return {
  "leoluz/nvim-dap-go",
  opts = function(_, opts)
    -- 合并传入的 opts
    opts.dap_configurations = opts.dap_configurations or {}

    -- 添加适配器配置
   dap = require("dap")
    dap.adapters.go = function(callback, config)
      callback({
        type = "server",
        host = "10.10.100.144", -- 远程服务器的 IP 地址
        port = 2345,            -- 远程服务器 Delve 监听的端口
      })
    end

    -- 调试配置
    table.insert(opts.dap_configurations, {
      type = "go",
      name = "Debug Server sliver", -- 配置名称，便于区分
      request = "attach",           -- 附加到正在运行的程序
      mode = "remote",              -- 远程调试模式
      host = "10.10.100.144",       -- 远程服务器 IP 地址
      port = 2345,                  -- 远程 Delve 服务监听端口
      substitutePath = {
        {
          from = "${workspaceFolder}", -- 本地项目目录
          to = "/home/att/gocode/sliver", -- 远程服务器代码路径
        },
      },
    })

    -- Delve 设置
    opts.delve = {
      port = 2345, -- Delve 调试器的监听端口
    }

    return opts
  end,
}

