local function check_fzf()
    -- Check if fzf plugin is installed
    local fzf_plugin_installed = vim.fn.exists('g:fzf') == 1

    -- Check if fzf binary is available in PATH
    local fzf_binary_installed = vim.fn.system('which fzf'):find("fzf") ~= nil

    -- Combine the checks and notify the result
    if fzf_plugin_installed and fzf_binary_installed then
        vim.notify("fzf plugin and binary are both installed and ready to use", vim.log.levels.INFO)
    elseif fzf_plugin_installed then
        vim.notify("fzf plugin is installed but binary is not in PATH", vim.log.levels.WARN)
    elseif fzf_binary_installed then
        vim.notify("fzf binary is installed but plugin is not loaded", vim.log.levels.WARN)
    else
        vim.notify("fzf is not installed", vim.log.levels.ERROR)
    end
end
