local M = {}

local telescope = require('telescope')
telescope.setup {
    pickers = { find_files = { hidden = true } },
    defaults = {
        file_ignore_patterns = { "^./.git/", "^node_modules/" }
    },
    extensions = {
        file_browser = {
            hijack_netrw = true,
        }
    }
}

telescope.load_extension "file_browser"

return M
