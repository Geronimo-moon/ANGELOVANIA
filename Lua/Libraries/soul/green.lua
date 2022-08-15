local self = {}

self.isactive = false

function self.Init()
  self.shield = CreateSprite('soul/gshield_blue','Top')
  self.shield.MoveTo(Player.absx,Player.absy+26)
  self.pos = 'up'
  self.circle = CreateSprite('soul/gring','Top')
  self.circle.SetParent(Player.sprite)
  self.circle.MoveTo(0,0)
  self.num = 1
  self.move = false
end

function self.Control()
  if self.move == true then
    if Input.GetKey('W') == 1 then
      self.pos = 'up'
      self.shield.rotation = 0
      self.shield.MoveTo(Player.absx,Player.absy+26)
    elseif Input.GetKey('S') == 1 then
      self.pos = 'down'
      self.shield.rotation = 180
      self.shield.MoveTo(Player.absx,Player.absy-26)
    elseif Input.GetKey('D') == 1 then
      self.pos = 'right'
      self.shield.rotation = 270
      self.shield.MoveTo(Player.absx+26,Player.absy)
    elseif Input.GetKey('A') == 1 then
      self.pos = 'left'
      self.shield.rotation = 90
      self.shield.MoveTo(Player.absx-26,Player.absy)
    end
  else
    if Input.GetKey('UpArrow') == 1 then
      self.pos = 'up'
      self.shield.rotation = 0
      self.shield.MoveTo(Player.absx,Player.absy+26)
    elseif Input.GetKey('DownArrow') == 1 then
      self.pos = 'down'
      self.shield.rotation = 180
      self.shield.MoveTo(Player.absx,Player.absy-26)
    elseif Input.GetKey('RightArrow') == 1 then
      self.pos = 'right'
      self.shield.rotation = 270
      self.shield.MoveTo(Player.absx+26,Player.absy)
    elseif Input.GetKey('LeftArrow') == 1 then
      self.pos = 'left'
      self.shield.rotation = 90
      self.shield.MoveTo(Player.absx-26,Player.absy)
    end
    if self.num == 2 then
      if Input.GetKey('W') == 1 then
        self.pos_red = 'up'
        self.shield_red.rotation = 0
        self.shield_red.MoveTo(Player.absx,Player.absy+26)
      elseif Input.GetKey('S') == 1 then
        self.pos_red = 'down'
        self.shield_red.rotation = 180
        self.shield_red.MoveTo(Player.absx,Player.absy-26)
      elseif Input.GetKey('D') == 1 then
        self.pos_red = 'right'
        self.shield_red.rotation = 270
        self.shield_red.MoveTo(Player.absx+26,Player.absy)
      elseif Input.GetKey('A') == 1 then
        self.pos_red = 'left'
        self.shield_red.rotation = 90
        self.shield_red.MoveTo(Player.absx-26,Player.absy)
      end
    end
  end

  if self.pos == "up" then
    self.shield.MoveTo(Player.absx,Player.absy+26)
  elseif self.pos == "down" then
    self.shield.MoveTo(Player.absx,Player.absy-26)
  elseif self.pos == "right" then
    self.shield.MoveTo(Player.absx+26,Player.absy)
  elseif self.pos == "left" then
    self.shield.MoveTo(Player.absx-26,Player.absy)
  end

  if self.pos_red == "up" then
    self.shield_red.MoveTo(Player.absx,Player.absy+26)
  elseif self.pos_red == "down" then
    self.shield_red.MoveTo(Player.absx,Player.absy-26)
  elseif self.pos_red == "right" then
    self.shield_red.MoveTo(Player.absx+26,Player.absy)
  elseif self.pos_red == "left" then
    self.shield_red.MoveTo(Player.absx-26,Player.absy)
  end

  return not self.move
end

function self.ChangeShield(num,mv)
  self.move = mv or self.move
  if num ~= nil and self.num ~= num then
    self.num = num
    if num == 2 then
      self.shield_red = CreateSprite('soul/gshield_red','Top')
      self.shield_red.MoveTo(Player.absx,Player.absy+26)
      self.pos_red = "up"
      self.move = false
    else
      self.shield_red.Remove()
    end
  end
end

function self.Parry(bullet,color)
  if color == nil then
    color = "blue"
  end
  if ((color == "blue" and self.pos == bullet.GetVar('pos')) or (color == "red" and self.pos_red == bullet.GetVar('pos'))) and (math.abs(Player.x-bullet.x)-bullet.sprite.width/2)^2+(math.abs(Player.y-bullet.y)-bullet.sprite.height/2)^2 <= 40^2 then
    bullet.Remove()
    Audio.PlaySound('change')
  end
end

function self.Quit()
  if self.num == 2 then
    self.shield_red.Remove()
  end
  self.shield.Remove()
  self.circle.Remove()
  self.isactive = false
end

return self