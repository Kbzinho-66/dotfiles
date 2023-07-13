-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local function map(mode, lhs, rhs, opts)
  local keys = require("lazy.core.handler").handlers.keys
  ---@cast keys LazyKeysHandler
  -- do not create the keymap if a lazy keys handler exists
  if not keys.active[keys.parse({ lhs, mode = mode }).id] then
    opts = opts or {}
    opts.silent = opts.silent ~= false
    if opts.remap and not vim.g.vscode then
      opts.remap = nil
    end
    vim.keymap.set(mode, lhs, rhs, opts)
  end
end

-- Copy and paste from clipboard
map({ "v", "n", "o" }, "<leader>y", '"+y', { remap = true, silent = true, desc = "Yank selection to clipboard" })
map({ "v", "n", "o" }, "<leader>Y", '"+yg_', { remap = true, silent = true, desc = "Yank to end of line to clipboard" })
map({ "v", "n", "o" }, "<leader>p", '"+p', { remap = true, silent = true, desc = "Paste from clipboard" })
map({ "v", "n", "o" }, "<leader>P", '"+P', { remap = true, silent = true, desc = "Backward paste from clipboard" })

-- Paste over currently selected text without yanking it
map("v", "p", '"_dP')

-- Move Lines
map("n", "<A-J>", "<cmd>m .+1<cr>==", { desc = "Move down" })
map("n", "<A-K>", "<cmd>m .-2<cr>==", { desc = "Move up" })
map("i", "<A-J>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move down" })
map("i", "<A-K>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move up" })
map("v", "<A-J>", ":m '>+1<cr>gv=gv", { desc = "Move down" })
map("v", "<A-K>", ":m '<-2<cr>gv=gv", { desc = "Move up" })
