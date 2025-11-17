
-- See:
-- `:help lua-options`
-- `:help lua-options-guide`
-- `:help '<opt.name>'`

-- Diagnostic popup config
-- `:help vim.diagnostic.config()`

-- Persistent undo and backup history
  vim.o.undofile = true
  local state = vim.fn.stdpath("state")
  vim.o.backup   = true
  vim.opt.backupdir = state .. "/backup"

-- Misc.
  vim.o.mouse      = 'a'     -- Enable mouse mode for [a]ll modes
  vim.o.number     = true    -- Line numbers
  -- vim.o.relativenumber = true
  vim.o.cursorline = true    -- Highlight line that cursor is on
  vim.o.showcmd    = true    -- Show command in bottom right
  vim.o.wrap       = false
  vim.o.signcolumn = 'yes'   -- The column left of line numbers
  vim.o.updatetime = 250     -- Decrease swap file update time
  vim.o.timeoutlen = 300     -- Decrease mapped sequence wait time
  vim.o.splitright = true    -- Vsplits open on right
  vim.o.splitbelow = true    -- Hsplits open on bottom
  vim.o.scrolloff  = 10      -- Minimal number of screen lines to keep above and below the cursor.
  vim.o.showmode   = false

-- Sets how neovim will display certain whitespace characters in the editor.
-- vim.o.list = true
-- vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' , eol = '↴'}
-- vim.o.confirm = true       -- Confirm when quitting buffer with :q or :e

-- UI
  vim.o.termguicolors = true    -- Use 24 bit colors
  vim.o.background    = "dark"
  vim.cmd("colorscheme tokyonight-moon")

-- Wildmenu
  vim.o.wildmenu       = true
  vim.opt.wildmode     = { "longest:full", "full" }
  vim.o.wildignorecase = true
  vim.opt.wildignore   = {
    "*.docx",
    "*.jpg",
    "*.png",
    "*.gif",
    "*.pdf",
    "*.pyc",
    "*.exe",
    "*.flv",
    "*.img",
    "*.xlsx",
  }

-- Tabs & indentation
  -- List of file extensions that look better
  -- with 2 space indentation
  local indent_2 = {
    "lua",
    "html",
  }

  vim.api.nvim_create_autocmd({"BufReadPost", "BufNewFile"}, {
    callback = function()
      local filename = vim.api.nvim_buf_get_name(0)
      local ext = filename:match("^.+%.([^.]+)$")

      if ext and vim.tbl_contains(indent_2, ext) then
        vim.opt_local.shiftwidth  = 2
        vim.opt_local.tabstop     = 2
        vim.opt_local.softtabstop = 2
      else
        vim.opt_local.shiftwidth  = 4    -- Indentation in space chars
        vim.opt_local.tabstop     = 4    -- Tab is equal to 4 spaces
        vim.opt_local.softtabstop = 4    -- Backspace deletes 4 spaces
      end
    end
  })

  vim.o.expandtab   = true    -- Pressing Tab inserts spaces
  vim.o.breakindent = true    -- Keep indentation on wrapped lines
  vim.o.autoindent  = true
  vim.o.smartindent = true


-- Use system clipboard
  vim.schedule(function()
    vim.o.clipboard = 'unnamedplus'
  end)

-- Searching
  vim.o.ignorecase = true
  vim.o.smartcase  = true
  vim.o.hlsearch   = true
  vim.o.incsearch  = true

-- Font
  vim.g.have_nerd_font = false

-- Folding
  vim.opt.foldmethod = "syntax"
  vim.opt.foldenable = true

-- Have nerdtree ignore certain files and directories.
  vim.g.NERDTreeIgnore = {
    [[\.git$]],
    [[\.jpg$]],
    [[\.mp4$]],
    [[\.ogg$]],
    [[\.iso$]],
    [[\.pdf$]],
    [[\.pyc$]],
    [[\.odt$]],
    [[\.png$]],
    [[\.gif$]],
    [[\.db$]],
  }

