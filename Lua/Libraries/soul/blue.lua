local self = {}

self.isactive = false -- 青ソウルかどうか

function self.Init() -- 起動処理
  self.isactive = true
  self.isAir = false -- 空中にいるかどうか
  self.dir = "down" -- 重力の方向(up,down,right,left,ur,ul,dr,dl)
  self.gravity = 0.12 -- 重力加速度
  self.velocity = 0 -- 初速
end

function self.SetDir(dir) -- 重力方向の選択(up,down,right,left,ur,ul,dr,dl)
  self.dir = dir
  if dir == "up" then
    Player.sprite.rotation = 180
  elseif dir == "down" then
    Player.sprite.rotation = 0
  elseif dir == "right" then
    Player.sprite.rotation = 90
  elseif dir == "left" then
    Player.sprite.rotation = 270
  elseif dir == "ur" then
    Player.sprite.rotation = 135
  elseif dir == "dr" then
    Player.sprite.rotation = 45
  elseif dir == "ul" then
    Player.sprite.rotation = 225
  elseif dir == "dl" then
    Player.sprite.rotation = 315
  end
end

function self.Control(key)
  self.CheckInAir()
  for i = 1, 10, 1 do
    if self.dir == "up" then
      Player.MoveTo(Player.x + (self.calHorizon(key)/10),Player.y - (self.calVertical(key)/10),false)
    elseif self.dir == "down" then
      Player.MoveTo(Player.x + (self.calHorizon(key)/10),Player.y + (self.calVertical(key)/10),false)
    elseif self.dir == "right" then
      Player.MoveTo(Player.x - (self.calVertical(key)/10),Player.y + (self.calHorizon(key)/10),false)
    elseif self.dir == "left" then
      Player.MoveTo(Player.x + (self.calVertical(key)/10),Player.y + (self.calHorizon(key)/10),false)
    end
  end
  if key.active then
    if self.dir == "up" and Input.GetKey('UpArrow') == 1 then
      self.gravity = 3.6
    elseif self.dir == "down" and Input.GetKey('DownArrow') == 1 then
      self.gravity = 3.6
    elseif self.dir == "right" and Input.GetKey('RightArrow') == 1 then
      self.gravity = 3.6
    elseif self.dir == "left" and Input.GetKey('LeftArrow') == 1 then
      self.gravity = 3.6
    else
      self.gravity = 0.12
    end
  end

  return true
end

function self.calVertical(key)
  if not self.isAir then
    if self.dir == "up" then
      if (Input.GetKey('DownArrow') > 0 or key.active) then
        self.velocity = 4.4
      else
        self.velocity = 0
      end
    elseif self.dir == "down" then
      if (Input.GetKey('UpArrow') > 0 or key.active) then
        self.velocity = 4.4
      else
        self.velocity = 0
      end
    elseif self.dir == "right" then
      if (Input.GetKey('LeftArrow') > 0 or key.active) then
        self.velocity = 4.4
      else
        self.velocity = 0
      end
    elseif self.dir == "left" then
      if (Input.GetKey('RightArrow') > 0 or key.active) then
        self.velocity = 4.4
      else
        self.velocity = 0
      end
    end
  else
    if self.dir == "up" then
      if (Input.GetKey('DownArrow') == -1 and not key.active and self.velocity >= self.gravity) then
        self.velocity = self.velocity/4.4
      end
    elseif self.dir == "down" then
      if (Input.GetKey('UpArrow') == -1 and not key.active and self.velocity >= self.gravity) then
        self.velocity = self.velocity/4.4
      end
    elseif self.dir == "right" then
      if (Input.GetKey('LeftArrow') == -1 and not key.active and self.velocity >= self.gravity) then
        self.velocity = self.velocity/4.4
      end
    elseif self.dir == "left" then
      if (Input.GetKey('RightArrow') == -1 and not key.active and self.velocity >= self.gravity) then
        self.velocity = self.velocity/4.4
      end
    end
    self.velocity = self.velocity - (self.gravity/10)
  end
  return self.velocity
end

function self.calHorizon(key)
  local move = 0
  local slow = Input.Cancel > 0
  if self.dir == "down" or self.dir == "up" then
    if Input.GetKey('LeftArrow') > 0 or key.LeftArrow then
      move = move - 2
    elseif Input.GetKey('RightArrow') > 0 or key.RightArrow then
      move = move + 2
    end
  elseif self.dir == "right" or self.dir == "left" then
    if Input.GetKey('DownArrow') > 0 or key.DownArrow then
      move = move - 2
    elseif Input.GetKey('UpArrow') > 0 or key.UpArrow then
      move = move + 2
    end
  end
  if slow then
    move = move / 2
  end
  return move
end

function self.CheckInAir()
  if (self.dir == "down" or self.dir == "dl" or self.dir == "dr") and (Player.y - (Player.sprite.height/2)) > -(Arena.currentheight/2) then
    self.isAir = true
  elseif (self.dir == "right" or self.dir == "ur" or self.dir == "dr") and (Player.x + (Player.sprite.width/2))  <  (Arena.currentwidth/2)  then
    self.isAir = true
  elseif (self.dir == "up" or self.dir == "ul" or self.dir == "ur") and (Player.y + (Player.sprite.height/2)) <  (Arena.currentheight/2) then
    self.isAir = true
  elseif (self.dir == "left" or self.dir == "dl" or self.dir == "ul") and (Player.x - (Player.sprite.width/2))  > -(Arena.currentwidth/2)  then
    self.isAir = true
  else
    self.isAir = false
  end
end

function self.Quit()
  self.isactive = false
end

return self