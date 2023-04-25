return {
  "L3MON4D3/LuaSnip",
  version = "<CurrentMajor>.*",
  build = "make install_jsregexp",

  config = function()
    require("luasnip.loaders.from_lua").lazy_load({
      paths = vim.fn.stdpath('config') .. '/snippets',
    })
  end,
}
