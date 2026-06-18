require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set
map("n", "<C-h>", "<cmd> TmuxNavigateLeft<CR>", { desc = "window-left" })
map("n", "<C-l>", "<cmd> TmuxNavigateRight<CR>", { desc = "window-right" })
map("n", "<C-j>", "<cmd> TmuxNavigateDown<CR>", { desc = "window-down" })
map("n", "<C-k>", "<cmd> TmuxNavigateUp<CR>", { desc = "window-up" })
map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")
map("i", "kj", "<ESC>")

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
-- map("n", "<C-t>", function()
--   require("nvchad.themes").open {
--     mappings = function(input_buf)
--       vim.api.nvim_create_autocmd("BufWipeout", {
--         buffer = input_buf,
--         once = true,
--         callback = function()
--           vim.schedule(function()
--             require("nvchad.utils").reload()
--           end)
--         end,
--       })
--     end,
--   }
-- end, {})
