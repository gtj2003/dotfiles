-- Plugins for Nvim setup
return {
	-- Файловый менеджер
	{
		"nvim-tree/nvim-tree.lua",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
		require("nvim-tree").setup({
		view = { width = 30 },
		filters = { dotfiles = false },
		git = { enable = true },
		actions = {
			open_file = {
				quit_on_open = true, -- закроет дерево после открытия файла
			},
		},
		-- авто-закрытие при последнем буфере
		-- только если включена эта настройка:
		hijack_netrw = true,
		})
		end,
	},

	-- Поиск по файлам
	{
		"nvim-telescope/telescope.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
		require('telescope').setup({
			-- Тут какие-то настройки
		})
		-- require('telescope').load_extension('fzf')
		end
	},

	-- tree-sitter используется для парсинга сходников
	-- :checkhealth nvim-treesitter
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function()
			local configs = require("nvim-treesitter.configs")
			configs.setup({
				-- Парсеры для каждого языка нужно ставить отдельно
				ensure_installed = {
					"c", 
					"lua", 
					"vim", 
					"vimdoc", 
					"python", 
					"go", 
					"rust", 
					"java", 
					"javascript",
					"php", 
					"vue", 
					"html", 
					"json", 
					"toml", 
					"yaml",
					"verilog"
				},
				sync_install = false,
				auto_install = true,
				highlight = { enable = true},
				indent = { enable = true },
			})
		end
	},

	-- To Support textobjects
	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		dependencies = "nvim-treesitter/nvim-treesitter",
	},
  
	-- Выделение отступов
	{
		"lukas-reineke/indent-blankline.nvim",
		config = function()
			require("ibl").setup()
		end
	},

	-- Нижняя строка статуса
	{
		"nvim-lualine/lualine.nvim",
		dependencies = 'nvim-tree/nvim-web-devicons',
		config = function()
		require('lualine').setup({
			sections = {
				lualine_x = {
					-- Добавим отображение раскладки
					{
						function()
							if vim.opt.iminsert:get() > 0 and vim.b.keymap_name then
								return '⌨ ' .. vim.b.keymap_name
							end
							return ''
						end,
						cond = function() -- Показывать только если раскладка активна
							return vim.opt.iminsert:get() > 0 and vim.b.keymap_name ~= nil
						end,
					},
					'encoding',
					'fileformat',
					'filetype',
				}
			}
		})
		end
	},

	-- Верхняя строка статуса (заменяет табы)
	{
		'akinsho/bufferline.nvim',
		version = "*",
		dependencies = 'nvim-tree/nvim-web-devicons',
		config = function()
			require("bufferline").setup {
				options = {
				mode = "buffers",
				separator_style = "slant"
				}
			}
		end,
	},

	-- Фиксим прозрачность
	{
		"xiyaowong/transparent.nvim",
		config = function()
			require('transparent').setup({
				extra_groups = {
				'NormalFloat', -- plugins which have float panel such as Lazy, Mason, LspInfo
				},
				exclude_groups = { 'CursorLine' },
			})
		end
	},

	-- Catpuccin theme!
	{
		"catppuccin/nvim",
		lazy = false,
		name = "catppuccin",
		priority = 1000,
		config = function()
			require("catppuccin").setup({
				transparent_background = true,
			})
			vim.cmd.colorscheme "catppuccin-latte"
		end
	}
}
