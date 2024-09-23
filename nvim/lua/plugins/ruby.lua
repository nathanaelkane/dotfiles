return {
  {
    "vim-ruby/vim-ruby",

    init = function()
      vim.g.ruby_indent_assignment_style = "variable"
    end,
  },

  {
    "tpope/vim-rails",

    init = function()
      vim.g.rails_projections = {
        ["app/lib/*.rb"] = {
          test = "spec/lib/{}_spec.rb",
        },
        ["app/models/*.rb"] = {
          related = {
            "app/models/{}.sql",
            "app/models/{}.sql.erb",
          },
        },
        ["app/models/*.sql"] = {
          related = "app/models/{}.rb",
        },
        ["app/models/*.sql.erb"] = {
          related = "app/models/{}.rb",
        },
        ["app/sql/*.rb"] = {
          related = {
            "app/sql/{}.sql",
            "app/sql/{}.sql.erb",
          },
        },
        ["app/sql/*.sql"] = {
          related = "app/sql/{}.rb",
        },
        ["app/sql/*.sql.erb"] = {
          related = "app/sql/{}.rb",
        },
        ["config/initializers/*.rb"] = {
          test = "spec/initializers/{}_spec.rb",
        },
        ["spec/initializers/*_spec.rb"] = {
          alternate = "config/initializers/{}.rb",
        },
      }
    end,
  },

  {
    "tpope/vim-haml",

    config = function()
      vim.cmd "autocmd BufRead,BufNewFile *.hamlc set ft=haml"
    end,
  },

  "tpope/vim-rake",
  "kchmck/vim-coffee-script",
  "joker1007/vim-ruby-heredoc-syntax",
}
