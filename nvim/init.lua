--
-- Neovim configuration
--
-- TODO:
--   - Make LSP display in statusline look like Helix
--   - Fix whitespace error hilighting
--   - Consider removing italics from theme
--   - Autocmd for Linux coding style
--

-- Vim editor options
vim.opt.expandtab = true    -- Use spaces instead of tabs
vim.opt.softtabstop = 4     -- Tabs are four spaces wide
vim.opt.shiftwidth = 4      -- Indentation is four spaces wide

-- Vim file options
vim.opt.encoding = 'utf-8'
vim.opt.backup = false
vim.opt.swapfile = false
vim.opt.autoread = true     -- Re-read modified files if we've made no edits

-- Vim search options
vim.opt.ignorecase = true   -- Case insensitive with a lower-case search string
vim.opt.smartcase = true    -- Case sensitive with a mixed-case search string

-- Vim spell checking
vim.opt.spelllang = 'en_nz'
vim.opt.spellfile = vim.fn.expand ('~/.vim/spell/words.utf-8.add');
vim.opt.spell = true

-- Vim interface settings
vim.opt.number = true       -- Show line numbers
vim.opt.scrolloff = 5       -- Show at least five lines of context
vim.opt.showmode = false    -- Hide the duplicate mode indicator
vim.opt.title = true        -- Set the window title to the file being edited
vim.opt.cursorline = true
vim.opt.cursorlineopt = "number"
vim.g.c_space_errors = 1    -- Hilight space errors

-- LSP Configuration
vim.lsp.config('*', {
    capabilities = {
        textDocument = {
            semanticTokens = { multilineTokenSupport = true }
        }
    },
    root_markers = { '.git' },
})

vim.lsp.config ('clangd', {
    cmd = { 'clangd' },
    root_markers = { '.git', '.clangd', 'compile_flags.txt', 'compile_commands.json' },
    filetypes = { 'c', 'cpp' }
})
vim.lsp.enable ('clangd')

vim.diagnostic.config( { virtual_text = true } )

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath)
then
    local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
    local out = vim.fn.system({ 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath })
    if vim.v.shell_error ~= 0
    then
        vim.api.nvim_echo({
            { "Failed to clone lazy.nvim:\n", 'ErrorMsg' },
            { out, 'WarningMsg' },
            { "\nPress any key to exit..." },
        }, true, {})
    vim.fn.getchar()
    os.exit(1)
    end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Setup lazy.nvim
require('lazy').setup({
    spec = {
        -- add your plugins here
        { 'catppuccin/nvim', name = 'catppuccin', priority = 1000 },
        { 'echasnovski/mini.nvim', version = false },
	{ 'nvim-treesitter/nvim-treesitter', build = ':TSUpdate'}
    },
    -- Configure any other settings here. See the documentation for more details.
    -- colorscheme that will be used when installing plugins.
    install = { colorscheme = { 'habamax' } },
    -- automatically check for plugin updates
    checker = { enabled = true },
})

-- TODO: Remove italics
-- TODO: C space errors currently only visibile when cursor is over them
-- TODO: Can tree-sitter hilighting be made the same as helix?
--       (Currently, nvim gives #define and #include as different colours)
vim.cmd.colorscheme 'catppuccin-mocha'

require'nvim-treesitter.configs'.setup {
    ensure_installed = { 'c', 'fish', 'html', 'javascript', 'lua', 'rust', 'zig' },
    highlight = { enable = true}
}

require ('mini.diff').setup ({
    view = {
        style = 'sign',
        signs = { add = '┃', change = '┃', delete = '┃' }
    }
});

require ('mini.statusline').setup ({
   use_icons = false
});

-- Don't show diff info in statusline
MiniStatusline.section_diff = function (args)
   return ''
end

-- Simplify file info.
-- No icon, no filesize. Only show the format or encoding if they're weird.
MiniStatusline.section_fileinfo = function (args)

    local encoding = vim.bo.fileencoding or vim.bo.encoding
    local format = vim.bo.fileformat

    if encoding == '' then encoding = '-' end

    if (encoding ~= 'utf-8' and encoding ~= '-') or format ~= 'unix'
    then
        return string.format('%s [%s]', encoding, format)
    else
       return ''
    end
end

-- Simplify location to <line>:<col>
MiniStatusline.section_location = function (args)
    return '%l:%v'
end

