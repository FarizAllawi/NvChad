local options = {
  formatters_by_ft = {
    lua = { "stylua" },
    html = { "prettierd" },
    css = { "prettierd" },
    javascript = { "prettierd" },
    javascriptreact = { "prettierd" },
    typescript = { "prettierd" },
    typescriptreact = { "prettierd" },
    tsx = { "prettierd" },
    jsx = { "prettierd" },
    vue = { "prettierd" },
    scss = { "prettierd" },
    less = { "prettierd" },
    json = { "prettierd" },
    jsonrc = { "prettierd" },
    yaml = { "prettierd" },
    markdown = { "prettierd" },
    ["markdown.mdx"] = { "prettierd" },
    graphql = { "prettierd" },
    handlebars = { "prettierd" },
    blade = { "blade-formatter" },
    php = {"pretty-php"}
  },

  format_on_save = {
    -- These options will be passed to conform.format()
    timeout_ms = 500,
    lsp_fallback = true,
  },
}

return options
