return {
  "echasnovski/mini.indentscope",
  version = false,

  config = function()
    require("mini.indentscope").setup {
      draw = {
        animation = require('mini.indentscope').gen_animation.none(),
      },
      symbol = '│',
    }

    vim.cmd "hi MiniIndentscopeSymbol guifg=#dc8ed9"
  end,
}
