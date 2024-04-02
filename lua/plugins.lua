return {
    {
        "neovim/nvim-lspconfig", -- Required for LSP support
        config = function()
            -- tsserver setup
            require('lspconfig').tsserver.setup({
                on_attach = function(client, bufnr)
                    local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
                    local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

                    buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')
                    buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', {noremap=true, silent=true})
                    buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', {noremap=true, silent=true})
                    -- Additional keybindings...

                    client.server_capabilities.document_formatting = false
                end,
            })

            -- Assuming you want to configure EFM or another LSP server for formatting/linting
            -- This is just a placeholder; adjust according to the LSP server you're configuring
            require('lspconfig').efm.setup({
                init_options = {documentFormatting = true},
                filetypes = {"javascript", "javascriptreact", "typescript", "typescriptreact"},
                settings = {
                    rootMarkers = {".git/"},
                    languages = {
                        javascript = {
                            {
                                lintCommand = "eslint -f unix --stdin --stdin-filename ${INPUT}",
                                lintStdin = true,
                                lintIgnoreExitCode = true,
                                lintFormats = {"%f:%l:%c: %m"}
                            }
                        },
                        typescript = {
                            {
                                lintCommand = "eslint -f unix --stdin --stdin-filename ${INPUT}",
                                lintStdin = true,
                                lintIgnoreExitCode = true,
                                lintFormats = {"%f:%l:%c: %m"}
                            }
                        },
                        -- Add configurations for other languages...
                    }
                }
            })
        end,
    },
    {
        "goolord/alpha-nvim",
        lazy = true,
        -- Using the 'event' field is optional; omit it to load the plugin at startup
        event = "VimEnter",
        config = function()
            require('alpha').setup(require('alpha.themes.startify').config)
        end,
    },
    {"kyazdani42/nvim-tree.lua", -- nvim-tree plugin
        dependencies = "kyazdani42/nvim-web-devicons", -- optional dependency for file icons
        config = function()
          require("nvim-tree").setup() -- Configuration options for nvim-tree
        end
      },
    { 
        'akinsho/bufferline.nvim', 
            version = "*", 
            dependencies = 'nvim-tree/nvim-web-devicons',
            config= function()
                require('bufferline').setup {
                options = {
                    numbers = "ordinal", -- or "ordinal" or "buffer_id" or "both"
                    close_command = "bdelete! %d",       -- can be a string | function, see "Mouse actions"
                    right_mouse_command = "bdelete! %d", -- can be a string | function, see "Mouse actions"
                    left_mouse_command = "buffer %d",    -- can be a string | function, see "Mouse actions"
                    middle_mouse_command = nil,          -- can be a string | function, see "Mouse actions"
                    -- more options here
                },
            }
            end,
    },
    { "catppuccin/nvim", name = "catppuccin", priority = 1000, config = function()
	    vim.cmd.colorscheme("catppuccin")
	  end },
    {"williamboman/mason.nvim", config = function()
        require("mason").setup()
    end},
    {"sbdchd/neoformat", name="neoformat"},
    {
        "nvim-lualine/lualine.nvim", -- Plugin repository
        event = "VimEnter", -- Load on VimEnter to defer loading
        config = function()
            require('lualine').setup {
                options = {
                    icons_enabled = true,
                    theme = 'auto', -- Automatically sets the theme based on your Neovim color scheme
                    component_separators = { left = '|', right = '|'},
                    section_separators = { left = '', right = ''},
                    disabled_filetypes = { "NvimTree", "dashboard" },
                },
                sections = {
                    lualine_a = {'mode'},
                    lualine_b = {'branch', 'diff', {'diagnostics', sources={'nvim_diagnostic'}}},
                    lualine_c = {
                        {'filename', path = 1}
                    },
                    lualine_x = {'encoding', 'fileformat', 'filetype'},
                    lualine_y = {'progress'},
                    lualine_z = {'location'}
                },
                inactive_sections = {
                    lualine_a = {},
                    lualine_b = {},
                    lualine_c = {'filename'},
                    lualine_x = {'location'},
                    lualine_y = {},
                    lualine_z = {}
                },
                tabline = {},
                extensions = {'fugitive'}
          }
        end,
    },
    {
      "folke/which-key.nvim",
      event = "VeryLazy",
      init = function()
        vim.o.timeout = true
        vim.o.timeoutlen = 300
      end,
      opts = {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
      }
    },
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate", -- This command is executed after installation/update
        config = function()
          require'nvim-treesitter.configs'.setup {
            ensure_installed = {"javascript", "typescript", "c", "lua", "rust", "python"},
            sync_install = false,
            auto_install = true,
            highlight = {
              enable = true,
              additional_vim_regex_highlighting = false,
            },
            autotag = {
                enable = true
            }
          }
        end
    },
    {
        'L3MON4D3/LuaSnip',
        event = 'InsertEnter', -- Load LuaSnip when entering insert mode
    },
    {
    'windwp/nvim-autopairs',
        event = "InsertEnter",
        config = true
        -- use opts = {} for passing setup options
        -- this is equalent to setup({}) function
    },
    { "tpope/vim-fugitive", name = "fugitive" },
    {
        'nvim-telescope/telescope.nvim', branch = '0.1.x',
          dependencies = { 'nvim-lua/plenary.nvim' }
    },
    {'williamboman/mason-lspconfig.nvim'},
    {'VonHeikemen/lsp-zero.nvim', branch = 'v3.x'},
    {'neovim/nvim-lspconfig'},
    {'hrsh7th/cmp-nvim-lsp'},
    { "rafamadriz/friendly-snippets" },
    {
        "hrsh7th/nvim-cmp", -- The main completion plugin
        event = "InsertEnter", -- Lazy-load on entering insert mode
        config = function()
            -- Configuration for nvim-cmp here
            local cmp = require("cmp")
            local luasnip = require("luasnip")

            require('luasnip.loaders.from_vscode').lazy_load() -- Optionally, autoload snippets from friendly-snippets

            cmp.setup({
                snippet = {
                    -- You need to specify a snippet engine
                    expand = function(args)
                        -- For example, using luasnip:
                        require('luasnip').lsp_expand(args.body)
                    end,
                },
                mapping = cmp.mapping.preset.insert({
                    ['<C-b>'] = cmp.mapping.scroll_docs(-1),
                    ['<C-f>'] = cmp.mapping.scroll_docs(1),
                    ['<C-Space>'] = cmp.mapping.complete(),
                    ['<C-e>'] = cmp.mapping.abort(),
                    ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to false to only confirm explicitly selected items.
                }),
                sources = cmp.config.sources({
                    { name = 'nvim_lsp' },
                    { name = 'luasnip' },
                    -- More sources as needed
                }),
            })
        end,
        requires = {
            "L3MON4D3/LuaSnip",
            "rafamadriz/friendly-snippets",
            "saadparwaiz1/cmp_luasnip", -- Snippet completions
            "hrsh7th/cmp-nvim-lsp", -- LSP source for nvim-cmp
            -- Add other sources as needed
        },
    },
    {
        "jose-elias-alvarez/null-ls.nvim", -- null-ls plugin
        event = "BufRead", -- You can choose an appropriate event
        config = function()
            local null_ls = require("null-ls")
            -- Setup null-ls
            null_ls.setup({
                -- Register any sources you want to use
                sources = {
                    null_ls.builtins.diagnostics.eslint.with({
                        -- Specify the filetypes you want prettier to format
                        filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact", "css", "scss", "html", "json" },
                    }),
                    -- null_ls.builtins.formatting.eslint.with({
                        -- Specify the filetypes you want prettier to format
                       -- filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact", "css", "scss", "html", "json" },
                    -- }),
                    null_ls.builtins.formatting.prettierd.with({
                      condition = function(utils)
                        return utils.has_file({ ".prettierrc" })
                      end,
                    }),
                    null_ls.builtins.code_actions.eslint.with({
                        -- Specify the filetypes you want prettier to format
                        filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact", "css", "scss", "html", "json" },
                    })
                },
                -- Automatically format files on save
                on_attach = function(client, bufnr)
                    if client.supports_method("textDocument/formatting") then
                        vim.api.nvim_create_autocmd("BufWritePre", {
                            buffer = bufnr,
                            callback = function()
                                -- Use the new vim.lsp.buf.format function with proper arguments
                                vim.lsp.buf.format({
                                    bufnr = bufnr,
                                    timeout_ms = 5000, -- Adjust the timeout as needed
                                })
                            end,
                        })
                    end
                end,
            })
        end,
    },
}
