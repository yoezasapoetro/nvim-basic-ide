local status_ok, mason = pcall(require, "mason")
if not status_ok then
    return
end

local servers = {
    "cssls",
    "html",
    "tsserver",
    "jsonls",
    "jdtls",
    "vuels", -- vue 2.6.x
    -- "volar", -- vue 3.x and vue 2.7.x
}

mason.setup()

local lspconfig_status_ok, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status_ok then
    return
end

local opts = {}

for _, server in pairs(servers) do
    opts = {
        on_attach = require("user.lsp.handlers").on_attach,
        capabilities = require("user.lsp.handlers").capabilities,
    }

    if server == "tsserver" then
        local tsserver_opts = {
            settings = {
                typescript = {
                    format = {
                        convertTabsToSpaces = false
                    }
                },
                javascript = {
                    format = {
                        convertTabsToSpaces = true
                    }
                }
            }
        }
        opts = vim.tbl_deep_extend("force", tsserver_opts, opts)
    end

    if server == "vuels" then
        local vetur_opts = {
            settings = {
                vetur = {
                    completion = {
                    },
                    format = {
                        options = {
                            tabSize = 4,
                            useTabs = false,
                        },
                        defaultFormatter = {
                            js = "prettier",
                            html = "prettier",
                            scss = "prettier",
                        }
                    },
                },
            }
        }
        opts = vim.tbl_deep_extend("force", vetur_opts, opts)
    end

    if server == "jdtls" then goto continue end

    lspconfig[server].setup(opts)
    ::continue::
end
