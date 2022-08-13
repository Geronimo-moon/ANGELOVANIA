local self = {}

self.isactive = false

function self.Init()
  self.isactive = true
  self.aim = CreateSprite("soul/yaim","Top")
  self.x = 320
  self.y = 240
  self.bullet = {}
  self.reload = 0
  self.aim.MoveTo(self.x,self.y)
end

function self.Control(key)
  if Input.GetKey('W') == 2 then
    self.y = self.y + 7
  end
  if Input.GetKey('S') == 2 then
    self.y = self.y - 7
  end
  if Input.GetKey('D') == 2 then
    self.x = self.x + 7
  end
  if Input.GetKey('A') == 2 then
    self.x = self.x - 7
  end

  self.aim.MoveTo(self.x,self.y)

  local tan = (self.y-Player.absy)/(self.x-Player.absx)
  local theta
  if self.y-Player.absy >= 0 then
    if self.x-Player.absx >= 0 then
      theta = math.atan(tan)
    else
      theta = math.pi + math.atan(tan)
    end
  else
    if self.x-Player.absx >= 0 then
      theta = 2*math.pi + math.atan(tan)
    else
      theta = math.pi + math.atan(tan)
    end
  end
  Player.sprite.rotation = theta*180/math.pi + 90

  for i=1,#self.bullet do
    if self.bullet[i].isactive then
      self.bullet[i].Move(6*math.cos((self.bullet[i].rotation)*math.pi/180+math.pi/2),6*math.sin((self.bullet[i].rotation)*math.pi/180+math.pi/2))
      if self.bullet[i].x <= 0 or self.bullet[i].x >= 640 or self.bullet[i].y <= 0 or self.bullet[i].y >= 480 then
        self.bullet[i].Remove()
      end
    end
  end

  if self.reload ~= 0 then
    self.reload = self.reload - 1
  end

  if Input.Confirm == 1 and self.reload == 0 then
    local bullet = CreateSprite("soul/ybullet","Top")
    bullet.rotation = Player.sprite.rotation - 180
    bullet.MoveTo(Player.absx,Player.absy)
    self.reload = 10
    table.insert(self.bullet,bullet)
  end
  return false
end

function self.Hit(bullet)
  for i = 1, #self.bullet do
    if self.bullet[i].isactive and (self.bullet[i].x-bullet.absx)^2+(self.bullet[i].y-bullet.absy)^2 <= 20^2 then
      bullet.Remove()
      self.bullet[i].Remove()
    end
  end
end

function self.Quit()
  self.aim.Remove()
  Player.sprite.rotation = 0
  self.isactive = false
end

return self