local colorscheme = "catppuccin"

vim.g.catppuccin_flavour = "mocha"

local status_catppuccin_ok, catppuccin = pcall(require, "catppuccin")
if not status_catppuccin_ok then
    return
end

local colors = require("catppuccin.palettes").get_palette()
colors.none = "NONE"

local catppuccin_config = {
    compile_path = vim.fn.stdpath("cache") .. "/catppuccin",
    transparent_background = true,
    custom_highlights = {
        ColorColumn = { fg = colors.peach },
        Comment = { fg = colors.overlay1 },
        LineNr = { fg = colors.overlay1 },
        CursorLine = { bg = colors.none },
        CursorLineNr = { bg = colors.none },
        DiagnosticVirtualTextError = { bg = colors.none },
		DiagnosticVirtualTextWarn = { bg = colors.none },
		DiagnosticVirtualTextInfo = { bg = colors.none },
		DiagnosticVirtualTextHint = { bg = colors.none }
    },
}

catppuccin.setup(catppuccin_config)

local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
  return
end
