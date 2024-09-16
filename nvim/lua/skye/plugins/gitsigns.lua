require('gitsigns').setup {
    current_line_blame = true,
    signs_staged = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '-' },
    },
    on_attach = function(bufnr)
        local gitsigns = require('gitsigns')

        local function map(mode, l, r, opts)
            opts = opts or {}
            opts.buffer = bufnr
            vim.keymap.set(mode, l, r, opts)
        end

        -- Navigation
        map('n', ']c', function()
            if vim.wo.diff then
                vim.cmd.normal({ ']c', bang = true })
            else
                gitsigns.nav_hunk('next')
            end
        end)

        map('n', '[c', function()
            if vim.wo.diff then
                vim.cmd.normal({ '[c', bang = true })
            else
                gitsigns.nav_hunk('prev')
            end
        end)

        map('n', '<leader>hb', function() gitsigns.blame_line { full = true } end)
        map('n', '<leader>hp', gitsigns.preview_hunk)
        -- map('n', '<leader>tb', gitsigns.toggle_current_line_blame)
        -- map('n', '<leader>hd', gitsigns.diffthis)
        -- map('n', '<leader>hD', function() gitsigns.diffthis('~') end)
    end

}
