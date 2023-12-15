return {
  {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    lazy = false,
    dependencies = {
      "nvim-tree/nvim-web-devicons"
    },
    config = function()
      require("nvim-tree").setup {
        view = {
          width = {
            min = 30,
            max = 150,
          }
        }
      }
    end
  }
}
