require("yazi").setup({
    open_for_directories = true,
    keymaps = {
        show_help = '<f1>',
        open_file_in_vertical_split = '<c-v>',
        open_file_in_horizontal_split = '<c-h>',
        open_file_in_tab = '<c-t>',
        grep_in_directory = '<c-f>',
        replace_in_directory = '<c-r>',
        cycle_open_buffers = '<tab>',
        copy_relative_path_to_selected_files = '<c-y>',
        send_to_quickfix_list = '<c-q>',
    }
})
