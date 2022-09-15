local self = {}

self.isactive = false

function self.Init()
  Misc.ScreenShader.Set('cyfshaders','Rotation')
  self.isactive = true
  self.r = 0
  self.theta = math.pi/2
end

function self.Control(key)
  local div = 1
  if Input.Cancel > 0 then
    div = 2
  end
  if Input.GetKey('UpArrow') == 2 or key.UpArrow then
    self.r = 2
  elseif Input.GetKey('DownArrow') == 2 or key.DownArrow then
    self.r = - 2
  else
    self.r = 0
  end
  if Input.GetKey('RightArrow') == 2 or key.RightArrow then
      self.theta = self.theta - math.pi/30
      Player.sprite.rotation = Player.sprite.rotation - 6
      Misc.ScreenShader.SetInt("Rotation",Misc.ScreenShader.GetInt("Rotation")+6)
  elseif Input.GetKey('LeftArrow') == 2 or key.LeftArrow then
      self.theta = self.theta + math.pi/30
      Player.sprite.rotation = Player.sprite.rotation + 6
      Misc.ScreenShader.SetInt("Rotation",Misc.ScreenShader.GetInt("Rotation")-6)
  end

  Player.Move(self.r*math.cos(self.theta)/div,self.r*math.sin(self.theta)/div)

  return true
end

function self.Quit()
  Player.sprite.rotation = 0
  Misc.ScreenShader.Revert()
  self.isactive = false
end

return self