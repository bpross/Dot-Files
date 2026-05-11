---@type LazySpec
return {
  {
    "NeogitOrg/neogit",
    dependencies = { "nvim-lua/plenary.nvim", "sindrets/diffview.nvim" },
    cmd = { "Neogit" },
    opts = {
      integrations = { diffview = true },
    },
  },
  {
    "sindrets/diffview.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    lazy = true,
  },
  {
    "bpross/review.nvim",
    dir = vim.fn.expand("~/github.com/bpross/review.nvim"),
    lazy = false,
    config = function()
      require("review").setup()
    end,
    keys = {
      { "<leader>rc", function() require("review").add_comment() end, desc = "Add review comment" },
      { "<leader>ro", function() require("review").open_review() end, desc = "Open .review.md" },
      { "<leader>rs", function() require("review").show_comments() end, desc = "Refresh review comments" },
    },
  },
}
