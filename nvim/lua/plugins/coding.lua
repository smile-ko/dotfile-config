return {
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
          require("CopilotChat").toggle()
        end,
        desc = "Toggle (CopilotChat)",
        mode = { "n", "x" },
      },
    },
    opts = function(_, opts)
      -- Core options
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

      -- Window UI
      opts.window = {
        layout = "float",
        width = 0.7,
        height = 0.6,
        relative = "editor",
        border = "rounded",
        title = "Copilot Chat 🤖",
        title_pos = "right",
      }

      -- Helpers (git)
      local function notify(msg, level)
        vim.notify(msg, level or vim.log.levels.INFO, { title = "CopilotChat" })
      end

      local function trim(s)
        return (s or ""):gsub("^%s+", ""):gsub("%s+$", "")
      end

      local function system_capture(cmd, stdin)
        -- Prefer vim.system (nvim >= 0.10)
        if vim.system then
          local res = vim.system(cmd, { text = true, stdin = stdin }):wait()
          return res.code or 1, res.stdout or "", res.stderr or ""
        end

        -- Fallback to vim.fn.system (older nvim)
        local joined = table.concat(cmd, " ")
        ---@type string
        local out
        if stdin ~= nil then
          out = vim.fn.system(joined, stdin)
        else
          out = vim.fn.system(joined)
        end
        local code = vim.v.shell_error
        return code, out or "", ""
      end

      local function git_current_branch()
        local code, out = system_capture({ "git", "branch", "--show-current" })
        if code ~= 0 then
          return nil
        end
        return trim(out)
      end

      local function git_has_upstream()
        local code = system_capture({
          "git",
          "rev-parse",
          "--abbrev-ref",
          "--symbolic-full-name",
          "@{u}",
        })
        return code == 0
      end

      local function git_has_staged()
        -- exit 0 when there are changes, 1 when none
        local code = system_capture({ "git", "diff", "--cached", "--quiet" })
        return code ~= 0
      end

      local function git_commit_with_message(message)
        ---@type string
        message = trim(message)
        if message == "" then
          return false, "Empty commit message"
        end

        -- Use -F - to support multi-line commit messages safely
        local code, _, err = system_capture({ "git", "commit", "-F", "-" }, message)
        if code ~= 0 then
          return false, trim(err) ~= "" and trim(err) or "git commit failed"
        end
        return true
      end

      local function git_push_smart()
        local branch = git_current_branch()
        if not branch or branch == "" then
          return false, "Cannot detect current branch"
        end

        if git_has_upstream() then
          local code, _, err = system_capture({ "git", "push" })
          if code ~= 0 then
            return false, trim(err) ~= "" and trim(err) or "git push failed"
          end
          return true
        end

        -- First push for new branch
        local code, _, err = system_capture({ "git", "push", "-u", "origin", branch })
        if code ~= 0 then
          return false, trim(err) ~= "" and trim(err) or ("git push -u origin " .. branch .. " failed")
        end
        return true
      end

      -- Prompts
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
            local text = response.text or response.content or tostring(response or "")

            if trim(text) == "" then
              notify("❗ No response text from CopilotChat", vim.log.levels.ERROR)
              return
            end

            local commit_message = text:match("```gitcommit\n(.-)\n```")
            ---@type string
            commit_message = trim(commit_message)

            if not commit_message or commit_message == "" then
              notify("⚠ Could not extract commit message. Printing raw output...", vim.log.levels.WARN)
              print(text)
              return
            end

            -- Safety: staged check
            if not git_has_staged() then
              notify("⚠ No staged changes. Stage files first (git add ...).", vim.log.levels.WARN)
              return
            end

            if vim.fn.confirm("Create commit?\n\n" .. commit_message, "&Yes\n&No", 2) ~= 1 then
              return
            end

            local ok, err = git_commit_with_message(commit_message)
            if not ok then
              notify("Commit failed: " .. (err or "unknown error"), vim.log.levels.ERROR)
              return
            end

            notify("Commit created", vim.log.levels.INFO)

            if vim.fn.confirm("Push to remote?", "&Yes\n&No", 2) ~= 1 then
              -- close CopilotChat window if you want
              vim.defer_fn(function()
                pcall(function()
                  vim.cmd("close")
                end)
              end, 50)
              return
            end

            local pushed, perr = git_push_smart()
            if not pushed then
              notify("Push failed: " .. (perr or "unknown error"), vim.log.levels.ERROR)
              return
            end

            notify("Pushed successfully", vim.log.levels.INFO)

            vim.defer_fn(function()
              pcall(function()
                vim.cmd("close")
              end)
            end, 50)
          end,
        },

        Explain = {
          prompt = [[
/COPILOT_EXPLAIN
Giải thích đoạn code phía trên thật chi tiết và đầy đủ bằng tiếng Việt.
Yêu cầu bao gồm:
- Phân tích rõ ràng từng phần, từng dòng hoặc từng khối logic của đoạn code.
- Mô tả code hoạt động như thế nào, input/output của mỗi hàm là gì.
- Nếu có kỹ thuật, thư viện hoặc design pattern được sử dụng → giải thích ý nghĩa và lý do sử dụng.
- Nếu có generic, infer, decorator, DI… → giải thích chúng hoạt động ra sao.
- Dùng ví dụ minh họa khi có thể để junior dễ hình dung.
- Chỉ rõ vai trò và tương tác giữa các class/hàm trong toàn bộ flow.
- Nếu đoạn code có điểm tốt/chưa tốt → nêu nhận xét để junior hiểu sâu hơn.
Trình bày nội dung như một lập trình viên kinh nghiệm (senior) đang hướng dẫn cho một bạn junior, văn phong thân thiện, chi tiết và dễ hiểu.
Ưu tiên giải thích từng khối logic theo thứ tự xuất hiện trong code.
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
