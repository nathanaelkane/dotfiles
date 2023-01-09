return {
  "echasnovski/mini.trailspace",
  event = "BufEnter",

  config = function()
    require('mini.trailspace').setup()
  end,

  keys = {
    {"<Leader>sw", ":lua MiniTrailspace.trim()<CR>:up<CR>"},
  },
}
