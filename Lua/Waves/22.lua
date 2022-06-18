local orange = require 'Libraries.orangesoul'
local cyan = require 'Libraries.cyansoul'

frame = 0

function Update()
  frame = frame + 1

  if orange.isactive then
    orange.Update()
  end
  if cyan.isactive then
    cyan.Update()
  end

  if frame == 10 then
    orange.Init()
  end

  if frame == 240 then
    orange.Quit()
    cyan.Init()
  end

  if frame == 480 then
    cyan.Quit()
  end
end