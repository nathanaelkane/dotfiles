return {
  "L3MON4D3/LuaSnip",
  version = "v1.*",
  build = "make install_jsregexp",

  config = function()
    require("luasnip.loaders.from_lua").lazy_load({
      paths = vim.fn.stdpath('config') .. '/snippets',
    })
  end,
}
