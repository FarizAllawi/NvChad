
--[[
  Unleash seamless collaboration between AI and coding
  Effortlessly boost efficiency with plugins that adapt to your needs,
  creating a streamlined and innovative development experience.
                                        -- Aisync --
]]
local Utils = require "utils"
local lazy  = require "lazy"

return {
  -- Copilot
  -- { "zbirenbaum/copilot.lua",
  --   cmd = "Copilot",
  --   event = { "InsertEnter" },
  --   build = ":Copilot auth",
  --   dependencies = { "zbirenbaum/copilot-cmp" },
  --   opts = {
  --     suggestion = { enabled = true },
  --     panel = { enabled = false },
  --     filetypes = {
  --       ["*"] = true, -- disable for all other filetypes and ignore default `filetypes`
  --     },
  --   },
  -- },
  -- {
  --   "zbirenbaum/copilot-cmp",
  --   event = { "InsertEnter" },
  --   dependencies = { "copilot.lua" },
  --   opts = {},
  --   config = function(_, opts)
  --     local copilot_cmp = require "copilot_cmp"
  --     copilot_cmp.setup(opts)
  --     Utils.lsp.on_attach(function(client, _)
  --       if client.name == "copilot" then
  --         copilot_cmp._on_insert_enter()
  --       end
  --     end)
  --   end,
  -- },

  -- Codeium
  {
    "Exafunction/codeium.nvim",
    build = ":Codeium Auth",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "hrsh7th/nvim-cmp",
    },
    config = function()
        require("codeium").setup({
           enable_chat = true,
        })

        require("cmp").setup({
          sources = {
              { name = "codeium" },
          },
          formatting = {
            format = require('lspkind').cmp_format({
              mode = "symbol",
              maxwidth = 50,
              ellipsis_char = '...',
              symbol_map = { Codeium = "", }
            })
          }
      })
    end
  },



  {
    'codota/tabnine-nvim',
    build = "./dl_binaries.sh",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "hrsh7th/nvim-cmp",
    },
    config = function()
        require('tabnine').setup({
          disable_auto_comment=true,
          accept_keymap="<S-CR>",
          dismiss_keymap = "<S-]>",
          debounce_ms = 800,
          suggestion_color = {gui = "#808080", cterm = 244},
          codelens_color = { gui = "#808080", cterm = 244 },
          codelens_enabled = true,
          exclude_filetypes = {"TelescopePrompt", "NvimTree"},
          log_file_path = nil, -- absolute path to Tabnine log file,
          -- tabnine_enterprise_host = tabnine_enterprise_host,
          ignore_certificate_errors = false,
        })
    end,
  },


