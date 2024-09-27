-- load defaults i.e lua_lsp
require("nvchad.configs.lspconfig").defaults()

local lspconfig = require "lspconfig"

local servers = {
  "html",
  "cssls",
  "tsserver",
  "eslint",
  "tailwindcss",
  "intelephense",
  "dockerls",
  "bashls",
}

local nvlsp = require "nvchad.configs.lspconfig"

-- lsps with default config
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = nvlsp.on_attach,
    on_init = nvlsp.on_init,
    capabilities = nvlsp.capabilities,
  }
end

-- --- PHP ---
-- lspconfig.intelephense.setup {
--   settings = {
--     intelephense = {
--       files = {
--         maxSize = 5000000, -- Increase max file size for large projects
--         associations = { "*.php", "*.phtml", "*.module", "*.inc" },
--       },
--     },
--   },
-- }
--
-- -- tailwindcss ---
-- lspconfig.tailwindcss.setup {
--   -- exclude a filetype from the default_config
--   filetypes_exclude = { "markdown" },
--   -- add additional filetypes to the default_config
--   filetypes_include = {},
--   -- to fully override the default_config, change the below
--   -- filetypes = {}
--   setup = function(_, opts)
--     local tw = require "lspconfig.server_configurations.tailwindcss"
--     opts.filetypes = opts.filetypes or {}
--
--     -- Add default filetypes
--     vim.list_extend(opts.filetypes, tw.default_config.filetypes)
--
--     -- Remove excluded filetypes
--     --- @param ft string
--     opts.filetypes = vim.tbl_filter(function(ft)
--       return not vim.tbl_contains(opts.filetypes_exclude or {}, ft)
--     end, opts.filetypes)
--
--     -- Add additional filetypes
--     vim.list_extend(opts.filetypes, opts.filetypes_include or {})
--   end,
-- }
--
-- -- typescript and javascript
-- lspconfig.tsserver.setup {
--   root_dir = function(...)
--     return require("lspconfig.util").root_pattern("tsconfig.json", "jsconfig.json", "package.json", ".git")(...)
--   end,
--   init_options = {
--     preferences = {
--       disableSuggestions = true,
--     },
--   },
--   single_file_support = false,
--   -- keys = {
--   --   {
--   --     "<leader>lo",
--   --     function()
--   --       vim.lsp.buf.code_action {
--   --         apply = true,
--   --         context = {
--   --           only = { "source.organizeImports.ts" },
--   --           diagnostics = {},
--   --         },
--   --       }
--   --     end,
--   --     desc = "Organize Imports",
--   --   },
--   -- },
--   settings = {
--     --   diagnostics = { ignoredCodes = { 6133 } },
--     --   completions = {
--     --     completeFunctionCalls = true,
--     --   },
--     typescript = {
--       inlayHints = {
--         includeInlayParameterNameHints = "literal",
--         includeInlayParameterNameHintsWhenArgumentMatchesName = false,
--         includeInlayFunctionParameterTypeHints = true,
--         includeInlayVariableTypeHints = false,
--         includeInlayPropertyDeclarationTypeHints = true,
--         includeInlayFunctionLikeReturnTypeHints = true,
--         includeInlayEnumMemberValueHints = true,
--       },
--     },
--     javascript = {
--       inlayHints = {
--         includeInlayParameterNameHints = "all",
--         includeInlayParameterNameHintsWhenArgumentMatchesName = false,
--         includeInlayFunctionParameterTypeHints = true,
--         includeInlayVariableTypeHints = true,
--         includeInlayPropertyDeclarationTypeHints = true,
--         includeInlayFunctionLikeReturnTypeHints = true,
--         includeInlayEnumMemberValueHints = true,
--       },
--     },
--   },
-- }
