local configs = require "nvchad.configs.lspconfig"

local servers = {
  cssls = {},
  html = {},
  bashls = {},
  dockerls = {},
  marksman = {},
  docker_compose_language_service = {},
  intelephense = {
    settings = {
      intelephense = {
        files = {
          maxSize = 5000000, -- Increase max file size for large projects
          associations = { "*.php", "*.phtml", "*.module", "*.inc" },
        },
      },
    },
  },
  tsserver = {
    root_dir = function(...)
      return require("lspconfig.util").root_pattern("tsconfig.json", "jsconfig.json", "package.json", ".git")(...)
    end,
    single_file_support = false,
    keys = {
      {
        "<leader>lo",
        function()
          vim.lsp.buf.code_action {
            apply = true,
            context = {
              only = { "source.organizeImports.ts" },
              diagnostics = {},
            },
          }
        end,
        desc = "Organize Imports",
      },
    },
    settings = {
      diagnostics = { ignoredCodes = { 6133 } },
      completions = {
        completeFunctionCalls = true,
      },
      typescript = {
        inlayHints = {
          includeInlayParameterNameHints = "literal",
          includeInlayParameterNameHintsWhenArgumentMatchesName = false,
          includeInlayFunctionParameterTypeHints = true,
          includeInlayVariableTypeHints = false,
          includeInlayPropertyDeclarationTypeHints = true,
          includeInlayFunctionLikeReturnTypeHints = true,
          includeInlayEnumMemberValueHints = true,
        },
      },
      javascript = {
        inlayHints = {
          includeInlayParameterNameHints = "all",
          includeInlayParameterNameHintsWhenArgumentMatchesName = false,
          includeInlayFunctionParameterTypeHints = true,
          includeInlayVariableTypeHints = true,
          includeInlayPropertyDeclarationTypeHints = true,
          includeInlayFunctionLikeReturnTypeHints = true,
          includeInlayEnumMemberValueHints = true,
        },
      },
    },
  },
  eslint = {
    settings = {
      -- helps eslint find the eslintrc when it's placed in a subfolder instead of the cwd root
      workingDirectory = { mode = "auto" },
    },
  },
}

for name, opts in pairs(servers) do
  opts.on_init = configs.on_init
  opts.on_attach = configs.on_attach
  opts.capabilities = configs.capabilities

  require("lspconfig")[name].setup(opts)
end
