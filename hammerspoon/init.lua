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
  addMenuEntry("Google Chrome", "c"),
  addMenuEntry("iTerm", "i"),
  addMenuEntry("Messages", "m"),
  addMenuEntry("Mimestream", "e"),
  addMenuEntry("Music", "M"),
  -- addMenuEntry("Outlook", "e"),
})

hs.hotkey.bind({"cmd", "shift"}, "j", function()
  modalMenu:popupMenu({x = modalMenu:frame().x, y = 30})
end)
