local api = vim.api
local home = vim.env.HOME
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
end

vim.opt.rtp:prepend(lazypath)
-- require("config.lazy")
require("lazy").setup({
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    keys = {
      {
        "<leader>lg",
        function()
          Snacks.lazygit.open()
        end,
        desc = "LazyGit",
      },
      {
        "<leader><leader>f",
        function()
          Snacks.picker.git_files()
        end,
        desc = "Git Files",
      },
      {
        "<leader>fl",
        function()
          Snacks.picker.grep()
        end,
        desc = "Live Grep",
      },
      {
        "<leader>ff",
        function()
          Snacks.picker.smart()
        end,
        desc = "Recent Files",
      },
      {
        "<leader>fb",
        function()
          Snacks.picker.buffers()
        end,
        desc = "Buffers",
      },
      {
        "<leader>fm",
        function()
          Snacks.picker.man()
        end,
        desc = "Man Pages",
      },
      {
        "<leader>fk",
        function()
          Snacks.picker.keymaps()
        end,
        desc = "Keymaps",
      },
      {
        "<leader>fh",
        function()
          Snacks.picker.help()
        end,
        desc = "Help Tags",
      },
    },
    opts = {
      dashboard = {
        preset = {
          keys = {
            {
              icon = "󰮗 ",
              key = "f",
              desc = "Find File",
              action = ":lua Snacks.dashboard.pick('files')",
            },
            {
              icon = " ",
              key = "e",
              desc = "New File",
              action = ":ene | startinsert",
            },
            {
              icon = " ",
              key = "c",
              desc = "Configuration",
              action = ":e ~/.config/nvim/init.lua",
            },
            {
              icon = " ",
              key = "u",
              desc = "Update Plugins",
              action = ":Lazy sync",
            },
            {
              icon = " ",
              key = "r",
              desc = "Recent Files",
              action = ":lua Snacks.dashboard.pick('oldfiles')",
            },
            -- { icon = " ", key = "s", desc = "Restore Session", section = "session" },
            {
              icon = "󰗼 ",
              key = "q",
              desc = "Quit",
              action = ":qa",
            },
          },
          header = [[

  ██████   █████                   █████   █████  ███
 ░░██████ ░░███                   ░░███   ░░███  ░░░
  ░███░███ ░███   ██████   ██████  ░███    ░███  ████  █████████████
  ░███░░███░███  ███░░███ ███░░███ ░███    ░███ ░░███ ░░███░░███░░███
  ░███ ░░██████ ░███████ ░███ ░███ ░░███   ███   ░███  ░███ ░███ ░███
  ░███  ░░█████ ░███░░░  ░███ ░███  ░░░█████░    ░███  ░███ ░███ ░███
  █████  ░░█████░░██████ ░░██████     ░░███      █████ █████░███ █████
 ░░░░░    ░░░░░  ░░░░░░   ░░░░░░       ░░░      ░░░░░ ░░░░░ ░░░ ░░░░░

                     λ it be like that sometimes λ                     ]],
        },
        formats = {
          header = { "%s", align = "center", hl = "GruvboxYellow" },
          icon = { "%s", hl = "normal" },
          desc = { "%s", hl = "normal" },
          key = { "%s", hl = "GruvboxRed" },
        },
        sections = {
          { section = "header" },
          { section = "keys", gap = 1, padding = 1 },
          {
            section = "terminal",
            ttl = 0, -- disable cache
            cmd = "fortune -s",
            hl = "SnacksDashboardKey",
          },
        },
      },
      bigfile = { enabled = true },
      quickfile = { enabled = true },
      lazygit = { win = { width = 0, height = 0 } },
      picker = {
        matcher = {
          cwd_bonus = true,
          frecency = true,
          history_bonus = true,
        },
        layout = { preset = "ivy" },
        win = {
          input = { keys = { ["<Esc>"] = { "close", mode = { "n", "i" } } } },
        },
      },
      indent = {
        enabled = true,
        char = "│",
        only_scope = false,
        only_current = false,
        scope = {
          enabled = true,
          priority = 200,
          char = "│",
          underline = true,
          only_current = false,
          hl = "SnacksIndentScope",
        },
        animate = {
          enabled = vim.fn.has("nvim-0.10") == 1,
          style = "out",
          easing = "outQuad",
          duration = { step = 20, total = 400 },
        },
        chunk = {
          enabled = true,
          only_current = false,
          priority = 200,
          hl = "SnacksIndentChunk",
          char = {
            corner_top = "╭",
            corner_bottom = "╰",
            horizontal = "─",
            vertical = "│",
            arrow = ">",
          },
        },
      },
      -- picker = { enabled = true },
    },
  },
  {
    "zbirenbaum/copilot.lua",
    requires = {
      "copilotlsp-nvim/copilot-lsp", -- (optional) for NES functionality
    },
    cmd = "Copilot",
    event = "InsertEnter",
  },
  {
    "nvim-mini/mini.pairs",
    event = "VeryLazy",
    opts = {
      modes = { insert = true, command = true, terminal = false },
      -- skip autopair when next character is one of these
      skip_next = [=[[%w%%%'%[%"%.%`%$]]=],
      -- skip autopair when the cursor is inside these treesitter nodes
      skip_ts = { "string" },
      -- skip autopair when next character is closing pair
      -- and there are more closing pairs than opening pairs
      skip_unbalanced = true,
      -- better deal with markdown code blocks
      markdown = true,
    },
  },
  {
    "folke/ts-comments.nvim",
    event = "VeryLazy",
    opts = {},
  },
  {
    "ellisonleao/gruvbox.nvim", -- theme
    priority = 1000,
    config = function()
      require("gruvbox").setup({
        -- transparent_mode = true,
        contrast = "hard",
        palette_overrides = { dark0_hard = "#0E1018" },
        overrides = {
          NormalFloat = { fg = "#ebdbb2", bg = "#504945" },
          Comment = { fg = "#81878f", italic = true, bold = true },
          Define = { link = "GruvboxPurple" },
          Macro = { link = "GruvboxPurple" },
          ["@constant.builtin"] = { link = "GruvboxPurple" },
          ["@storageclass.lifetime"] = { link = "GruvboxAqua" },
          ["@text.note"] = { link = "TODO" },
          ["@namespace.rust"] = { link = "Include" },
          ["@punctuation.bracket"] = { link = "GruvboxOrange" },
          texMathDelimZoneLI = { link = "GruvboxOrange" },
          texMathDelimZoneLD = { link = "GruvboxOrange" },
          luaParenError = { link = "luaParen" },
          luaError = { link = "NONE" },
          ContextVt = { fg = "#878788" },
          CopilotSuggestion = { fg = "#878787" },
          CocCodeLens = { fg = "#878787" },
          CocWarningFloat = { fg = "#dfaf87" },
          CocInlayHint = { fg = "#ABB0B6" },
          CocPumShortcut = { fg = "#fe8019" },
          CocPumDetail = { fg = "#fe8019" },
          DiagnosticVirtualTextWarn = { fg = "#dfaf87" },
          -- fold
          Folded = { fg = "#fe8019", bg = "#0E1018", italic = true },
          SignColumn = { bg = "#fe8019" },
          -- new git colors
          DiffAdd = {
            bold = true,
            reverse = false,
            fg = "",
            bg = "#2a4333",
          },
          DiffChange = {
            bold = true,
            reverse = false,
            fg = "",
            bg = "#333841",
          },
          DiffDelete = {
            bold = true,
            reverse = false,
            fg = "#442d30",
            bg = "#442d30",
          },
          DiffText = {
            bold = true,
            reverse = false,
            fg = "",
            bg = "#213352",
          },
          -- statusline
          StatusLine = { bg = "#ffffff", fg = "#0E1018" },
          StatusLineNC = { bg = "#3c3836", fg = "#0E1018" },
          CursorLineNr = { fg = "#fabd2f", bg = "" },
          GruvboxOrangeSign = { fg = "#dfaf87", bg = "#0E1018" },
          GruvboxAquaSign = { fg = "#8EC07C", bg = "#0E1018" },
          GruvboxGreenSign = { fg = "#b8bb26", bg = "#0E1018" },
          GruvboxRedSign = { fg = "#fb4934", bg = "#0E1018" },
          GruvboxBlueSign = { fg = "#83a598", bg = "#0E1018" },
          WilderMenu = { fg = "#ebdbb2", bg = "" },
          WilderAccent = { fg = "#f4468f", bg = "" },
          -- coc semantic token
          CocSemStruct = { link = "GruvboxYellow" },
          CocSemKeyword = { fg = "", bg = "#0E1018" },
          CocSemEnumMember = { fg = "", bg = "#0E1018" },
          CocSemTypeParameter = { fg = "", bg = "#0E1018" },
          CocSemComment = { fg = "", bg = "#0E1018" },
          CocSemMacro = { fg = "", bg = "#0E1018" },
          CocSemVariable = { fg = "", bg = "#0E1018" },
          CocSemFunction = { fg = "", bg = "#0E1018" },
          SnacksPicker = { fg = "#ebdbb2", bg = "#0E1018" },
          SnacksPickerBorder = { fg = "#ebdbb2", bg = "#0E1018" },
          SnacksPickerBoxBorder = { fg = "#ebdbb2", bg = "#0E1018" },
          SnacksNormal = { fg = "#ebdbb2", bg = "#0E1018" },
          -- neorg
          ["@neorg.markup.inline_macro"] = { link = "GruvboxGreen" },
        },
      })
      --vim.cmd.colorscheme("gruvbox")
    end,
  },
  { "lervag/vimtex" },
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    cmd = "Neotree",
    keys = {
      { "tt", ":Neotree toggle<CR>", desc = "Toggle File Explorer" },
    },
    config = function()
      require("neo-tree").setup({
        close_if_last_window = true,
        popup_border_style = "rounded",
        enable_git_status = true,
        enable_diagnostics = true,
        filesystem = { follow_current_file = true },
      })
    end,
  },
  {
    "nmac427/guess-indent.nvim", -- guess indent
    config = function()
      require("guess-indent").setup({})
    end,
  },
  { "akinsho/toggleterm.nvim" },
  {
    "stevearc/conform.nvim",
    opts = {},
  },
  {
    "okuuva/auto-save.nvim",
    version = "^1.0.0", -- see https://devhints.io/semver, alternatively use '*' to use the latest tagged release
    cmd = "ASToggle", -- optional for lazy loading on command
    event = { "InsertLeave", "TextChanged" }, -- optional for lazy loading on trigger events
    opts = {
      -- your config goes here
      -- or just leave it empty :)
    },
  },
  { "mason-org/mason.nvim" },
  { "mason-org/mason-lspconfig.nvim", config = function() end },
  -- { "neovim/nvim-lspconfig" },
  { "nvim-treesitter/nvim-treesitter", branch = "main", lazy = false, build = ":TSUpdate" },
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    ---@module "ibl"
    ---@type ibl.config
    opts = {},
  },
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      preset = "helix",
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    },
    keys = {
      {
        "<leader>?",
        function()
          require("which-key").show({ global = false })
        end,
        desc = "Buffer Local Keymaps (which-key)",
      },
    },
  },
  { "akinsho/bufferline.nvim", version = "*", dependencies = "nvim-tree/nvim-web-devicons" },
  {
    "folke/trouble.nvim",
    opts = {}, -- for default options, refer to the configuration section for custom setup.
    cmd = "Trouble",
    keys = {
      {
        "<leader>xx",
        "<cmd>Trouble diagnostics toggle<cr>",
        desc = "Diagnostics (Trouble)",
      },
      {
        "<leader>xX",
        "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
        desc = "Buffer Diagnostics (Trouble)",
      },
      {
        "<leader>cs",
        "<cmd>Trouble symbols toggle focus=false<cr>",
        desc = "Symbols (Trouble)",
      },
      {
        "<leader>cl",
        "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
        desc = "LSP Definitions / references / ... (Trouble)",
      },
      {
        "<leader>xL",
        "<cmd>Trouble loclist toggle<cr>",
        desc = "Location List (Trouble)",
      },
      {
        "<leader>xQ",
        "<cmd>Trouble qflist toggle<cr>",
        desc = "Quickfix List (Trouble)",
      },
    },
  },
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
  },
  {
    "AlphaTechnolog/pywal.nvim",
  },
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
      "kdheepak/cmp-latex-symbols",
    },
  },
  {
    "nvimtools/none-ls.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
  },
  {
    "atdma/caelestia-nvim",
    priority = 1000, -- Load before other plugins
    lazy = false, -- Load on startup
    opts = {}, -- Automatically calls require("caelestia").setup()
    config = function(_, opts)
      require("caelestia").setup(opts)
      vim.cmd.colorscheme("caelestia")
    end,
  },
  {
    "lewis6991/gitsigns.nvim",
    opts = {
      signs = {
        add = { text = "▎" },
        change = { text = "▎" },
        delete = { text = "" },
        topdelete = { text = "" },
        changedelete = { text = "▎" },
      },
      numhl = true, -- highlights the line number instead of sign column
      current_line_blame = true, -- inline git blame, toggle with <leader>tb
    },
  },
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = { signs = false }, -- less noise since Trouble will surface them
    keys = {
      { "<leader>xt", "<cmd>Trouble todo toggle<cr>", desc = "Todo (Trouble)" },
    },
  },
  { "folke/flash.nvim", event = "VeryLazy", opts = {} },
  { "kylechui/nvim-surround", event = "VeryLazy", opts = {} },
  {
    "GCBallesteros/jupytext.nvim",
    opts = {
      style = "hydrogen", -- uses # %% cell markers, works well with pylsp
      output_extension = "py", -- open notebooks as .py
      force_ft = "python", -- make sure treesitter/lsp kicks in
    },
  },
  { "Bekaboo/dropbar.nvim", dependencies = { "nvim-telescope/telescope-fzf-native.nvim" } },
  {
    "benlubas/molten-nvim",
    version = "^1.0.0", -- use version <2.0.0 to avoid breaking changes
    dependencies = { "3rd/image.nvim" },
    build = ":UpdateRemotePlugins",
    init = function()
      -- these are examples, not defaults. Please see the readme
      vim.g.molten_image_provider = "image.nvim"
      vim.g.molten_output_win_max_height = 20
    end,
  },
  {
    -- see the image.nvim readme for more information about configuring this plugin
    "3rd/image.nvim",
    opts = {
      backend = "kitty", -- whatever backend you would like to use
      max_width = 100,
      max_height = 12,
      max_height_window_percentage = math.huge,
      max_width_window_percentage = math.huge,
      window_overlap_clear_enabled = true, -- toggles images when windows are overlapped
      window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "" },
    },
  },
})

