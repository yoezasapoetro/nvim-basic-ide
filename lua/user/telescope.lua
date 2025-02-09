local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
    return
end

-- local actions = require "telescope.actions"
-- local trouble = require "trouble.providers.telescope"

-- local telescopee_config = {
--   defaults = {

--     prompt_prefix = " ",
--     selection_caret = " ",
--     path_display = { "smart" },
--     file_ignore_patterns = { ".git/", "node_modules" },

--     mappings = {
--       i = {
--         ["<Down>"] = actions.cycle_history_next,
--         ["<Up>"] = actions.cycle_history_prev,
--         ["<C-j>"] = actions.move_selection_next,
--         ["<C-k>"] = actions.move_selection_previous,
--         ["<C-t>"] = trouble.open_with_trouble,
--       },
--       n = {
--         ["<C-t>"] = trouble.open_with_trouble,
--       },
--     },
--   },
-- }

-- telescope.setup(telescopee_config)

-- telescope.load_extension('harpoon')

telescope.load_extension("refactoring")

local previewers = require("telescope.previewers")
local actions = require("telescope.actions")

telescope.setup({
    defaults = {
        file_sorter = require("telescope.sorters").get_fzy_sorter,
        prompt_prefix = " >",
        color_devicons = true,

        file_previewer = previewers.vim_buffer_cat.new,
        grep_previewer = previewers.vim_buffer_vimgrep.new,
        qflist_previewer = previewers.vim_buffer_qflist.new,

        mappings = {
            i = {
                ["<C-x>"] = false,
                ["<C-q>"] = actions.send_to_qflist,
            },
        },
    },
})
