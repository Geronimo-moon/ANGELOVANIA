local self = {}

self.r = 0
self.theta = math.pi/2
self.isactive = false

function self.Init()
  Player.SetControlOverride(true)
  Player.sprite.color = {0.15,0.7,0.95}
  Audio.PlaySound('change')
  Misc.ScreenShader.Set('cyfshaders','Rotation')
  self.isactive = true
end

function self.Update()
  if Input.Up == 2 then
    self.r = self.r + 2
  elseif Input.Down == 2 then
    self.r = self.r - 2
    if self.r <= 0 then
      self.r = 0
    end
  end
  if Input.Right == 2 then
      self.theta = self.theta - math.pi/60
      Player.sprite.rotation = Player.sprite.rotation - 3
      Misc.ScreenShader.SetInt("Rotation",Misc.ScreenShader.GetInt("Rotation")+3)
  elseif Input.Left == 2 then
      self.theta = self.theta + math.pi/60
      Player.sprite.rotation = Player.sprite.rotation + 3
      Misc.ScreenShader.SetInt("Rotation",Misc.ScreenShader.GetInt("Rotation")-3)
  end

  Player.MoveTo(self.r*math.cos(self.theta),self.r*math.sin(self.theta))
end

function self.Quit()
  Player.SetControlOverride(false)
  Player.sprite.color = {1,0,0}
  Player.sprite.rotation = 0
  Audio.PlaySound('change')
  Misc.ScreenShader.Revert()
  self.isactive = false
end

return self