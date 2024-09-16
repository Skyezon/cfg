-- local actions = require('telescope.actions')
-- local builtin = require('telescope.builtin')

-- Define a pre-hook function to save the buffer
local function save_before_telescope(prompt_bufnr)
    if vim.bo.modified then
        vim.api.nvim_command('write')
    end
    actions.close(prompt_bufnr)
end

require('telescope').setup {
    extensions = {
        fzf = {
            fuzzy = true,          -- false will only do exact matching
            override_generic_sorter = true, -- override the generic sorter
            override_file_sorter = true, -- override the file sorter
            case_mode = "smart_case", -- or "ignore_case" or "respect_case"
            -- the default case_mode is "smart_case"
        }
    },
    defaults = {
        pre = function(prompt_bufnr)
            save_before_telescope(prompt_bufnr)
        end }
}

require('telescope').load_extension("fzf")
