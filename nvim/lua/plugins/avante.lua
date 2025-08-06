return {
  "yetone/avante.nvim",
  event = "VeryLazy",
  build = "make",
  version = false,
  dependencies = {
    "MunifTanjim/nui.nvim",
  },
  opts = (function()
    local opts = {
      provider = "openai/gpt-4o-mini",
      auto_suggestions_provider = "openai/gpt-4o-mini",
      mode = "legacy",
      providers = {
        ["openai/gpt-4o"] = {
          __inherited_from = "openai",
          endpoint = "https://api.openai.com/v1",
          model = "gpt-4o",
          display_name = "openai/gpt-4o",
          api_key_name = "OPENAI_API_KEY",
          extra_request_body = {
            max_tokens = 32768,
          },
          disable_tools = true,
        },
        ["openai/gpt-4.1"] = {
          __inherited_from = "openai",
          endpoint = "https://api.openai.com/v1",
          model = "gpt-4.1",
          display_name = "openai/gpt-4.1",
          api_key_name = "OPENAI_API_KEY",
          extra_request_body = {
            max_tokens = 32768,
          },
          disable_tools = true,
        },
        ["openai/gpt-4o-mini"] = {
          __inherited_from = "openai",
          endpoint = "https://api.openai.com/v1",
          model = "gpt-4o-mini",
          display_name = "openai/gpt-4o-mini",
          api_key_name = "OPENAI_API_KEY",
          extra_request_body = {
            max_tokens = 16384,
          },
          disable_tools = true,
        },
      },
      behaviour = {
        auto_focus_sidebar = true,
        auto_suggestions = false,
        auto_suggestions_respect_ignore = false,
        auto_set_highlight_group = true,
        auto_set_keymaps = false,
        auto_apply_diff_after_generation = false,
        jump_result_buffer_on_finish = false,
        support_paste_from_clipboard = false,
        minimize_diff = true,
        enable_token_counting = false,
        use_cwd_as_project_root = false,
        auto_focus_on_diff_view = false,
      },
      windows = {
        position = "right",
        wrap = true,
        ask = {
          start_insert = false,
        },
      },
      mappings = {
        diff = {
          ours = "<leader>gco",
          theirs = "<leader>gct",
          all_theirs = "<leader>gca",
          both = "<leader>gcb",
          cursor = "<leader>gch",
          prev = "[c",
          next = "]c",
        },
        suggestion = {
          accept = "<M-l>",
          next = "<M-j>",
          prev = "<M-k>",
          dismiss = "<M-h>",
        },
        jump = {
          next = "<M-j>",
          prev = "<M-k>",
        },
        submit = {
          normal = "<CR>",
          insert = "<C-s>",
        },
        cancel = {
          normal = { "<C-c>", "<Esc>" },
          insert = { "<C-c>" },
        },
        toggle = {
          default = false,
        },
        sidebar = {
          apply_all = "A",
          apply_cursor = "a",
          retry_user_request = "r",
          edit_user_request = "e",
          switch_windows = "<Tab>",
          reverse_switch_windows = "<S-Tab>",
          remove_file = "d",
          add_file = "@",
          close = { "<Esc>", "<leader>x" },
          close_from_input = { normal = { "<Esc>", "<leader>x" } },
        },
        files = {
          add_current = "<M-f>",
          add_all_buffers = false,
        },
      },
      history = {
        storage_path = "/tmp/avante_history",
      },
      highlights = {
        diff = {
          current = "DiffTextGroup",
          incoming = "DiffAddGroup",
        },
      },
      diff = {
        autojump = true,
      },
      hints = {
        enabled = false,
      },
      selector = {
        provider = "telescope",
        exclude_auto_select = { "NvimTree" },
      },
    }

    local hidden_models = {
      "copilot",
      "claude",
      "gemini",
      "vertex",
    }

    for _, model in ipairs(hidden_models) do
      opts.providers[model] = { hide_in_model_selector = true }
    end

    return opts
  end)(),
  keys = {
    {
      "<M-f>",
      function()
        local tree_ext = require("avante.extensions.nvim_tree")
        tree_ext.add_file()
      end,
      ft = "NvimTree",
    },
    {
      "<M-F>",
      function()
        local tree_ext = require("avante.extensions.nvim_tree")
        tree_ext.remove_file()
      end,
      ft = "NvimTree",
    },
  },
  config = function(_, opts)
    require("avante").setup(opts)
    local sidebar = require("avante.sidebar")
    if sidebar then
      sidebar.show_input_hint = function() end
      sidebar.close_input_hint = function() end
    end
  end,
}
