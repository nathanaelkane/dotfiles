mash = ['ctrl', 'alt', 'cmd']

# Make window full screen
bind 'M', ['cmd'], -> moveWindow null
bind 'M', mash, -> moveWindow null

bind 'N', mash, -> moveWindow (frame) ->
  new_width = frame.w / 1.5
  frame.x += (frame.w - new_width) / 2
  frame.w = new_width

# Send window left
bind 'left', mash, -> moveWindow (frame) ->
  frame.w /= 2

# Send window right
bind 'right', mash, -> moveWindow (frame) ->
  frame.x += frame.w / 2
  frame.w /= 2

# Send window up
bind 'up', mash, -> moveWindow (frame) ->
  frame.h /= 2

# Send window down
bind 'down', mash, -> moveWindow (frame) ->
  frame.y += frame.h / 2
  frame.h /= 2

moveWindow = (fn) ->
  win = api.focusedWindow()
  frame = win.screen().frameWithoutDockOrMenu()
  fn frame if fn
  win.setFrame frame
