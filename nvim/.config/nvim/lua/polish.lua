--if true then return end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- This will run last in the setup process.
-- This is just pure lua so anything that doesn't
-- fit in the normal config locations above can go here

-- Swap ; and :
vim.cmd [[
  nnoremap ; :
  nnoremap : ;
]]

-- Make the command buffer more spacious
vim.cmd [[
  set cmdheight=2
]]
