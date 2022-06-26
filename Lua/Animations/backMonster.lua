local self = {}

function self.init(path)
  self.monster = CreateSprite(path,"BelowUI")

  self.monster.x = 0
  self.monster.y = GetGlobal('charablack').y
  self.monster.alpha = 0
end

function self.update(frame)
  if not self.monster.isactive then
    return
  end
  if 0.1*math.floor(frame/30) <= 1 then
    self.monster.alpha = 0.8*0.1*frame/30
  else
    self.monster.alpha = 0.8*(2 - 0.1*frame/30)
    if self.monster.alpha == 0 then
      self.destroy()
      return
    end
  end
  self.monster.Move(1,0)
end

function self.destroy()
  if not self.monster.isactive then
    return
  end
  self.monster.Remove()
end

return self