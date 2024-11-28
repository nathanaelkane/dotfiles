modalMenu = hs.menubar.new()
modalMenu:setTitle("𝗠")

addMenuEntry = function(appName, shortcut)
  return {
    title = appName,
    shortcut = shortcut,
    fn = function()
      hs.application.launchOrFocus(appName)
    end,
  }
end

modalMenu:setMenu({
  addMenuEntry("Firefox", "f"),
  addMenuEntry("Google Chrome", "c"),
  addMenuEntry("Logseq", "l"),
  addMenuEntry("Messages", "m"),
  addMenuEntry("Microsoft Outlook", "e"),
  addMenuEntry("Microsoft Teams", "t"),
  addMenuEntry("Music", "M"),
  addMenuEntry("Slack", "s"),
  addMenuEntry("WezTerm", "w"),
})

hs.hotkey.bind({"cmd", "shift"}, "j", function()
  modalMenu:popupMenu({x = modalMenu:frame().x, y = 30})
end)