--  {
--    "huggingface/llm.nvim",
--    event = { "InsertEnter" },
--    config = function ()
--      return require("configs.local-gen")
--    end
--  },



  --
  -- {
  --
  --   "David-Kunz/gen.nvim",
  --   lazy = false,
  --   config = function ()
  --     require("configs.local-gen")
  --   end
  -- },
  --
  --
  --

  -- {
  --   "huggingface/llm.nvim",
  --   event = { "InsertEnter", "CmdlineEnter" },
  --   lazy = true,
  --   opts = function()
  --     local job = require "plenary.job"
  --     local logger = require("plenary.log").new {
  --       plugin = "llm.nvim",
  --       level = "info",
  --     }
  --
  --     local splitCommandIntoTable = function(command)
  --       local cmd = {}
  --       for word in command:gmatch "%S+" do
  --         table.insert(cmd, word)
  --       end
  --       return cmd
  --     end
  --
  --     local function loadConfigFromCommand(command, callback, defaultValue)
  --       local cmd = splitCommandIntoTable(command)
  --       job
  --         :new({
  --           command = cmd[1],
  --           args = vim.list_slice(cmd, 2, #cmd),
  --           on_exit = function(j, exit_code)
  --             if exit_code ~= 0 then
  --               logger.warn("Command'" .. command .. "' did not return a value when executed")
  --               return
  --             end
  --             local value = j:result()[1]:gsub("%s+$", "")
  --             if value ~= nil and value ~= "" then
  --               callback(value)
  --             elseif defaultValue ~= nil and defaultValue ~= "" then
  --               callback(defaultValue)
  --             end
  --           end,
  --
  --         })
  --         :start()
  --     end
  --
  --     local huggingface_api_token
  --     local command = "pass show huggingface-access-token"
  --     loadConfigFromCommand(command, function(value)
  --       huggingface_api_token = value
  --     end, "")
  --
  --     return {
  --       model = "mistral",
  --       url = "http://localhost:11434",
  --       -- api_token = huggingface_api_token,
  --       accept_keymap = "<Tab>",
  --       dismiss_keymap = "<S-Tab>",
  --       query_params = {
  --         max_new_tokens = 60,
  --         temperature = 0.3,
  --         top_p = 0.95,
  --         stop_tokens = nil,
  --       },
  --       enable_suggestions_on_files = "*.py,*.lua,*.java,*.js,*.jsx,*.ts,*.tsx,*.html,*.css,*.scss,*.json,*.yaml,*.yml,*.md,*.rmd,*.tex,*.bib,*.cpp,*.h,*.hpp", -- pattern matching syntax to enable suggestions on specific files, either a string or a list of strings
  --     }
  --   end,
  -- },


  --
  -- ChatGPT
  -- {
  --   "jackMort/ChatGPT.nvim",
  --   event = "VeryLazy",
  --   config = function()
  --     require("chatgpt").setup({
  --
  --       api_key_cmd = "pass ChatGPT",
  --       openai_edit_params = {
  --         -- model = "gpt-4-1106-preview",
  --         model = "gpt-3.5-turbo",
  --         frequency_penalty = 0,
  --         presence_penalty = 0,
  --         temperature = 0.9,
  --         top_p = 1,
  --         n = 1,
  --       },
  --       sessions_window = {
  --           active_sign = "  ",
  --           inactive_sign = "  ",
  --           current_line_sign = "",
  --           border = {
  --             style = "rounded",
  --             text = {
  --               top = " Sessions ",
  --             },
  --           },
  --           win_options = {
  --             winhighlight = "Normal:Normal,FloatBorder:FloatBorder",
  --           },
  --         },
  --     })
  --   end,
  --   dependencies = {
  --     "MunifTanjim/nui.nvim",
  --     "nvim-lua/plenary.nvim",
  --     "folke/trouble.nvim",
  --     "nvim-telescope/telescope.nvim"
  --   },
  --   keys = {
  --     { "<leader>cc", "<cmd>ChatGPT<CR>", desc = "ChatGPT" },
  --     { "<leader>ce", "<cmd>ChatGPTEditWithInstruction<CR>", desc = "Edit with instruction", mode = { "n", "v" } },
  --     { "<leader>cg", "<cmd>ChatGPTRun grammar_correction<CR>", desc = "Grammar Correction", mode = { "n", "v" } },
  --     { "<leader>ct", "<cmd>ChatGPTRun translate<CR>", desc = "Translate", mode = { "n", "v" } },
  --     { "<leader>ck", "<cmd>ChatGPTRun keywords<CR>", desc = "Keywords", mode = { "n", "v" } },
  --     { "<leader>cd", "<cmd>ChatGPTRun docstring<CR>", desc = "Docstring", mode = { "n", "v" } },
  --     { "<leader>ca", "<cmd>ChatGPTRun add_tests<CR>", desc = "Add Tests", mode = { "n", "v" } },
  --     { "<leader>co", "<cmd>ChatGPTRun optimize_code<CR>", desc = "Optimize Code", mode = { "n", "v" } },
  --     { "<leader>cs", "<cmd>ChatGPTRun summarize<CR>", desc = "Summarize", mode = { "n", "v" } },
  --     { "<leader>cf", "<cmd>ChatGPTRun fix_bugs<CR>", desc = "Fix Bugs", mode = { "n", "v" } },
  --     { "<leader>cx", "<cmd>ChatGPTRun explain_code<CR>", desc = "Explain Code", mode = { "n", "v" } },
  --     { "<leader>cr", "<cmd>ChatGPTRun roxygen_edit<CR>", desc = "Roxygen Edit", mode = { "n", "v" } },
  --     {
  --       "<leader>cl",
  --       "<cmd>ChatGPTRun code_readability_analysis<CR>",
  --       desc = "Code Readability Analysis",
  --       mode = { "n", "v" },
  --     },
  --   },
  -- },
}
