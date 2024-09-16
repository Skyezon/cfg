require('lualine').setup({
    sections = {
        lualine_c = {
            function()
                return require('lsp-progress').progress()
            end
        }
    }
})

vim.api.nvim_create_augroup("lualine_augroup", { clear = true })
vim.api.nvim_create_autocmd("User", {
  group = "lualine_augroup",
  pattern = "LspProgressStatusUpdated",
  callback = require("lualine").refresh,
})
