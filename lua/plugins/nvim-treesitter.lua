local config = function() 
  require('nvim-treesitter.configs').setup({
    indent = {
      enable = true,
    },
    autotag = {
      enable = true,
    },
    ensure_installed = { 
      "lua", 
      "javascript",
      "typescript",
      "css",
      "markdown",
      "gitignore",
      "python",
      "lua",
      "rust",
      "bash",
      "vue",
      "html",
      "yaml",
      "json",
    },
    auto_install = true,
    highlight = {
      enable = true,
      additional_vim_regex_highlighting = true,
    },
  })
end

return {
  "nvim-treesitter/nvim-treesitter",
  lazy = false,
  config = config
}
