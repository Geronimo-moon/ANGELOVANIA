require 'Libraries/bulletType'

local soul = require 'Libraries/soulManager'
soul.Init({'yellow','green'})

local frame = 0

function Update()
  frame = frame + 1
  soul.Update()
end

function OnHit(bullet)
  Hit(bullet)
end