return{
  {"craftzdog/solarized-osaka.nvim", lazy = false, priority = 1000},
  Config = function()

    require("osaka").setup ({

      opts =
      {
          transparent = true,
          terminal_colors = true,
          styles =
          {
            sidebars = "transparent",
            floats = "dark",
          }
       }

    })
  end,

  {"ellisonleao/gruvbox.nvim"},
}
