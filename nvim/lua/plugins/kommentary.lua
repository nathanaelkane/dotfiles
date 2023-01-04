return {
  "b3nj5m1n/kommentary",

  config = function()
    require("kommentary.config").configure_language("default", {
      prefer_single_line_comments = true,
    })
  end,
}
