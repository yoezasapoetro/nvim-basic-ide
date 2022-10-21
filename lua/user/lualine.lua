M = {}
local status_ok, lualine = pcall(require, "lualine")
if not status_ok then
  return
end

local hide_in_width = function()
  return vim.fn.winwidth(0) > 80
end

local buffer_not_empty = function()
    return vim.fn.empty(vim.fn.expand('%:t')) ~= 1
end

local diagnostics = {
  "diagnostics",
  sources = { "nvim_diagnostic" },
  sections = { "error", "warn" },
  symbols = { error = " ", warn = " " },
  colored = false,
  always_visible = true,
}

-- local diff = {
--   "diff",
--   colored = false,
--   symbols = { added = "", modified = "", removed = "" }, -- changes diff symbols
--   cond = hide_in_width,
-- }

local filename = {
    "filename",
    cond = buffer_not_empty,
    path = 1
}

local location = {
  "location",
  padding = 0,
}

-- local spaces = function()
--   return "spaces: " .. vim.api.nvim_buf_get_option(0, "shiftwidth")
-- end

local function contains(t, value)
    for _, v in pairs(t) do
        if v == value then
            return true
        end
    end
    return false
end

local language_server = {
    function()
        local buf_ft = vim.bo.filetype
        local ui_filetypes = {
            "help",
            "packer",
            "Outline",
            "DressingSelect",
            "TelescopePrompt",
            "lspinfo",
            "lsp-installer",
            ""
        }

        if contains(ui_filetypes, buf_ft) then
            if M.language_servers == nil then
                return ""
            else
                return M.language_servers
            end
        end

        local clients = vim.lsp.buf_get_clients(0)
        local client_names = {}

        -- add client
        for _, client in pairs(clients) do
            client_names[#client_names + 1] = client.name
        end

        -- join client names with commas
        local client_names_str = table.concat(client_names, ", ")

        -- check client_names_str if empty
        local language_servers = ""
        local client_names_str_len = #client_names_str
        if client_names_str_len ~= 0 then
            language_servers = client_names_str
        end

        if client_names_str_len == 0 then
            return ""
        else
            M.language_server = language_servers
            return language_servers:gsub(", anonymous source", "")
        end
    end,
    padding = 1,
    icon = ' LSP:',
    cond = hide_in_width,
}

local lualine_config = {
    options = {
        globalstatus = true,
        icons_enabled = true,
        theme = "catppuccin",
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
        always_divide_middle = true,
    },
    sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch" },
        lualine_c = { diagnostics, filename },
        -- lualine_x = { diff, spaces, "encoding", filetype },
        lualine_x = { language_server },
        lualine_y = {  },
        lualine_z = { location, "progress" },
    },
    inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {},
        lualine_x = { location },
        lualine_y = {},
        lualine_z = {},
    },
    tabline = {},
    extensions = {},
}

lualine.setup(lualine_config)
