--[[
lvim is the global options object
Linters should be
filled in as strings with either
a global executable or a path to
an executable
]]
-- Additional Plugins
lvim.plugins = {
  { "pbdeuchler/material.nvim" },
  { "mg979/vim-visual-multi" },
  { "norcalli/nvim-colorizer.lua" },
  { "tiagovla/scope.nvim" },
  { "olexsmir/gopher.nvim" },
  { "leoluz/nvim-dap-go" },
  -- deps for neo tree
  { "nvim-tree/nvim-web-devicons" },
  { "MunifTanjim/nui.nvim" },
  -- end neo tree deps
  -- { "nvim-neo-tree/neo-tree.nvim" },
  -- deps for copiliot
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
  },
  {
    "zbirenbaum/copilot-cmp",
    after = { "copilot.lua" },
    config = function()
      require("copilot_cmp").setup()
    end,
  },
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
}

lvim.builtin.lir.active = false
lvim.builtin.bufferline.active = true

-- general
lvim.log.level = "warn"
lvim.format_on_save.enabled = true
lvim.colorscheme = "material"
vim.g.material_style = "hybrid"

vim.opt.wrap = true

local ok, _ = pcall(require, "material")
if ok then
  require('material').setup({
    plugins = { -- Uncomment the plugins that you use to highlight them
      -- Available plugins:
      -- "dap",
      "dashboard",
      "gitsigns",
      -- "hop",
      -- "indent-blankline",
      "lspsaga",
      -- "mini",
      "neogit",
      -- "nvim-cmp",
      -- "nvim-navic",
      "nvim-tree",
      -- "nvim-web-devicons",
      -- "sneak",
      "telescope",
      -- "trouble",
      "which-key",
    },
    custom_colors = nil, -- If you want to everride the default colors, set this to a function
  })
end

local ok, colorizer = pcall(require, "colorizer")
if ok then
  colorizer.setup()
end

-- keymappings [view all the defaults by pressing <leader>Lk]
lvim.leader = "space"
-- add your own keymapping
lvim.keys.normal_mode["<C-s>"] = ":w<CR>"
-- lvim.keys.normal_mode["<leader>q"] = ":q<cr>"
-- lvim.builtin.which_key.mappings["q"] = ":q<CR>"

-- lvim.keys.normal_mode["<S-l>"] = ":BufferLineCycleNext<CR>"
-- lvim.keys.normal_mode["<S-h>"] = ":BufferLineCyclePrev<CR>"
-- unmap a default keymapping
-- vim.keymap.del("n", "<C-Up>")
-- override a default keymapping
-- lvim.keys.normal_mode["<C-q>"] = ":q<cr>" -- or vim.keymap.set("n", "<C-q>", ":q<cr>" )

lvim.keys.normal_mode["<leader>re"] = ":LvimReload<CR>"
lvim.keys.normal_mode["gt"] = ":BufferLineCycleNext<CR>"
lvim.keys.normal_mode["gT"] = ":BufferLineCyclePrev<CR>"

lvim.keys.normal_mode["<C-q>"] = ":BufferKill<CR>"

-- lvim.keys.normal_mod["<leader>qq"] = ":q"
-- Change Telescope navigation to use j and k for navigation and n and p for history in both input and normal mode.
-- we use protected-mode (pcall) just in case the plugin wasn't loaded yet.
-- local _, actions = pcall(require, "telescope.actions")
-- lvim.builtin.telescope.defaults.mappings = {
--   -- for input mode
--   i = {
--     ["<C-j>"] = actions.move_selection_next,
--     ["<C-k>"] = actions.move_selection_previous,
--     ["<C-n>"] = actions.cycle_history_next,
--     ["<C-p>"] = actions.cycle_history_prev,
--   },
--   -- for normal mode
--   n = {
--     ["<C-j>"] = actions.move_selection_next,
--     ["<C-k>"] = actions.move_selection_previous,
--   },
-- }

-- Change theme settings
-- lvim.builtin.theme.options.dim_inactive = true
-- lvim.builtin.theme.options.style = "storm"

-- Use which-key to add extra bindings with the leader-key prefix
-- lvim.builtin.which_key.mappings["P"] = { "<cmd>Telescope projects<CR>", "Projects" }
-- lvim.builtin.which_key.mappings["t"] = {
--   name = "+Trouble",
--   r = { "<cmd>Trouble lsp_references<cr>", "References" },
--   f = { "<cmd>Trouble lsp_definitions<cr>", "Definitions" },
--   d = { "<cmd>Trouble document_diagnostics<cr>", "Diagnostics" },
--   q = { "<cmd>Trouble quickfix<cr>", "QuickFix" },
--   l = { "<cmd>Trouble loclist<cr>", "LocationList" },
--   w = { "<cmd>Trouble workspace_diagnostics<cr>", "Workspace Diagnostics" },
-- }

-- TODO: User Config for predefined plugins
-- After changing plugin config exit and reopen LunarVim, Run :PackerInstall :PackerCompile
lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "dashboard"
lvim.builtin.terminal.active = true

-- disable netrw at the very start of your init.lua (strongly advised)
vim.g.loaded_netrwPlugin = false
-- vim.g.loaded_netrw = 1
-- vim.g.loaded_netrwPlugin = 1

