return {
  { "nvim-treesitter", enabled = false },
  { "nvim-treesitter-textobjects", enabled = false },
-- codeium.nvim
--{"codeium.nvim", enabled = false },
  -- 在 markdown 文件类型时禁用 codeium.nvim 插件
  {
    "codeium.nvim",
    enabled = vim.fn.expand("%:e") ~= "md"  -- 如果文件类型是 markdown (.md)，则禁用该插件
  },
}
