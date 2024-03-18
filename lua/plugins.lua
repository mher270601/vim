--vim.cmd [[packadd packer.nvim]]

local ensure_packer = function()
    local fn = vim.fn
    local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
        vim.cmd [[packadd packer.nvim]]
        return true
    end
    return false
end

local packer_bootstrap = ensure_packer()
local packer = require('packer')

return packer.startup(function(use)
    -- Packer can manage itself
    use "wbthomason/packer.nvim"

    -- Color scheme
    use "EdenEast/nightfox.nvim"

    -- Tig
    use {
        -- This version support git-blame
        "thomasjachmann/vim-tig",
        branch = 'more_complex_parameters',
        requires = {
            -- Delete buffer while preserved windows layout
            use {
                "ojroques/nvim-bufdel",
                config = function()
                    require("bufdel").setup {
                        quit = false
                    }
                end
            }
        }
    }

    -- fuzzy search
    -- Note: Must install ripgrep
    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.0',
        requires = {
            -- find project root
            'notjedi/nvim-rooter.lua',
            'nvim-lua/plenary.nvim'
        }
    }

    use {
        "folke/which-key.nvim",
        config = function()
            require("which-key").setup()
        end
    }

    use {
        'TimUntersberger/neogit',
        opt = true,
        requires = 'nvim-lua/plenary.nvim'
    }

    use "ntpeters/vim-better-whitespace"

    use {
        "danymat/neogen",
        config = function()
            require('neogen').setup {
				--[[
				enabled = true,
				languages = {
					c = {
						template = {
							annotation_convention = "doxygen",
							doxygen = {
								{ nil, "/**", { no_results = true, type = { "func", "file", "class" } } },
								{ nil, " * @file", { no_results = true, type = { "file" } } },
								{ nil, " * func - $1", { no_results = true, type = { "func", "file", "class" } } },
								{ nil, " */", { no_results = true, type = { "func", "file", "class" } } },
								{ nil, "", { no_results = true, type = { "file" } } },

								{ nil, "/**", { type = { "func", "class", "type" } } },
								{ "class_name", " * %s - $1", { type = { "class" } } },
								{ "func_name", " * %s - $1", { type = { "func", "class", "type" } } },
								{ "tparam", " * @%s: $1" },
								{ "parameters", " * @%s: $1" },
								{ "return_statement", " * Return $1" },
								{ nil, " */", { type = { "func", "class", "type" } } },
							}
						}
					},
				}
				--]]
            }
        end,
        requires = "nvim-treesitter/nvim-treesitter",
        -- Uncomment next line if you want to follow only stable versions
        -- tag = "*"
    }

    use {
        "akinsho/toggleterm.nvim",
        tag = '*',
        config = function()
            require("toggleterm").setup{
                open_mapping = [[<c-\><c-\>]],
                direction = 'float',
            }
        end
    }

    use { "nvim-telescope/telescope-file-browser.nvim" }

    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'kyazdani42/nvim-web-devicons' },
        config = function()
            require'lualine'.setup {
                sections = {
                    lualine_b = { 'branch', 'diff' },
                    lualine_c = {
                        {
                            'filename',
                            file_status = true,
                            -- path absolute with tilde=3 absolute=2 relative=1 filename=0
                            path = 3
                        }
                    },
                    lualine_x = { 'filetype' }
                },
                inactive_sections = {
                    lualine_c = { '%f [%n]' },
                }
            }
        end
    }

    -- For starting page
    use {
        'goolord/alpha-nvim',
        requires = { 'kyazdani42/nvim-web-devicons' },
        config = function()
            require'alpha'.setup(require'alpha.themes.theta'.config)
        end
    }

    -- Config for nvim LSP
    use {
        'VonHeikemen/lsp-zero.nvim',
        requires = {
            -- LSP Support
            {'neovim/nvim-lspconfig'},
            {'williamboman/mason.nvim'},
            {'williamboman/mason-lspconfig.nvim'},

            -- Autocompletion
            {'hrsh7th/nvim-cmp'},
            {'hrsh7th/cmp-buffer'},
            {'hrsh7th/cmp-path'},
            {'saadparwaiz1/cmp_luasnip'},
            {'hrsh7th/cmp-nvim-lsp'},
            {'hrsh7th/cmp-nvim-lua'},

            -- Snippets
            {'L3MON4D3/LuaSnip'},
            {'rafamadriz/friendly-snippets'},
        }
    }

    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if packer_bootstrap then
        require('packer').sync()
    else
        require('config/lsp')
        require('config/rooter')
        require('config/telescope')
        require('config/cmp')
    end
end)