-- lvim.builtin.nvimtree.active = false -- DISABLES NVIM TREE
-- lvim.builtin.nvimtree.setup.disable_netrw = false
lvim.builtin.nvimtree.setup.hijack_netrw = true
lvim.builtin.nvimtree.setup.hijack_unnamed_buffer_when_opening = true
lvim.builtin.nvimtree.setup.view.adaptive_size = true
lvim.builtin.nvimtree.setup.update_cwd = false -- deprecated
lvim.builtin.nvimtree.setup.sync_root_with_cwd = false
lvim.builtin.nvimtree.setup.prefer_startup_root = true
lvim.builtin.nvimtree.setup.respect_buf_cwd = false
-- lvim.builtin.nvimtree.setup.update_focused_file.enable = false
-- lvim.builtin.nvimtree.setup.update_focused_file.update_cwd = false
lvim.builtin.nvimtree.setup.update_focused_file.update_root = false
-- lvim.builtin.nvimtree.setup.renderer.group_empty = true

lvim.builtin.nvimtree.setup.hijack_directories = {
  enable = true,
  auto_open = true,
}

lvim.builtin.nvimtree.setup.git = {
  enable = true,
  ignore = false,
  show_on_dirs = true,
  timeout = 4000,
}

require("nvim-tree").open_replacing_current_buffer()

-- clipboard
vim.api.nvim_set_option("clipboard", "unnamed")

-- if you don't want all the parsers change this to a table of the ones you want
lvim.builtin.treesitter.ensure_installed = {
  "bash",
  "c",
  "javascript",
  "json",
  "lua",
  "python",
  "go",
  "gomod",
  "hcl",
  "typescript",
  "tsx",
  "css",
  "rust",
  "java",
  "yaml",
  "sql",
}

-- lvim.builtin.treesitter.ignore_install = { "haskell" }
lvim.builtin.treesitter.highlight.enable = true

-- generic LSP settings

-- -- make sure server will always be installed even if the server is in skipped_servers list
lvim.lsp.installer.setup.ensure_installed = {
  "lua_ls",
  "dockerls",
  "gopls",
  "jdtls",
  "jsonls",
  "tsserver",
  "rust_analyzer",
  "terraformls",
  "sqlls",
  "pylsp",
}
-- -- change UI setting of `LspInstallInfo`
-- -- see <https://github.com/williamboman/nvim-lsp-installer#default-configuration>
-- lvim.lsp.installer.setup.ui.check_outdated_servers_on_open = false
-- lvim.lsp.installer.setup.ui.border = "rounded"
-- lvim.lsp.installer.setup.ui.keymaps = {
--     uninstall_server = "d",
--     toggle_server_expand = "o",
-- }

-- ---@usage disable automatic installation of servers
-- lvim.lsp.installer.setup.automatic_installation = true

-- ---configure a server manually. !!Requires `:LvimCacheReset` to take effect!!
-- ---see the full default list `:lua print(vim.inspect(lvim.lsp.automatic_configuration.skipped_servers))`
-- vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "pyright" })
-- local opts = {} -- check the lspconfig documentation for a list of all possible options
-- require("lvim.lsp.manager").setup("pyright", opts)
require("lvim.lsp.manager").setup("rust_analyzer", {
  -- on_attach = on_attach,
  -- flags = lsp_flags,
  -- Server-specific settings...
  settings = {
    ["rust-analyzer"] = {
      -- enable clippy diagnostics on save
      checkOnSave = {
        command = "clippy"
      },
    }
  }
})

require("lvim.lsp.manager").setup("gopls", {
  cmd = { "gopls", "serve" },
  filetypes = { "go", "gomod" },
  -- root_dir = lvim.lsp.manager.util.root_pattern("go.work", "go.mod", ".git"),
  settings = {
    gopls = {
      gofumpt = true,
      analyses = {
        unusedparams = true,
      },
      staticcheck = true,
    },
  },
})

function go_org_imports(wait_ms)
  local params = vim.lsp.util.make_range_params()
  params.context = { only = { "source.organizeImports" } }
  local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, wait_ms)
  for cid, res in pairs(result or {}) do
    for _, r in pairs(res.result or {}) do
      if r.edit then
        local enc = (vim.lsp.get_client_by_id(cid) or {}).offset_encoding or "utf-16"
        vim.lsp.util.apply_workspace_edit(r.edit, enc)
      end
    end
  end
end

vim.api.nvim_command("au BufWritePre *.go lua go_org_imports()")
vim.api.nvim_create_autocmd("BufEnter", {
  pattern = { "*.go" },
  command = "setlocal ts=4 sw=4"
})
vim.api.nvim_command("au BufWritePre *.go lua go_org_imports()")
vim.api.nvim_create_autocmd("BufEnter", {
  pattern = { "*.tgo" },
  command = "setlocal ts=4 sw=4"
})

-- Copilot Configuration
local ok, copilot = pcall(require, "copilot")
if not ok then
  return
end

copilot.setup {
  suggestion = {
    keymap = {
      accept = "<c-l>",
      next = "<c-j>",
      prev = "<c-k>",
      dismiss = "<c-h>",
    },
  },
}

local opts = { noremap = true, silent = true }
vim.api.nvim_set_keymap("n", "<c-s>", "<cmd>lua require('copilot.suggestion').toggle_auto_trigger()<CR>", opts)

require("lvim.lsp.manager").setup("lua_ls", {})
