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

  -- Copilot Chat
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    keys = {
      { "<leader>aa", false, mode = { "n", "x" } }, -- disable default keymap
      {
        "<leader>at",
        function()
          return require("CopilotChat").toggle()
        end,
        desc = "Toggle (CopilotChat)",
        mode = { "n", "x" },
      },
    },
    opts = function(_, opts)
      opts.model = "gpt-5.1-codex"
      opts.auto_insert_mode = false
      opts.show_help = true
      opts.show_folds = true
      opts.highlight_selection = false
      opts.highlight_headers = false
      opts.auto_follow_cursor = false
      opts.insert_at_end = true
      opts.clear_chat_on_new_prompt = false
      opts.chat_autocomplete = true

      opts.window = {
        layout = "float",
        width = 0.7,
        height = 0.6,
        relative = "editor",
        border = "rounded",
        title = "Copilot Chat 🤖",
        title_pos = "right",
      }

      opts.prompts = vim.tbl_extend("force", opts.prompts or {}, {
        Commit = {
          prompt = [[
#git:staged

Generate a Conventional Commit message.
Rules:
- English
- Title ≤ 50 chars
- Body wrapped at 72 chars
- Format output inside ```gitcommit``` block
]],
          context = false,
          selection = false,

          callback = function(response)
            local text = response.text or response.content or tostring(response)

            if not text or text == "" then
              vim.notify("❗ No response text from CopilotChat", vim.log.levels.ERROR)
              return
            end

            local commit_message = text:match("```gitcommit\n(.-)\n```")

            if not commit_message then
              vim.notify("⚠ Could not extract commit message — print returned text for debug", vim.log.levels.WARN)
              print(text)
              return
            end

            if vim.fn.confirm("Create commit?\n\n" .. commit_message, "&Yes\n&No", 2) == 1 then
              vim.fn.system({ "git", "commit", "-m", commit_message })

              if vim.fn.confirm("Push to remote?", "&Yes\n&No", 2) == 1 then
                vim.fn.system({ "git", "push" })
              end

              -- auto close window
              vim.defer_fn(function()
                vim.cmd("close")
              end, 50)
            end
          end,
        },

        Explain = {
          prompt = [[
  /COPILOT_EXPLAIN

  Giải thích đoạn code phía trên thật chi tiết và đầy đủ bằng tiếng Việt.  
  Yêu cầu bao gồm:

  - Phân tích từng phần, từng dòng hoặc từng khối logic rõ ràng.
  - Mô tả code hoạt động ra sao, input/output là gì.
  - Nếu có kỹ thuật, thư viện hoặc pattern được dùng → giải thích vai trò.
  - Dùng ví dụ minh họa khi có thể.
  - Viết thành đoạn văn dài, có cấu trúc, dễ hiểu cho người mới.

  Trình bày nội dung như một lập trình viên kinh nghiệm đang hướng dẫn junior bằng tiếng việt.
  ]],
        },

        Fix = {
          prompt = [[
/COPILOT_GENERATE

Phân tích thật chi tiết đoạn code phía trên và thực hiện các yêu cầu sau, trả lời bằng tiếng Việt:

- Tìm và chỉ ra các lỗi tiềm ẩn (runtime, logic, edge cases…).
- Giải thích vì sao đó là lỗi hoặc code chưa tốt.
- Đề xuất cách sửa cụ thể, kèm ví dụ code đã được chỉnh sửa.
- Nếu có thể tối ưu về hiệu năng, độ sạch code, readability → hãy nêu rõ.
- Giải thích sự khác nhau giữa bản cũ và bản đã sửa.

Trình bày theo phong cách một lập trình viên kinh nghiệm review code cho junior: rõ ràng, chi tiết, dễ hiểu.
]],
        },

        Grammar = {
          prompt = [[
/COPILOT_INSTRUCTIONS

Chỉnh sửa đoạn văn phía trên để:

- Đúng ngữ pháp tiếng Việt.
- Câu chữ mạch lạc, dễ đọc, dễ hiểu hơn.
- Giữ nguyên ý nghĩa gốc của tác giả.
- Nếu có code trong đoạn văn, tuyệt đối không thay đổi cú pháp, tên biến, tên hàm.

Chỉ trả lời bằng phiên bản đã được chỉnh sửa (không cần giải thích thêm).
]],
        },

        Review = {
          prompt = [[
/COPILOT_REVIEW

Hãy review đoạn code đã chọn một cách toàn diện, trả lời bằng tiếng Việt, với các nội dung:

- Mô tả ngắn gọn đoạn code đang làm gì.
- Đánh giá về cấu trúc, độ rõ ràng, khả năng bảo trì.
- Nhận xét về hiệu năng (có chỗ nào dư thừa, lặp lại, O(n) / O(n^2)… nếu có).
- Kiểm tra các rủi ro bảo mật hoặc bug tiềm ẩn (nếu có).
- Đề xuất cụ thể các cải tiến: đặt tên, tách hàm, refactor, thêm validate, log, comment...
- Nếu hợp lý, đưa ra phiên bản code refactor gợi ý.

Viết như một senior đang review code cho junior: thẳng thắn nhưng mang tính hướng dẫn.
]],
        },
      })

      return opts
    end,
  },
}
