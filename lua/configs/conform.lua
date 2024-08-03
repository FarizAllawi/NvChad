local options = {
  formatters_by_ft = {
    lua = { "stylua" },
    css = { "prettier" },
    html = { "prettier" },
    javascript = { "prettier" },
    javascriptreact = { "prettier" },
    typescript = { "prettier" },
    typescriptreact = { "prettier" },
    tsx = { "prettier" },
    jsx = { "prettier" },
    vue = { "prettier" },
    scss = { "prettier" },
    less = { "prettier" },
    json = { "prettier" },
    jsonrc = { "prettier" },
    yaml = { "prettier" },
    markdown = { "prettier" },
    ["markdown.mdx"] = { "prettier" },
    graphql = { "prettier" },
    handlebars = { "prettier" },
    blade = { "blade-formatter" },
  },

  formatters = {
    prettier = {
      command = "prettier",
      args = {
        "--print-width",
        "150",
        "--stdin-filepath",
        "$FILENAME",
      },
    },
  },

  format_on_save = {
    -- These options will be passed to conform.format()
    timeout_ms = 500,
    lsp_fallback = true,
  },
}

return options
