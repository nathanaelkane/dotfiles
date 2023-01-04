return {
  "vimwiki/vimwiki",

  init = function()
    vim.g.vimwiki_conceallevel = 0
  end,

  config = function()
    _G.open_vimwiki_diary = function()
      -- Diary index
      vim.cmd [[
        VimwikiDiaryIndex
        set wrap
        vsplit
        wincmd l
      ]]

      -- Yesterday's entry
      vim.cmd [[
        VimwikiMakeYesterdayDiaryNote
        write
        set wrap
        split
      ]]

      -- Today's entry
      vim.cmd [[
        VimwikiMakeDiaryNote
        set wrap

        if getline(1,'$') == ['']
          " Create from template
          execute '0r ' . expand('%:p:h') . '/template.wiki'
          execute '%s/<DATE>/' . strftime('%Y-%m-%d')
          execute '%s/<DAY>/' . strftime('%A')
          normal Gdd
        endif

        write
        wincmd h
      ]]

      -- Generate links on diary index
      vim.cmd [[
        VimwikiDiaryGenerateLinks
        write
        wincmd l
      ]]
    end

    vim.cmd "command! Diary call v:lua.open_vimwiki_diary()"
  end,
}
