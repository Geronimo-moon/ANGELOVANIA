local self = {}

self.isactive = false

function self.Init()
  self.isactive = true
  self.aim = CreateSprite("soul/yaim")
  self.aim.SetParent(Player.sprite)
  self.x = 0
  self.y = -20
  self.bullet = {}
end

function self.Control(key)
  return false
end