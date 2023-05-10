-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
	-- (optional) for :ObsidianSearch and :ObsidianQuickSwitch commands unless you use telescope:
	'junegunn/fzf',
	'junegunn/fzf.vim',

	-- (optional) another alternative for the :ObsidianSearch and :ObsidianQuickSwitch commands:
	'ibhagwan/fzf-lua',

	-- (optional) for :ObsidianSearch and :ObsidianQuickSwitch commands if you prefer this over fzf.vim:
	'nvim-telescope/telescope.nvim',

	-- (optional) recommended for syntax highlighting, folding, etc if you're not using nvim-treesitter:
	'preservim/vim-markdown',
	'godlygeek/tabular', -- needed by 'preservim/vim-markdown'

	{ -- deleteme since this is a repeat
		"simrat39/symbols-outline.nvim",
		cmd = "SymbolsOutline",
		keys = { { "<leader>cs", "<cmd>SymbolsOutline<cr>", desc = "Symbols Outline" } },
		opts = {
			-- add your options that should be passed to the setup() function here
			position = "right",
		},
	},
	-- (required)
	{

		'epwalsh/obsidian.nvim',
		opts = {
			dir = "~/Notes-Vault",
			-- notes_subdir = "notes",
			daily_notes = {
				folder = "journals",
			}
		}
	},
	'amarakon/vim-sensible',
}
