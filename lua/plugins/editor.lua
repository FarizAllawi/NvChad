local Icons = require("tweaks").icons
local Logos = require("tweaks").logos
local Utils = require "utils"

return {

  -- Common library used by many plugins
  { "nvim-lua/plenary.nvim", lazy = true },

  {
    "ray-x/lsp_signature.nvim",
    event = { "InsertEnter" },
    opts = {
      floating_window = false, -- show hint in a floating window, set to false for virtual text only mode
      floating_window_above_cur_line = true, -- try to place the floating above the current line when possible Note:
      hint_scheme = "Comment", -- highlight group for the virtual text
    },
  },

  {
    "echasnovski/mini.pairs",
    event = "VeryLazy",
    opts = {},
  },

  -- comments
  { "JoosepAlviste/nvim-ts-context-commentstring", lazy = false },
  {
    "echasnovski/mini.comment",
    event = "BufEnter",
    opts = {
      options = {
        custom_commentstring = function()
          return require("ts_context_commentstring.internal").calculate_commentstring() or vim.bo.commentstring
        end,
      },
    },
  },

  {
    "rcarriga/nvim-notify",
    keys = {
      {
        "<leader>n",
        function()
          require("notify").dismiss { silent = true, pending = true }
        end,
        desc = "Delete all Notifications",
      },
    },
    opts = {
      icons = {
        ERROR = Icons.diagnostics.error .. " ",
        INFO = Icons.diagnostics.info .. " ",
        WARN = Icons.diagnostics.warn .. " ",
      },
      timeout = 3000,
      max_height = function()
        return math.floor(vim.o.lines * 0.75)
      end,
      max_width = function()
        return math.floor(vim.o.columns * 0.75)
      end,
    },
    init = function()
      if not Utils.plugin.has "noice.nvim" then
        Utils.on_very_lazy(function()
          vim.notify = require "notify"
        end)
      end
    end,
  },

  -- Fold
  {
    "kevinhwang91/nvim-ufo",
    event = { "BufReadPost", "BufNewFile", "BufWritePre" },
    dependencies = { "kevinhwang91/promise-async", event = "BufReadPost" },
    opts = {
      fold_virt_text_handler = function(virtText, lnum, endLnum, width, truncate)
        local newVirtText = {}
        local suffix = ("  … %d "):format(endLnum - lnum)
        local sufWidth = vim.fn.strdisplaywidth(suffix)
        local targetWidth = width - sufWidth
        local curWidth = 0
        for _, chunk in ipairs(virtText) do
          local chunkText = chunk[1]
          local chunkWidth = vim.fn.strdisplaywidth(chunkText)
          if targetWidth > curWidth + chunkWidth then
            table.insert(newVirtText, chunk)
          else
            chunkText = truncate(chunkText, targetWidth - curWidth)
            local hlGroup = chunk[2]
            table.insert(newVirtText, { chunkText, hlGroup })
            chunkWidth = vim.fn.strdisplaywidth(chunkText)
            -- str width returned from truncate() may less than 2nd argument, need padding
            if curWidth + chunkWidth < targetWidth then
              suffix = suffix .. (" "):rep(targetWidth - curWidth - chunkWidth)
            end
            break
          end
          curWidth = curWidth + chunkWidth
        end
        table.insert(newVirtText, { suffix, "MoreMsg" })
        return newVirtText
      end,
      open_fold_hl_timeout = 0,
    },
    keys = {
      { "fd", "zd", desc = "Delete fold under cursor" },
      { "fo", "zo", desc = "Open fold under cursor" },
      { "fO", "zO", desc = "Open all folds under cursor" },
      { "fc", "zC", desc = "Close all folds under cursor" },
      { "fa", "za", desc = "Toggle fold under cursor" },
      { "fA", "zA", desc = "Toggle all folds under cursor" },
      { "fv", "zv", desc = "Show cursor line" },
      {
        "fM",
        function()
          require("ufo").closeAllFolds()
        end,
        desc = "Close all folds",
      },
      {
        "fR",
        function()
          require("ufo").openAllFolds()
        end,
        desc = "Open all folds",
      },
      {
        "fm",
        function()
          require("ufo").closeFoldsWith()
        end,
        desc = "Fold more",
      },
      {
        "fr",
        function()
          require("ufo").openFoldsExceptKinds()
        end,
        desc = "Fold less",
      },
      { "fx", "zx", desc = "Update folds" },
      { "fz", "zz", desc = "Center this line" },
      { "ft", "zt", desc = "Top this line" },
      { "fb", "zb", desc = "Bottom this line" },
      { "fg", "zg", desc = "Add word to spell list" },
      { "fw", "zw", desc = "Mark word as bad/misspelling" },
      { "fe", "ze", desc = "Right this line" },
      { "fE", "zE", desc = "Delete all folds in current buffer" },
      { "fs", "zs", desc = "Left this line" },
      { "fH", "zH", desc = "Half screen to the left" },
      { "fL", "zL", desc = "Half screen to the right" },
    },
  },

  {
    "luukvbaal/statuscol.nvim",
    event = { "VimEnter" }, -- Enter when on Vim startup to setup folding correctly (Avoid number in fold column)
    commit = (function()
      if vim.fn.has "nvim-0.9" == 1 then
        return "483b9a596dfd63d541db1aa51ee6ee9a1441c4cc"
      end
    end)(),
    config = function()
      local builtin = require "statuscol.builtin"
      require("statuscol").setup {
        relculright = false,
        ft_ignore = { "neo-tree" },
        segments = {
          {
            -- line number
            text = { " ", builtin.lnumfunc },
            condition = { true, builtin.not_empty },
            click = "v:lua.ScLa",
          },
          { text = { "%s" }, click = "v:lua.ScSa" }, -- Sign
          { text = { builtin.foldfunc, " " }, click = "v:lua.ScFa" }, -- Fold
        },
      }
      vim.api.nvim_create_autocmd({ "BufEnter" }, {
        callback = function()
          if vim.bo.filetype == "neo-tree" then
            vim.opt_local.statuscolumn = ""
          end
        end,
      })
    end,
  },

  -- noicer ui
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
      cmdline = {
        enabled = true,
        view = "cmdline",
        format = {
          cmdline = { icon = "  " },
          search_down = { icon = " 🔍 󰄼" },
          search_up = { icon = " 🔍 " },
          help = { icon = " 󰋖" },
          lua = { icon = "  " },
        },
      },
      lsp = {
        progress = {
          enabled = true,
          format = "lsp_progress",
          format_done = "lsp_progress_done",
          view = "mini",
        },
        hover = { enabled = false },
        signature = { enabled = false },
        -- override markdown rendering so that **cmp** and other plugins use **treesitter**
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true,
        },
      },
      presets = {
        lsp_doc_border = true, -- add a border to hover docs and signature help
      },
      routes = {
        {
          filter = {
            event = "msg_show",
            any = {
              { find = "%d+l, %d+b" },
              { find = "no active snippet" },
              { find = "; after #%d+" },
              { find = "; before #%d+" },
              { find = "hunk" },
            },
          },
          view = "mini",
        },
        {
          filter = {
            event = "notify",
            any = {
              { find = "no information available" },
            },
          },
        },
      },
    },
  },

  -- better vim.ui
  {
    "stevearc/dressing.nvim",
    event = { "BufReadPost", "BufNewFile" },
    opts = function()
      local border_style = vim.tbl_contains({}, "float_win") and "rounded" or "thick"
      return {
        input = {
          border = Utils.ui.borderchars(border_style, "tl-t-tr-r-br-b-bl-l"),
          win_options = { winblend = 0 },
        },
      }
    end,
    init = function()
      vim.ui.select = function(...)
        ---@diagnostic disable-next-line: different-requires
        require("lazy").load { plugins = { "dressing.nvim" } }
        return vim.ui.select(...)
      end
      vim.ui.input = function(...)
        ---@diagnostic disable-next-line: different-requires
        require("lazy").load { plugins = { "dressing.nvim" } }
        return vim.ui.input(...)
      end
    end,
  },

  {
    "stevearc/dressing.nvim",
    event = { "BufReadPost", "BufNewFile" },
    opts = function()
      local monokai_opts = Utils.plugin.opts "monokai-pro.nvim"
      local border_style = vim.tbl_contains(monokai_opts.background_clear or {}, "float_win") and "rounded" or "thick"
      return {
        input = {
          border = Utils.ui.borderchars(border_style, "tl-t-tr-r-br-b-bl-l"),
          win_options = { winblend = 0 },
        },
      }
    end,
    init = function()
      vim.ui.select = function(...)
        ---@diagnostic disable-next-line: different-requires
        require("lazy").load { plugins = { "dressing.nvim" } }
        return vim.ui.select(...)
      end
      vim.ui.input = function(...)
        ---@diagnostic disable-next-line: different-requires
        require("lazy").load { plugins = { "dressing.nvim" } }
        return vim.ui.input(...)
      end
    end,
  },

  {
    "nvimdev/dashboard-nvim",
    event = "VimEnter",
    dependencies = { { "nvim-tree/nvim-web-devicons" } },
    keys = { { "<leader>0", "<cmd>Dashboard<CR>", desc = "Dashboard" } },
    opts = function()
      local opts = {
        theme = "doom",
        hide = {
          statusline = 0,
          tabline = 0,
          winbar = 0,
        },
        config = {
          header = Logos(),
          center = {
            {
              action = "Telescope oldfiles",
              desc = "Recent Files",
              key = "r",
              icon = " ",
              icon_hl = "DashboardRecent",
              key_hl = "DashboardRecent",
            },
            {
              action = "lua require('persistence').load({last = true})",
              desc = "Last Session",
              key = "s",
              icon = " ",
              icon_hl = "DashboardSession",
              key_hl = "DashboardSession",
            },
            {
              icon = " ",
              icon_hl = "DashboardConfiguration",
              desc = "Configuration",
              key = "i",
              key_hl = "DashboardConfiguration",
              action = "edit $MYVIMRC",
            },
            {
              icon = "󰤄 ",
              icon_hl = "DashboardLazy",
              desc = "Lazy",
              key = "l",
              key_hl = "DashboardLazy",
              action = "Lazy",
            },
            {
              icon = " ",
              icon_hl = "DashboardServer",
              desc = "Mason",
              key = "m",
              key_hl = "DashboardServer",
              action = "Mason",
            },
            {
              icon = " ",
              icon_hl = "DashboardQuit",
              desc = "Quit Neovim",
              key = "q",
              key_hl = "DashboardQuit",
              action = "qa",
            },
          },
          footer = function()
            ---@diagnostic disable-next-line: different-requires
            local stats = require("lazy").stats()
            local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
            return {
              "⚡  eovim loaded " .. stats.loaded .. "/" .. stats.count .. " plugins in " .. ms .. "ms",
            }
          end,
        },
      }
      for _, button in pairs(opts.config.center) do
        button.desc = button.desc .. string.rep(" ", 45 - #button.desc)
        button.icon = button.icon .. string.rep(" ", 5 - #button.icon)
      end

      -- close Lazy and re-open when the dashboard is ready
      if vim.o.filetype == "lazy" then
        vim.cmd.close()
        vim.api.nvim_create_autocmd("User", {
          pattern = "DashboardLoaded",
          callback = function()
            ---@diagnostic disable-next-line: different-requires
            require("lazy").show()
          end,
        })
      end
      return opts
    end,
  },
}
