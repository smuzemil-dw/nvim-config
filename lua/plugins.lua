return {
    {"neovim/nvim-lspconfig"},
    {
        "goolord/alpha-nvim",
        lazy = true,
        event = "VimEnter",
        config = function()
            require('alpha').setup(require('alpha.themes.startify').config)
        end,
    },
    {"kyazdani42/nvim-tree.lua",
        dependencies = "kyazdani42/nvim-web-devicons",
        config = function()
          require("nvim-tree").setup()
        end
      },
    { 
        'akinsho/bufferline.nvim', 
            version = "*", 
            dependencies = 'nvim-tree/nvim-web-devicons',
            config= function()
                require('bufferline').setup {
                options = {
                    numbers = "ordinal",
                    close_command = "bdelete! %d",
                    right_mouse_command = "bdelete! %d",
                    left_mouse_command = "buffer %d",
                    middle_mouse_command = nil,
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
        "nvim-lualine/lualine.nvim",
        event = "VimEnter",
        config = function()
            require('lualine').setup {
                options = {
                    icons_enabled = true,
                    theme = 'auto',
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
      opts = {}
    },
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
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
        "nvim-treesitter/nvim-treesitter-context"
    },
    {
        'L3MON4D3/LuaSnip',
        event = 'InsertEnter',
    },
    {
    'windwp/nvim-autopairs',
        event = "InsertEnter",
        config = true
    },
    { "tpope/vim-fugitive", name = "fugitive" },
    {
        'nvim-telescope/telescope.nvim', branch = '0.1.x',
          dependencies = { 'nvim-lua/plenary.nvim' }
    },
    {'williamboman/mason-lspconfig.nvim'},
    {'VonHeikemen/lsp-zero.nvim', branch = 'v3.x'},
    {'hrsh7th/cmp-nvim-lsp'},
    { "rafamadriz/friendly-snippets" },
    {"norcalli/nvim-colorizer.lua"},
    {
        "hrsh7th/nvim-cmp",
        event = "InsertEnter",
        config = function()
            local cmp = require("cmp")
            local luasnip = require("luasnip")

            require('luasnip.loaders.from_vscode').lazy_load()

            cmp.setup({
                snippet = {
                    expand = function(args)
                        require('luasnip').lsp_expand(args.body)
                    end,
                },
                mapping = cmp.mapping.preset.insert({
                    ['<C-b>'] = cmp.mapping.scroll_docs(-1),
                    ['<C-f>'] = cmp.mapping.scroll_docs(1),
                    ['<C-Space>'] = cmp.mapping.complete(),
                    ['<C-e>'] = cmp.mapping.abort(),
                    ['<CR>'] = cmp.mapping.confirm({ select = true }),
                }),
                sources = cmp.config.sources({
                    { name = 'nvim_lsp' },
                    { name = 'luasnip' },
                }),
            })
        end,
        requires = {
            "L3MON4D3/LuaSnip",
            "rafamadriz/friendly-snippets",
            "saadparwaiz1/cmp_luasnip",
            "hrsh7th/cmp-nvim-lsp",
        },
    },
    {
        "nvimtools/none-ls.nvim",
        event = "BufRead",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            local null_ls = require("null-ls")
            null_ls.setup({
                sources = {
                    null_ls.builtins.formatting.prettierd.with({
                      condition = function(utils)
                        return utils.has_file({ ".prettierrc" })
                      end,
                    }),
                },
                on_attach = function(client, bufnr)
                    if client.supports_method("textDocument/formatting") then
                        vim.api.nvim_create_autocmd("BufWritePre", {
                            buffer = bufnr,
                            callback = function()
                                vim.lsp.buf.format({
                                    bufnr = bufnr,
                                    timeout_ms = 5000,
                                })
                            end,
                        })
                    end
                end,
            })
        end,
    },
    {
        "kylechui/nvim-surround",
        version = "*",
        event = "VeryLazy",
        config = function()
            require("nvim-surround").setup({})
        end
    }
}
