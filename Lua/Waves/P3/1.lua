require 'Libraries/bulletType'
local blue = require 'Libraries/soulManager'
blue.Init({"blue"})
blue.blue.airJump = true

local frame = 0

function Update()
  blue.Update()
  frame = frame + 1
end

function OnHit(bullet)
  Hit(bullet)
end