return {
  "folke/which-key.nvim",
  event = "VeryLazy",

  keys = {
    {
      "<leader>?",
      function()
        require("which-key").show({ global = false })
      end,
      desc = "Buffer Local Keymaps (which-key)",
    },
  },

  opts = {
    icons = {
      breadcrumb = "»",
      separator = "󰁔", -- icon between groups
    },

    delay = function(ctx)
      return ctx.plugin and 0 or 400
    end,

    spec = {
      {
        {
          "<leader>h",
          group = "Rest API",
        },
        {
          "<leader>a",
          group = "AI Tools",
        },
      },
    },
  },
}
