local status_ok, configs = pcall(require, "nvim-treesitter.configs")
if not status_ok then
	return
end

local status_tsc_ok, tsc_configs = pcall(require, "treesitter-context")
if not status_tsc_ok then
    return
end

tsc_configs.setup({
    enable = true,
    max_linex = 0,
    trim_scope = 'outer',
    min_window_height = 0,
    patterns = {
        default = {
            'class',
            'function',
            'method',
            'for',
            'while',
            'if',
            'switch',
            'case',
        },
        json = {
            'pair',
        },
        typescript = {
            "class_abstraction",
            "abstract_class_declaration",
            "else_clause",
        },
    },
    exact_patterns = {},
    zindex = 20,
    mode = "cursor",
    separator = nil,
})

configs.setup({
	ensure_installed = "java", -- one of "all" or a list of languages
    sync_install = false,
	ignore_install = { "" }, -- List of parsers to ignore installing
	highlight = {
		enable = true, -- false will disable the whole extension
		disable = { "css" }, -- list of language that will be disabled
        additional_vim_regex_highlighting = false,
	},
	-- autopairs = {
	-- 	enable = true,
	-- },
	indent = { enable = true, disable = { "python", "css" } },
})
