local use = require("packer").use

use {
  "vim-ruby/vim-ruby",

  setup = function()
    vim.g.ruby_indent_assignment_style = "variable"
  end,
}

use {
  "tpope/vim-rails",

  setup = function()
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
}

use {
  "tpope/vim-haml",

  config = function()
    vim.cmd "autocmd BufRead,BufNewFile *.hamlc set ft=haml"
  end,
}

use "tpope/vim-rake"
use "kchmck/vim-coffee-script"
use "joker1007/vim-ruby-heredoc-syntax"

vim.cmd "autocmd FileType ruby,rails,haml,hamlc,eruby,yaml,ru,cucumber set ai sw=2 sts=2 et"
