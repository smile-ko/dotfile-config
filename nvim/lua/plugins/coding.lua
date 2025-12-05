return {
  -- Create annotations with one keybind, and jump your cursor in the inserted annotation
  {
    "danymat/neogen",
    keys = {
      {
        "<leader>cc",
        function()
          require("neogen").generate({})
        end,
        desc = "Neogen Comment",
      },
    },
    opts = { snippet_engine = "luasnip" },
  },

  -- Incremental rename
  {
    "smjonas/inc-rename.nvim",
    cmd = "IncRename",
    config = true,
  },

  -- Refactoring tool
  {
    "ThePrimeagen/refactoring.nvim",
    keys = {
      {
        "<leader>r",
        function()
          require("refactoring").select_refactor()
        end,
        mode = "v",
        noremap = true,
        silent = true,
        expr = false,
      },
    },
    opts = {},
  },

  -- Go forward/backward with square brackets
  {
    "nvim-mini/mini.bracketed",
    event = "BufReadPost",
    config = function()
      local bracketed = require("mini.bracketed")
      bracketed.setup({
        file = { suffix = "" },
        window = { suffix = "" },
        quickfix = { suffix = "" },
        yank = { suffix = "" },
        treesitter = { suffix = "n" },
      })
    end,
  },

  -- Better increase/descrease
  {
    "monaqa/dial.nvim",
    -- stylua: ignore
    keys = {
      { "<C-a>", function() return require("dial.map").inc_normal() end, expr = true, desc = "Increment" },
      { "<C-x>", function() return require("dial.map").dec_normal() end, expr = true, desc = "Decrement" },
    },
    config = function()
      local augend = require("dial.augend")
      require("dial.config").augends:register_group({
        default = {
          augend.integer.alias.decimal,
          augend.integer.alias.hex,
          augend.date.alias["%Y/%m/%d"],
          augend.constant.alias.bool,
          augend.semver.alias.semver,
          augend.constant.new({ elements = { "let", "const" } }),
        },
      })
    end,
  },

  -- Symbols outline
  {
    "simrat39/symbols-outline.nvim",
    keys = { { "<leader>cs", "<cmd>SymbolsOutline<cr>", desc = "Symbols Outline" } },
    cmd = "SymbolsOutline",
    opts = {
      position = "right",
    },
  },

  -- tools
  {
    "mason-org/mason.nvim",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "stylua",
        "selene",
        "luacheck",
        "shellcheck",
        "shfmt",
        "vue-language-server",
        "tailwindcss-language-server",
        "typescript-language-server",
        "css-lsp",
        "prisma-language-server",
        "gopls",
      })
    end,
  },

  -- lsp servers
  {
    "neovim/nvim-lspconfig",
    dependencies = { "saghen/blink.cmp" },
    opts = {
      inlay_hints = { enabled = false },
      servers = {
        cssls = {},
        tailwindcss = {
          root_dir = function(...)
            return require("lspconfig.util").root_pattern(".git")(...)
          end,
        },
        tsserver = {
          root_dir = function(...)
            return require("lspconfig.util").root_pattern(".git")(...)
          end,
          single_file_support = false,
          settings = {
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
        html = {},
        yamlls = {
          settings = {
            yaml = {
              keyOrdering = false,
            },
          },
        },
        lua_ls = {
          -- enabled = false,
          single_file_support = true,
          settings = {
            Lua = {
              workspace = {
                checkThirdParty = false,
              },
              completion = {
                workspaceWord = true,
                callSnippet = "Both",
              },
              misc = {
                parameters = {
                  -- "--log-level=trace",
                },
              },
              hint = {
                enable = true,
                setType = false,
                paramType = true,
                paramName = "Disable",
                semicolon = "Disable",
                arrayIndex = "Disable",
              },
              doc = {
                privateName = { "^_" },
              },
              type = {
                castNumberToInteger = true,
              },
              diagnostics = {
                disable = { "incomplete-signature-doc", "trailing-space" },
                -- enable = false,
                groupSeverity = {
                  strong = "Warning",
                  strict = "Warning",
                },
                groupFileStatus = {
                  ["ambiguity"] = "Opened",
                  ["await"] = "Opened",
                  ["codestyle"] = "None",
                  ["duplicate"] = "Opened",
                  ["global"] = "Opened",
                  ["luadoc"] = "Opened",
                  ["redefined"] = "Opened",
                  ["strict"] = "Opened",
                  ["strong"] = "Opened",
                  ["type-check"] = "Opened",
                  ["unbalanced"] = "Opened",
                  ["unused"] = "Opened",
                },
                unusedLocalExclude = { "_*" },
              },
              format = {
                enable = false,
                defaultConfig = {
                  indent_style = "space",
                  indent_size = "2",
                  continuation_indent_size = "2",
                },
              },
            },
          },
        },
      },
      setup = {},
    },
  },

  -- LSP keymaps
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        ["*"] = {
          keys = {
            {
              "gd",
              function()
                require("telescope.builtin").lsp_definitions({ reuse_win = false })
              end,
              desc = "Goto Definition",
              has = "definition",
            },
          },
        },
      },
    },
  },

  -- Treesitter
  { "nvim-treesitter/playground", cmd = "TSPlaygroundToggle" },
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    opts = {
      ensure_installed = {
        "astro",
        "cmake",
        "cpp",
        "css",
        "fish",
        "gitignore",
        "go",
        "graphql",
        "http",
        "java",
        "php",
        "scss",
        "sql",
        "svelte",
      },

      highlight = { enable = true },
      indent = { enable = true },

      query_linter = {
        enable = true,
        use_virtual_text = true,
        lint_events = { "BufWrite", "CursorHold" },
      },

      playground = {
        enable = true,
        updatetime = 25,
        persist_queries = true,
      },
    },

    init = function()
      -- support MDX
      vim.filetype.add({ extension = { mdx = "mdx" } })
      vim.treesitter.language.register("markdown", "mdx")
    end,
  },

  -- Menu completion code
  {
    "saghen/blink.cmp",
    opts = {
      completion = {
        menu = {
          winblend = vim.o.pumblend,
        },
        -- Displays a preview of the selected item on the current line
        ghost_text = {
          enabled = true,
        },
      },

      signature = {
        window = {
          winblend = vim.o.pumblend,
        },
      },
    },
  },

  -- Copilot
  {
    "github/copilot.vim",
    event = "InsertEnter",
  },

  -- Copilot Chat
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    opts = function(_, opts)
      opts.model = "gpt-5.1-codex"

      opts.show_help = false
      opts.show_folds = false
      opts.highlight_selection = false
      opts.highlight_headers = false
      opts.auto_insert_mode = true

      opts.prompts = vim.tbl_extend("force", opts.prompts or {}, {
        Commit = {
          prompt = "#git:staged\n\nWrite commit message for the change with commitizen convention. Max 50-char title, wrap body at 72. Return in ```gitcommit``` block.",
          selection = false,
          context = false,
          callback = function(response)
            ---@type string|nil
            local commit_message = response:match("```gitcommit\n(.-)\n```")
            if commit_message then
              if vim.fn.confirm("Create commit?\n" .. commit_message, "&Yes\n&No", 2) == 1 then
                vim.fn.system({ "git", "commit", "-m", commit_message })
                if vim.fn.confirm("Push to remote?", "&Yes\n&No", 2) == 1 then
                  vim.fn.system({ "git", "push" })
                end
                vim.defer_fn(function()
                  vim.cmd("close")
                end, 20)
              end
            end
          end,
        },

        Explain = {
          prompt = "/COPILOT_EXPLAIN\n\nWrite an explanation for selected code in paragraph form.",
        },

        Fix = {
          prompt = "/COPILOT_GENERATE\n\nAnalyze code, find issues, correct, improve quality + efficiency.",
        },

        Grammar = {
          prompt = "/COPILOT_INSTRUCTIONS\n\nFix grammar without modifying syntax, formatting, variables.",
        },

        Review = {
          prompt = "/COPILOT_REVIEW\n\nReview selected code, give suggestions, quality, structure, safety.",
        },
      })

      opts.mappings = vim.tbl_extend("force", opts.mappings or {}, {
        complete = { insert = "<Tab>" },
        close = { normal = "<leader>x" },
        reset = { normal = "<leader>r" },
        submit_prompt = { normal = "<CR>", insert = "<C-s>" },
        toggle_sticky = { normal = "<leader>ts" },
        clear_stickies = { normal = "<leader>tS" },
        accept_diff = { normal = "<leader>da" },
        jump_to_diff = { normal = "<leader>dj" },
        quickfix_answers = { normal = "<leader>qa" },
        quickfix_diffs = { normal = "<leader>qd" },
        yank_diff = { normal = "<leader>dy", register = '"' },
        show_diff = { normal = "<leader>sd" },
        show_info = { normal = "<leader>si" },
        show_context = { normal = "<leader>sc" },
        show_help = { normal = "<leader>h" },
      })

      return opts
    end,
    config = function(_, opts)
      local chat = require("CopilotChat")
      chat.setup(opts)

      vim.api.nvim_create_autocmd("FileType", {
        pattern = "copilot-chat",
        callback = function()
          vim.keymap.set("i", "<Tab>", function()
            return require("CopilotChat.actions").complete()
          end, { buffer = true })
        end,
      })
    end,
  },
}
