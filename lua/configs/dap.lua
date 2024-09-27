local dap = require("dap")
dap.adapters["pwa-node"] = {
  type = "server",
  host = "127.0.0.1",
  port = 8123,
  executeable = {
    command = "js-debug-adapter"
  }
}

dap.adapters["php"] = {
  type = 'server',
  host = "127.0.0.1",
  port = 8123,
  executeable = {
    command = 'php-debug-adapter', -- Adjust this to your PHP debug adapter command
  },
}

local languageSupport = {
  typescript = "pwa-node",
  javascript = "pwa-node",
  typescriptreact = "pwa-node",
  javascriptreact = "pwa-node",
  php = "php"
}

for _, language, adapter in ipairs(languageSupport) do
  if adapter == "pwa-node" then
    dap.configurations[language] = {
      {
        type = adapter,
        request = "launch",
        name = "Launch File",
        program = "${file}",
        cwd = "${workspaceFolder}",
        runtimeExecutable = "node"
      }
    }
  elseif adapter == "php" then
    dap.configurations[language] = {
      {
        type = adapter,
        request = "launch",
        name = "Listen for Xdebug",
        port = 9003,
        pathMappings = {
          ["/var/www/html"] = "${workspaceFolder}"
        }
      }
    }
  end
end
