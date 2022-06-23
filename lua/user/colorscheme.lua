local colorscheme = "catppuccin"

vim.g.catppuccin_flavour = "mocha"

local status_catppuccin_ok, catppuccin = pcall(require, "catppuccin")
if not status_catppuccin_ok then
    return
end

local catppuccin_config = {
    compile_path = vim.fn.stdpath("cache") .. "/catppuccin",
    transparent_background = true,
    term_colors = false,
    dim_inactive = {
        enabled = false,
        shade = "dark",
        percentage = 0.15,
    },
    styles = {
        comments = { "italic" },
        conditionals = { "italic" },
        loops = {},
        functions= {},
        keywords= {},
        strings = {},
        variables = {},
        numbers = {},
        booleans = {},
        properties = {},
        types = {},
        operators = {},
    },
    integrations = {
        cmp = true,
        gitsigns = true,
        telescope = true,
        treesitter = true,
        harpoon = true,
        lsp_saga = true,
        treesitter_context = true,
        lsp_trouble = true,
        illuminate = true,
        dap = {
            enabled = true,
            enable_ui = true,
        },
        native_lsp = {
            enabled = true,
            virtual_text = {
                errors = { "italic" },
                hints = { "italic" },
                warnings = { "italic" },
                information = { "italic" },
            },
            underlines = {
                errors = { "underline" },
                hints = { "underline" },
                warnings = { "underline" },
                information = { "underline" },
            },
        },
    },
    color_overrides = {},
    custom_highlights = {},
}

catppuccin.setup(catppuccin_config)

local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
  return
end
