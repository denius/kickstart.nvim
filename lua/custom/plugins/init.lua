-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
--

return {

  ---------------------------------------------------------------------------
  --- DISABLED

  ---------------------------------------------------------------------------
  --- Color Schemes

  -- -- not compatible with VSCode Neovim extension!!!
  -- {
  --   'Mofiqul/vscode.nvim',
  --   priority = 99,
  --   config = function()
  --     vim.cmd.colorscheme 'vscode'
  --   end,
  -- },

  -- A flow-immersive Nvim colorscheme with fluorescent details
  -- https://github.com/0xstepit/flow.nvim
  {
    "0xstepit/flow.nvim",
    lazy = false,
    priority = 1000,
    -- tag = "v1.0.0",
    opts = {
      theme = {
        style = "dark", --  "dark" | "light"
        contrast = "default", -- "default" | "high"
        transparent = false, -- true | false
      },
      colors = {
        mode = "default", -- "default" | "dark" | "light"
        fluo = "pink", -- "pink" | "cyan" | "yellow" | "orange" | "green"
      },
      ui = {
        borders = "inverse", -- "theme" | "inverse" | "fluo" | "none"
        aggressive_spell = false, -- true | false
      },
    },
    config = function(_, opts)
      require("flow").setup(opts)
      vim.cmd("colorscheme flow")
    end,
  },

  {
    'yorik1984/newpaper.nvim',
    priority = 90,
    -- init = function() -- `init` here is because `setup` is not lazy but `init` is.
    config = function()
      require('newpaper').setup {
        style = 'light',
        terminal = 'contrast',
        sidebars_contrast = { 'minimap' },
      }
      vim.cmd.colorscheme 'newpaper'
    end,
  },

  -- color hex codes and color names
  -- test: #AF0000, "#AF0000"
  -- https://github.com/chrisbra/Colorizer
  {
    'chrisbra/Colorizer',
    lazy = true, -- to load plugin use command: `:Lazy load Colorizer`
    config = function()
      -- vim.g.colorizer_auto_color = 1
      vim.g.colorizer_colornames = 0
      vim.g.colorizer_skip_comments = 0
      -- vim.g.colorizer_auto_map = 1
      vim.keymap.set('n', '<LocalLeader>c', ':ColorHighlight<cr>', { silent = true })
    end,
  },

  ---------------------------------------------------------------------------
  --- UI

  -- Set lualine as statusline
  {
    'nvim-lualine/lualine.nvim',
    -- See `:help lualine.txt`
    opts = {
      options = {
        icons_enabled = false,
        theme = 'auto',
        -- section_separators = '|',
        -- component_separators = '',
        section_separators = { left = '', right = '' },
        -- component_separators = { left = '', right = '' },
        component_separators = { left = '', right = '' },
      },
      sections = {
        -- lualine_a = {'mode', keymap},
        -- lualine_c = {'filename', keymap},
        -- lualine_x = {keymap, 'encoding', 'fileformat', 'filetype'},
        lualine_x = {function()
                       -- Show Lang keymap in lualine status
                       -- https://github.com/nvim-lualine/lualine.nvim/issues/368
                       -- https://github.com/nvim-lualine/lualine.nvim/wiki/Component-snippets#keymap
                       if vim.opt.iminsert:get() > 0 and vim.b.keymap_name then
                         return '[' .. vim.b.keymap_name:upper() .. ']'
                       end
                       return ''
                     end, 'encoding', 'fileformat', 'filetype'},
      },
    },
  },

  -- tabsline
  {
    'akinsho/bufferline.nvim',
    version = '*',
    -- dependencies = 'nvim-tree/nvim-web-devicons', -- drop using icons in tabline
    opts = {
      highlights = {
        background = {
          italic = true,
        },
        buffer_selected = {
          bold = true,
        },
      },
      options = {
        -- enabled = true,
        show_tab_indicators = true,
        mode = 'buffers', -- set to 'tabs' to only show tabpages instead
        numbers = 'none', -- can be 'none' | 'ordinal' | 'buffer_id' | 'both' | function
        indicator = {
          -- icon = '▎', -- unused
          style = 'none', -- can be 'icon'|'underline'|'none',
        },
        always_show_bufferline = true,
        diagnostics = false,
        diagnostics_indicator = false,
        -- custom_filter = false,
        show_buffer_icons = false, -- disable filetype icons
      },
    },
  },

  -- close buffers
  -- https://github.com/ojroques/nvim-bufdel
  {
    'ojroques/nvim-bufdel',
    opts = {
      next = 'tabs', -- 'cycle' | 'tabs' (default) | 'alternate'
      quit = true, -- quit Neovim when last buffer is closed
    },
    config = function()
      -- close buffer via 'ojroques/nvim-bufdel' plugin
      vim.keymap.set('n', '<LocalLeader>q', ':BufDel<cr>', { silent = true })
    end,
  },

  -- highlight (underline) word under cursor
  -- https://github.com/RRethy/vim-illuminate
  {
    'RRethy/vim-illuminate',
    opts = {},
    config = function()
      require('illuminate').configure {
        -- providers: provider used to get references in the buffer, ordered by priority
        providers = {
          'lsp',
          'treesitter',
          'regex',
        },
        -- delay: delay in milliseconds
        delay = 120,
        -- filetype_overrides: filetype specific overrides.
        -- The keys are strings to represent the filetype while the values are tables that
        -- supports the same keys passed to .configure except for filetypes_denylist and filetypes_allowlist
        filetype_overrides = {},
        -- filetypes_denylist: filetypes to not illuminate, this overrides filetypes_allowlist
        filetypes_denylist = {
          'dirvish',
          'fugitive',
          'alpha',
          'NvimTree',
          'lazy',
          'neogitstatus',
          'Trouble',
          'lir',
          'Outline',
          'spectre_panel',
          'toggleterm',
          'DressingSelect',
          'TelescopePrompt',
        },
        -- filetypes_allowlist: filetypes to illuminate, this is overridden by filetypes_denylist
        filetypes_allowlist = {},
        -- modes_denylist: modes to not illuminate, this overrides modes_allowlist
        modes_denylist = {},
        -- modes_allowlist: modes to illuminate, this is overridden by modes_denylist
        modes_allowlist = {},
        -- providers_regex_syntax_denylist: syntax to not illuminate, this overrides providers_regex_syntax_allowlist
        -- Only applies to the 'regex' provider
        -- Use :echom synIDattr(synIDtrans(synID(line('.'), col('.'), 1)), 'name')
        providers_regex_syntax_denylist = {},
        -- providers_regex_syntax_allowlist: syntax to illuminate, this is overridden by providers_regex_syntax_denylist
        -- Only applies to the 'regex' provider
        -- Use :echom synIDattr(synIDtrans(synID(line('.'), col('.'), 1)), 'name')
        providers_regex_syntax_allowlist = {},
        -- under_cursor: whether or not to illuminate under the cursor
        under_cursor = true,
      }
    end,
  },

  -- Add indentation guides, even on blank lines
  {
    'lukas-reineke/indent-blankline.nvim',
    -- Enable `lukas-reineke/indent-blankline.nvim`
    -- See `:help ibl`
    main = 'ibl',
    opts = {},
    -- local hooks = require 'ibl.hooks'
    -- hooks.register(
    --   hooks.type.WHITESPACE,
    --   hooks.builtin.hide_first_space_indent_level
    -- ),
    -- require('ibl.hooks').register(
    --   require('ibl.hooks').type.WHITESPACE,
    --   require('ibl.hooks').builtin.hide_first_space_indent_level
    -- ),
    config = function()
      require('ibl').setup {
        scope = { enabled = false },
        enabled = false,
        indent = { char = '' },
      }
      -- vim.o.list = false
      -- require('ibl.hooks').register({
      --   hooks.type.WHITESPACE,
      --   hooks.builtin.hide_first_space_indent_level
      -- })

      -- toggle indent show
      local hooks = require 'ibl.hooks'
      hooks.register(
        hooks.type.WHITESPACE,
        hooks.builtin.hide_first_space_indent_level -- disable indent on first collumn
      )
      vim.keymap.set('n', '<LocalLeader>.', function()
        -- if vim.opt.list:get() then
        if vim.o.list then
          require('ibl').setup {
            enabled = true,
            indent = { char = '▏' },
            -- show_current_context_start = true,
          }
          vim.cmd [[set list!]]
          -- print('Indent |')
        elseif require('ibl.config').config.indent.char ~= '' then
          require('ibl').setup {
            enabled = false,
            indent = { char = '' },
          }
          vim.cmd [[redraw!]]
          -- print('Indent empty')
        else
          require('ibl').setup {
            enabled = false,
            indent = { char = '⋅' },
          }
          vim.cmd [[set list!]]
          -- print('Indent fill dots')
        end
      end, { silent = true, desc = 'Toggle indent show' })
    end,
  },

  ---------------------------------------------------------------------------
  --- Behavior

  -- restore cursor position on file reopen
  { 'farmergreg/vim-lastplace' },

  -- avoid change cursor to center after bnext
  -- https://github.com/BranimirE/fix-auto-scroll.nvim
  {
    'BranimirE/fix-auto-scroll.nvim',
    config = true,
    event = 'VeryLazy',
  },

  -- autopairs
  -- https://github.com/windwp/nvim-autopairs
  -- extended kickstart.nvim config
  {
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    -- Optional dependency
    dependencies = { 'hrsh7th/nvim-cmp' },
    config = function()
      require('nvim-autopairs').setup({
        ignored_next_char = [=[[А-Яа-яЁё%w%%%'%[%"%.%`%$]]=],
        -- ignored_next_char = "(" .. "[\194-\244]" .. "|" .. "[\128-\191]" .. "|" .. "[%w%%%'%[%\"%.%`%$]" .. ")",
        -- ignored_next_char = "(" .. [=[[%w%%%'%[%"%.%`%$]]=] .. "|" .. "[\194-\244][\128-\191]" .. ")",
      })
      -- If you want to automatically add `(` after selecting a function or method
      local cmp_autopairs = require 'nvim-autopairs.completion.cmp'
      local cmp = require 'cmp'
      cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())
    end,
  },

  -- faster big files
  -- https://github.com/pteroctopus/faster.nvim
  -- config by https://github.com/pteroctopus/faster.nvim/issues/2#issue-2680715449
  {
    'pteroctopus/faster.nvim',
    event = { 'BufReadPre', 'BufReadPost' },
    opts = function()
      vim.api.nvim_create_autocmd('BufReadPost', {
        -- add other types here for long files:
        pattern = {'*.js', '*.css'},
        group = vim.api.nvim_create_augroup('faster_bigfile_custom', {}),
        callback = function(args)
          local line_count = vim.api.nvim_buf_line_count(args.buf)
          ---@diagnostic disable-next-line: undefined-field
          local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(args.buf))
          -- if file is at least 10k and the average bytes per line is > 250, then disable everything
          if ok and stats and (stats.size > (10 * 1024)) and (stats.size / line_count) > 250 then
            vim.notify(
              'Disabling for long file, bytes: ' .. stats.size .. ', lines: ' .. line_count .. ', bytes / lines: ' .. math.floor(stats.size / line_count)
            )
            vim.cmd('FasterDisableAllFeatures')
            vim.b[args.buf].trouble_lualine = false
          end
        end,
        desc = '[faster.nvim] Performance rule for handling js file with long lines',
      })
      return {}
    end,
  },

  ---------------------------------------------------------------------------
  --- Yank and Registers

  -- yankring with '<localleader>p'
  -- https://github.com/gbprod/yanky.nvim
  {
    'gbprod/yanky.nvim',
    dependencies = { { 'kkharji/sqlite.lua', enabled = not jit.os:find 'Windows' } },
    opts = {
      highlight = { timer = 250 },
      ring = { storage = jit.os:find 'Windows' and 'shada' or 'sqlite' },
    },
    keys = {
      { "<leader>p", function() require("telescope").extensions.yank_history.yank_history({ }) end, desc = "Open Yank History" },
      { "<localleader>p", function() require("telescope").extensions.yank_history.yank_history({ }) end, desc = "Open Yank History" },
      { 'y', '<Plug>(YankyYank)', mode = { 'n', 'x' }, desc = 'Yank text' },
      { 'p', '<Plug>(YankyPutAfter)', mode = { 'n', 'x' }, desc = 'Put yanked text after cursor' },
      { 'P', '<Plug>(YankyPutBefore)', mode = { 'n', 'x' }, desc = 'Put yanked text before cursor' },
      { 'gp', '<Plug>(YankyGPutAfter)', mode = { 'n', 'x' }, desc = 'Put yanked text after selection' },
      { 'gP', '<Plug>(YankyGPutBefore)', mode = { 'n', 'x' }, desc = 'Put yanked text before selection' },
      { '<c-p>', '<Plug>(YankyPreviousEntry)', desc = 'Select previous entry through yank history' },
      { '<c-n>', '<Plug>(YankyNextEntry)', desc = 'Select next entry through yank history' },
      { ']p', '<Plug>(YankyPutIndentAfterLinewise)', desc = 'Put indented after cursor (linewise)' },
      { '[p', '<Plug>(YankyPutIndentBeforeLinewise)', desc = 'Put indented before cursor (linewise)' },
      { ']P', '<Plug>(YankyPutIndentAfterLinewise)', desc = 'Put indented after cursor (linewise)' },
      { '[P', '<Plug>(YankyPutIndentBeforeLinewise)', desc = 'Put indented before cursor (linewise)' },
      { '>p', '<Plug>(YankyPutIndentAfterShiftRight)', desc = 'Put and indent right' },
      { '<p', '<Plug>(YankyPutIndentAfterShiftLeft)', desc = 'Put and indent left' },
      { '>P', '<Plug>(YankyPutIndentBeforeShiftRight)', desc = 'Put before and indent right' },
      { '<P', '<Plug>(YankyPutIndentBeforeShiftLeft)', desc = 'Put before and indent left' },
      { '=p', '<Plug>(YankyPutAfterFilter)', desc = 'Put after applying a filter' },
      { '=P', '<Plug>(YankyPutBeforeFilter)', desc = 'Put before applying a filter' },
    },
  },

  ---------------------------------------------------------------------------
  --- Text Align

  -- Tabulator
  {
    'godlygeek/tabular',
  },

  -- for tables alignment, for Markdown also.
  -- Usage by call `vip` and `:'<,'>EasyAlign *|`
  {
    'junegunn/vim-easy-align',
  },

  -- vim-swap: swap arguments delimited with ','. Keys: g< and g>
  {
    'machakann/vim-swap',
  },

  ---------------------------------------------------------------------------
  --- LSP

  { -- Autoformat
    'stevearc/conform.nvim',
    -- enabled = false,
    opts = {
      format_on_save = {
        lsp_format = 'never',
      },
      formatters_by_ft = {
        -- Conform can also run multiple formatters sequentially
        -- python = { "isort", "black" },
        -- You can use 'stop_after_first' to run the first available formatter from the list
        -- javascript = { "prettierd", "prettier", stop_after_first = true },
      },
    },
  },

  -- pretty diagnostics, references, telescope results, quickfix and location list
  -- https://github.com/folke/trouble.nvim
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

  ---------------------------------------------------------------------------
  --- cmp

  -- latex symbols complete
  {
    'kdheepak/cmp-latex-symbols',
    dependencies = { 'hrsh7th/nvim-cmp' },
    -- config in the cmp.setup() section in tail of file
  },

  ---------------------------------------------------------------------------
  --- Calculators

  -- math calculator, in completion
  {
    'hrsh7th/cmp-calc',
    dependencies = { 'hrsh7th/nvim-cmp' },
    -- config in the cmp.setup() section in tail of file
  },

  -- math calc
  {
    'arecarn/crunch.vim',
  },

  ---------------------------------------------------------------------------
  --- Various file types (Languages) support

  -- Tiny plugin to enhance Neovim's native comments
  -- https://github.com/folke/ts-comments.nvim
  {
    "folke/ts-comments.nvim",
    opts = {
      lang = {
        c = "/* %s */",
        julia = "// %s",
      },
    },
    event = "VeryLazy",
    enabled = vim.fn.has("nvim-0.10.0") == 1,
  },

  -- https://github.com/JuliaEditorSupport/julia-vim
  {
    "JuliaEditorSupport/julia-vim",
  },

  -- plugins/quarto.lua
  {
    "quarto-dev/quarto-nvim",
    dependencies = {
      "jmbuhr/otter.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    -- setup = function ()
    -- config = function ()
    init = function ()
      local cmp = require('cmp')
      cmp.setup({
        sources = cmp.config.sources({
          { name = 'quarto-nvim' },
        }),
      })
    end,
  },

  -- Plugin to improve viewing Markdown files in Neovim
  -- https://github.com/MeanderingProgrammer/render-markdown.nvim
  {
    'MeanderingProgrammer/render-markdown.nvim',
    -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.nvim' }, -- if you use the mini.nvim suite
    -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.icons' }, -- if you use standalone mini plugins
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
    ---@module 'render-markdown'
    ---@type render.md.UserConfig
    opts = {},
    config = function ()
      require('render-markdown').setup({
        enabled = false,
        file_types = { 'markdown', 'quarto' },
        bullet = {
          -- icons = { '● ', '○ ', '◆ ', '◇ ' },
          -- left_pad = 2,
          right_pad = 1,
        },
        code = {
          -- style = 'normal',
          border = 'thick',
        },
        link = {
          -- Turn on / off inline link icon rendering
          enabled = false,
        },
      })
      local cmp = require('cmp')
      cmp.setup({
        sources = cmp.config.sources({
          { name = 'render-markdown' },
        }),
      })
      vim.keymap.set('n', '<LocalLeader>m', '<Cmd>RenderMarkdown toggle<cr>', { silent = false })
    end,
  },

  -- markdown preview plugin for (neo)vim
  -- https://github.com/iamcco/markdown-preview.nvim
  -- For setup CSS run:
  -- ```
  -- cd ~/.config
  -- git clone https://github.com/denius/markdown-css.git
  -- ```
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    build = "cd app && yarn install",
    init = function()
      vim.g.mkdp_filetypes = { "markdown", "quarto" }
      vim.g.mkdp_auto_close = 1
      -- vim.g.mkdp_command_for_global = 1
      vim.g.mkdp_highlight_css = vim.fn.expand('~/.config/markdown-css/github-markdown-css-light.css')
      vim.g.mkdp_markdown_css = vim.fn.expand('~/.config/markdown-css/github-markdown-css-light.css')
      -- vim.g.mkdp_browser = '/snap/bin/chromium'
      -- via https://github.com/iamcco/markdown-preview.nvim/issues/262#issuecomment-1219333266
      vim.cmd(
        [[
        function OpenMarkdownPreview (url)
        execute "silent ! /usr/bin/chromium-browser --new-window --app=" . a:url
        endfunction
        ]]
      )
      vim.g.mkdp_browserfunc = 'OpenMarkdownPreview'
      vim.keymap.set('n', '<LocalLeader>v', ':MarkdownPreviewToggle<cr>', { silent = false })
    end,
    ft = { "markdown", "quarto" },
  },

  -- --  scheme support
  -- {
  --   'Olical/conjure',
  -- },
  -- {
  --   'PaterJason/cmp-conjure',
  --   dependencies = { 'hrsh7th/nvim-cmp' },
  --   -- config in the cmp.setup() section in tail of file
  -- },

  ---------------------------------------------------------------------------
  --- AI

  -- LLM plugin
  {
    'David-Kunz/gen.nvim',
    -- Custom Parameters (with defaults)
    opts = {
      model = 'OpenCodeInterpreter-DS:33b-q8_0', -- The default model to use.
      host = 'localhost', -- The host running the Ollama service.
      port = '11434', -- The port on which the Ollama service is listening.
      display_mode = 'float', -- The display mode. Can be "float" or "split".
      show_prompt = false, -- Shows the Prompt submitted to Ollama.
      show_model = false, -- Displays which model you are using at the beginning of your chat session.
      quit_map = 'q', -- set keymap for quit
      no_auto_close = false, -- Never closes the window automatically.
      init = function(options)
        pcall(io.popen, 'ollama serve > /dev/null 2>&1 &')
      end,
      -- Function to initialize Ollama
      command = function(options)
        return 'curl --silent --no-buffer -X POST http://' .. options.host .. ':' .. options.port .. '/api/chat -d $body'
        -- return 'curl --silent --no-buffer -X POST http://' .. options.host .. ':' .. options.port .. '/api/generate -d $body'
      end,
      -- The command for the Ollama service. You can use placeholders $prompt, $model and $body (shellescaped).
      -- This can also be a command string.
      -- The executed command must return a JSON object with { response, context }
      -- (context property is optional).
      -- list_models = '<omitted lua function>', -- Retrieves a list of model names
      debug = false, -- Prints errors and the command which is run.
    },
  },

}

