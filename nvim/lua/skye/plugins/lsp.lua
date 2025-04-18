local servers = {
    "lua_ls",        --lua
    "rust_analyzer", --rust
    "biome",         --new javascript
    "ts_ls",         --typescript & javascript
    "dockerls",      --docker
    "gopls",         --go
    "pyright",       -- py
    "jdtls",         --java
    "html",          --html
    "unocss",        --css
    "vimls",         --vim
    "svelte",        --svelte
    "intelephense",  --php
    "omnisharp",     --c#,
    "clangd",        -- c & c++
    "sonarlint"
}

require('mason').setup()
require("mason-lspconfig").setup {
    ensure_installed = servers
}

require("lspsaga").setup()
require('lsp-progress').setup()
require("lsp_signature").setup({
    hint_enable = true, -- Enable signature hints
    hint_prefix = "🔶 ", -- Prefix for the hint
    hint_scheme = "String", -- Scheme for highlighting the hint
    floating_window = true, -- Display hints in a floating window
    hi_parameter = "Search" -- Highlight the parameter under the cursor
})


local lspconfig = require("lspconfig")
-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('UserLspConfig', {}),
    callback = function(ev)
        --https://github.com/OmniSharp/omnisharp-roslyn/issues/2483#issuecomment-1539809155
        --there sees to be some issue regarding omnisharp and nvim semantics, workaround:
        local client = vim.lsp.get_client_by_id(ev.data.client_id)
        local function toSnakeCase(str)
            return string.gsub(str, "%s*[- ]%s*", "_")
        end

        if client.name == 'omnisharp' then
            local tokenModifiers = client.server_capabilities.semanticTokensProvider.legend.tokenModifiers
            for i, v in ipairs(tokenModifiers) do
                tokenModifiers[i] = toSnakeCase(v)
            end
            local tokenTypes = client.server_capabilities.semanticTokensProvider.legend.tokenTypes
            for i, v in ipairs(tokenTypes) do
                tokenTypes[i] = toSnakeCase(v)
            end
        end

        -- Enable completion triggered by <c-x><c-o>
        -- vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

        -- Buffer local mappings.
        -- See `:help vim.lsp.*` for documentation on any of the below functions
        local lpts = { buffer = ev.buf }
    end,
})


-- nvim-cmp setup
local cmp = require 'cmp'

cmp.setup({
    snippet = {
        -- REQUIRED - you must specify a snippet engine
        expand = function(args)
            -- vim.fn["vsnip#anonymous"](args.body)     -- For `vsnip` users.
            --require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
            -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
            vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
            -- vim.snippet.expand(args.body) -- For native neovim snippets (Neovim v0.10+)
        end,
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'ultisnips' },
        { name = 'buffer' },
    })
})

-- To use git you need to install the plugin petertriho/cmp-git and uncomment lines below
-- Set configuration for specific filetype.
--[[ cmp.setup.filetype('gitcommit', {
    sources = cmp.config.sources({
      { name = 'git' },
    }, {
      { name = 'buffer' },
    })
 })
 require("cmp_git").setup() ]] --

-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline({ '/', '?' }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
        { name = 'buffer' }
    }
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
        { name = 'path' }
    }, {
        { name = 'cmdline' }
    }),
    matching = { disallow_symbol_nonprefix_matching = false }
})

-- Set up lspconfig.
-- local capabilities = require('cmp_nvim_lsp').default_capabilities()
-- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
-- require('lspconfig')['<YOUR_LSP_SERVER>'].setup {
--   capabilities = capabilities
-- }

-- Add additional capabilities supported by nvim-cmp
local capabilities = require("cmp_nvim_lsp").default_capabilities()
-- Enable some language servers with the additional completion capabilities offered by nvim-cmp
for _, lsp in ipairs(servers) do
    if lsp == 'sonarlint' then
        -- Set up SonarLint
        -- lspconfig.sonarlint.setup({
        --     capabilities = capabilities,
        --     flags = {
        --         debounce_text_changes = 150,
        --     },
        --     filetypes = { "java", "go", "javascript", "typescript", "python", "php", "c#", "html" },
        --     cmd = {
        --         vim.fn.stdpath('data') ..
        --         '/mason/bin/sonarlint-language-server', -- Path to the SonarLint executable installed by Mason
        --         '-stdio'
        --     }
        -- })
    else
        lspconfig[lsp].setup {
            capabilities = capabilities,
        }
    end
end
