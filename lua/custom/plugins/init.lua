-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {

  { -- Autoformat
    'stevearc/conform.nvim',
    -- by denis: DISABLE!
    enabled = false,
  },

  -- by denis
  {
    'yorik1984/newpaper.nvim',
    priority = 999,
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

  {
    -- Set lualine as statusline
    'nvim-lualine/lualine.nvim',
    -- See `:help lualine.txt`
    opts = {
      options = {
        icons_enabled = false,
        --theme = 'onedark',
        theme = 'newpaper',
        component_separators = '|',
        section_separators = '',
      },
    },
  },

  {
    -- Add indentation guides even on blank lines
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

  -- restore cursor position on file reopen
  { 'farmergreg/vim-lastplace' },

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

  -- Tabulator
  {
    'godlygeek/tabular',
  },

  -- latex symbols complete
  {
    'kdheepak/cmp-latex-symbols',
    dependencies = { 'hrsh7th/nvim-cmp' },
    -- config in the cmp.setup() section in tail of file
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

  -- autopair
  {
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    opts = {}, -- this is equalent to setup({}) function
  },

  -- vim-swap: swap arguments delimited with ','. Keys: g< and g>
  {
    'machakann/vim-swap',
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

  -- avoid change cursor to center after bnext
  -- https://github.com/BranimirE/fix-auto-scroll.nvim
  {
    'BranimirE/fix-auto-scroll.nvim',
    config = true,
    event = 'VeryLazy',
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

