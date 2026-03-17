---@type LazySpec
return {
  "pbdeuchler/material.nvim",
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    dependencies = {
      { "zbirenbaum/copilot.lua" },
      { "nvim-lua/plenary.nvim", branch = "master" }, -- for curl, log and async functions
    },
    build = "make tiktoken", -- Only on MacOS or Linux
    opts = {
      model = "claude-sonnet-4.5",
    },
    -- See Commands section for default commands if you want to lazy load on them
  },
}