-- require("pywal").setup()
-- Theme stuff
vim.opt.termguicolors = true
-- vim.cmd("colorscheme default")
-- require("dynamic").setup()
--

-- Setup kitty opacity:
-- Robust Kitty opacity toggle
local function set_kitty_opacity(opacity)
  local socket = os.getenv("KITTY_LISTEN_ON")
  if socket then
    -- Using schedule ensures the UI is ready before we talk to the terminal
    vim.schedule(function()
      vim.fn.system({ "kitty", "@", "--to", socket, "set-background-opacity", opacity })
    end)
  end
end

vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    set_kitty_opacity("1.0")
  end,
})

vim.api.nvim_create_autocmd("VimLeave", {
  callback = function()
    set_kitty_opacity("0.85")
  end,
})

require("lualine").setup({
  options = {
    icons_enabled = true,
    -- theme = "caelestia",
    component_separators = {},
    section_separators = { left = "", right = "" },
    disabled_filetypes = {
      statusline = {},
      winbar = {},
    },
    ignore_focus = {},
    always_divide_middle = true,
    always_show_tabline = true,
    globalstatus = false,
    refresh = {
      statusline = 1000,
      tabline = 1000,
      winbar = 1000,
      refresh_time = 16, -- ~60fps
      events = {
        "WinEnter",
        "BufEnter",
        "BufWritePost",
        "SessionLoadPost",
        "FileChangedShellPost",
        "VimResized",
        "Filetype",
        "CursorMoved",
        "CursorMovedI",
        "ModeChanged",
      },
    },
  },
  sections = {
    lualine_a = { "mode" },
    lualine_b = { "branch", "diff", "diagnostics" },
    lualine_c = { "filename" },
    lualine_x = { "encoding", "fileformat", "filetype" },
    lualine_y = { "progress" },
    lualine_z = { "location" },
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = { "filename" },
    lualine_x = { "location" },
    lualine_y = {},
    lualine_z = {},
  },
  tabline = {},
  winbar = {},
  inactive_winbar = {},
  extensions = {},
})
require("bufferline").setup({
  options = {
    diagnostics = "coc",
  },
})
require("ibl").setup()
require("mason").setup()
require("copilot").setup()
require("conform").setup({
  formatters_by_ft = {
    lua = { "stylua" },
    python = { "black" },
    latex = { "tex-fmt" },
    -- You can customize some of the format options for the filetype (:help conform.format)
    -- rust = { "rustfmt", lsp_format = "fallback" },
    -- Conform will run the first available formatter
    -- javascript = { "prettierd", "prettier", stop_after_first = true },
  },
})
require("toggleterm").setup({
  open_mapping = [[<c-`>]],
  direction = "horizontal",
  size = 15,
  shade_terminals = true,
})

vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  callback = function(args)
    require("conform").format({ bufnr = args.buf })
  end,
})

vim.api.nvim_create_autocmd("BufReadPost", {
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    if mark[1] > 0 and mark[1] <= vim.api.nvim_buf_line_count(0) then
      vim.api.nvim_win_set_cursor(0, mark)
    end
  end,
})
vim.opt.shada = "!,'100,<50,s10,h"

vim.api.nvim_create_autocmd("ColorScheme", {
  callback = function()
    -- local hl = vim.api.nvim_get_hl(0, { name = "@punctuation.bracket", link = false })
    local hl = vim.api.nvim_get_hl(0, { name = "Keyword", link = false })
    if not hl.fg then
      hl = vim.api.nvim_get_hl(0, { name = "Delimiter", link = false })
    end
    local fg = hl.fg and string.format("#%06x", hl.fg) or "#80a0ff"

    vim.api.nvim_set_hl(0, "SnacksIndent1", { fg = fg, nocombine = true })
    vim.api.nvim_set_hl(0, "SnacksIndent2", { fg = fg, nocombine = true })
    vim.api.nvim_set_hl(0, "SnacksIndentChunk", { fg = fg, bold = true, nocombine = true })
    -- vim.api.nvim_set_hl(0, "SnacksIndentScope", { fg = fg, bold = true, nocombine = true })
    local normal = vim.api.nvim_get_hl(0, { name = "Normal", link = false })
    local bg = normal.bg and string.format("#%06x", normal.bg) or "NONE"

    vim.api.nvim_set_hl(0, "TabLineFill", { bg = bg })
    vim.api.nvim_set_hl(0, "TabLineSel", { bg = bg, bold = true })
    vim.api.nvim_set_hl(0, "TabLine", { bg = bg, fg = "#666666" })
  end,
})
--require("plugins")

vim.opt.writebackup = false
vim.opt.conceallevel = 2
vim.opt.ignorecase = true -- search case
vim.opt.smartcase = true -- search matters if capital letter
vim.opt.inccommand = "split" -- "for incsearch while sub
vim.opt.lazyredraw = true -- redraw for macros
vim.opt.number = true -- line number on
vim.opt.relativenumber = true -- relative line number on
vim.opt.undofile = true -- undo even when it closes
vim.opt.foldmethod = "expr" -- treesiter time
vim.opt.foldexpr = "nvim_treesitter#foldexpr()" -- treesiter
vim.opt.foldtext = ""
vim.opt.scrolloff = 8 -- number of lines to always go down
vim.opt.signcolumn = "number"
vim.opt.colorcolumn = "99999" -- fix columns
vim.opt.mouse = "a" -- set mouse to be on
vim.opt.shortmess:append("c") -- no ins-completion messages
vim.o.sessionoptions = "blank,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"
-- vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"
-- vim.opt.cmdheight = 0 -- status line smaller
vim.opt.laststatus = 3
vim.opt.breakindent = true -- break indentation for long lines
vim.opt.breakindentopt = { shift = 2 }
vim.opt.showbreak = "↳" -- character for line break
vim.opt.splitbelow = true -- split windows below
vim.opt.splitright = true -- split windows right
vim.opt.wildmode = "list:longest,list:full" -- for : stuff
vim.opt.wildignore:append({ ".javac", "node_modules", "*.pyc" })
vim.opt.wildignore:append({ ".aux", ".out", ".toc" }) -- LaTeX
vim.opt.wildignore:append({
  ".o",
  ".obj",
  ".dll",
  ".exe",
  ".so",
  ".a",
  ".lib",
  ".pyc",
  ".pyo",
  ".pyd",
  ".swp",
  ".swo",
  ".class",
  ".DS_Store",
  ".git",
  ".hg",
  ".orig",
})
vim.opt.suffixesadd:append({ ".java", ".rs" }) -- search for suffexes using gf
vim.opt.diffopt = "filler,internal,closeoff,algorithm:histogram,context:5,linematch:60"
vim.opt.cursorline = true
vim.opt.cursorlineopt = "number"
vim.opt.showmode = false
vim.opt.virtualedit = "all"
vim.opt.shell = "/usr/bin/fish"
vim.opt.clipboard = "unnamedplus"

-- LaTeX stuff
vim.g.vimtex_quickfix_mode = 0
vim.g.vimtex_compiler_method = "pdflatex"

vim.g.vimtex_indent_on_ampersands = 0
vim.g.vimtex_view_method = "sioyek"
vim.g.matchup_override_vimtex = 1

-- Auto-completion with nvim-cmp
local cmp = require("cmp")
local luasnip = require("luasnip")

cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = {
    ["<Up>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { "i", "s" }),
    ["<Down>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { "i", "s" }),
    ["<Tab>"] = cmp.mapping.confirm({ select = true }),
  },
  -- mapping = {
  --   ["<Tab>"] = cmp.mapping(function(fallback)
  --     if cmp.visible() then
  --       cmp.select_next_item()
  --     elseif luasnip.expand_or_jumpable() then
  --       luasnip.expand_or_jump()
  --     else
  --       fallback()
  --     end
  --   end, { "i", "s" }),
  --   ["<S-Tab>"] = cmp.mapping(function(fallback)
  --     if cmp.visible() then
  --       cmp.select_prev_item()
  --     elseif luasnip.jumpable(-1) then
  --       luasnip.jump(-1)
  --     else
  --       fallback()
  --     end
  --   end, { "i", "s" }),
  --   ["<CR>"] = cmp.mapping.confirm({ select = true }),
  -- },
  sources = cmp.config.sources({
    { name = "nvim_lsp" },
    { name = "luasnip" },
    { name = "latex_symbols" },
  }, {
    { name = "buffer" },
  }),
})

local capabilities = require("cmp_nvim_lsp").default_capabilities()

local servers = {
  pylsp = {
    cmd = { "pylsp" },
    filetypes = { "python" },
    root_markers = {
      "pyproject.toml",
      "setup.py",
      "setup.cfg",
      "requirements.txt",
      "Pipfile",
      ".git",
    },
    settings = {
      pylsp = {
        plugins = {
          jedi_hover = { enabled = true },
          jedi_completion = { enabled = true },
          jedi_references = { enabled = true },
          jedi_signature_help = { enabled = true },
          pyflakes = { enabled = true },
          autopep8 = { enabled = false },
          yapf = { enabled = false },
          mccabe = { enabled = false },
          black = { enabled = true },
        },
      },
    },
  },

  digestif = {
    cmd = { "digestif" },
    filetypes = { "tex", "plaintex" },
  },

  qml = {
    cmd = { "qml-language-server" },
    filetypes = { "qml" },
    root_markers = {
      "qmldir",
      "qml",
      "shell.qml",
      "CMakeLists.txt",
      ".git",
    },
  },
}

for name, config in pairs(servers) do
  config.capabilities = capabilities

  vim.lsp.config(name, config)
  vim.lsp.enable(name)
end

local null_ls = require("null-ls")

null_ls.setup({
  sources = {
    null_ls.builtins.diagnostics.languagetool.with({
      filetypes = { "markdown", "tex", "latex" },
      args = {
        "--api-url",
        "http://localhost:8010/v2/check", -- Pointing to your systemd port override
        "--language",
        "en-US",
      },
    }),
    null_ls.builtins.diagnostics.proselint.with({
      filetypes = {
        "markdown",
        "text",
        "tex",
      },
    }),
  },
})

vim.lsp.handlers["textDocument/hover"] = function(err, result, ctx, config)
  config = vim.tbl_deep_extend("force", config or {}, {
    border = "rounded",
    max_width = 80,
  })

  return vim.lsp.handlers.hover(err, result, ctx, config)
end

-- === DIAGNOSTICS CONFIG ===
vim.diagnostic.config({
  -- 💬 short inline summary
  virtual_text = {
    prefix = "💬",
    spacing = 2,
    format = function(diagnostic)
      -- flatten multiline messages
      local msg = diagnostic.message:gsub("\n", " ")
      -- truncate long messages
      if #msg > 60 then
        msg = msg:sub(1, 57) .. "..."
      end
      return msg
    end,
  },

  -- 🪟 floating window config
  float = {
    border = "rounded",
    source = "always",
    focusable = false,
    header = "",
    max_width = 80,
    wrap = true,
  },

  underline = true,
  signs = true,
  update_in_insert = false,
  severity_sort = true,
})

-- 🧭 show wrapped diagnostic float when you pause cursor
vim.api.nvim_create_autocmd("CursorHold", {
  callback = function()
    -- diagnostics
    vim.diagnostic.open_float(nil, { focus = false })

    -- LSP hover
    vim.lsp.buf.hover({
      border = "rounded",
      focus = false,
    })
  end,
})

-- 🧩 optional: toggle inline diagnostics
vim.keymap.set("n", "<leader>td", function()
  local vt = vim.diagnostic.config().virtual_text
  vim.diagnostic.config({ virtual_text = not vt })
  print("Inline diagnostics " .. (vt and "disabled" or "enabled"))
end, { desc = "Toggle inline diagnostics" })
