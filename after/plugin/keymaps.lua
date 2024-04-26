vim.keymap.set("n", "<leader>pv", function() vim.cmd("Ex") end)

vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Switch to left window "}) 
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Switch to right window "}) 
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Switch to bottom window "})
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Switch to top window "}) 

vim.keymap.set("n", "<leader>v", "<C-w>v", { desc = "Create a vertical split window" })
vim.keymap.set("n", "<leader>s", ":sp", { desc = "Create a horizontal split window" })

vim.api.nvim_set_keymap('n', '<leader>l', ':BufferLineCycleNext<CR>', { desc = "Switch to the right buffer", noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>h', ':BufferLineCyclePrev<CR>', { desc = "Switch to the left buffer", noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>n', ':enew<CR>', { desc = "Create a new buffer window", noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>x', ':bd<CR>', { desc = "Close the current buffer", noremap = true, silent = true })

vim.keymap.set("n", "<C-s>h", ":sb", { noremap = true, silent = true, desc = "Move buffer to new horizontal window" })
vim.keymap.set("n", "<C-s>v", ":vert sb", { noremap = true, silent = true, desc = "Move buffer to a new vertical window" })

vim.keymap.set('n', '<leader>ca', ':lua vim.lsp.buf.code_action()<CR>', { noremap = true, silent = true, desc = "LSP Code Actions" })

vim.keymap.set('n', '<leader>e', ':NvimTreeToggle<CR>', {noremap = true, silent = true, desc="Toggle nvim-tree menu"})

vim.keymap.set("n", "sj", ":lua vim.diagnostic.goto_next()<CR>", { desc = "Jump to next ESLint error", silent = true })
vim.keymap.set("n", "sk", ":lua vim.diagnostic.goto_prev()<CR>", { desc = "Go to previous ESLint error", silent = true })
vim.keymap.set("n", "sx", ":lua vim.diagnostic.open_float()<CR>", { desc = "Expand ESLint error", silent = true })
