local self = {}

self.isactive = false
self.multi = false

function self.Init()
  self.isactive = true
  self.current = {x=-2 ,y=0}
end

function self.Control()
  if Input.Up == 2 then
    self.current.y = 2
    if Input.Right == 2 then
      self.current.x = 2
    elseif Input.Left == 2 then
      self.current.x = -2
    else
      self.current.x = 0
    end
  elseif Input.Down == 2 then
    self.current.y = -2
    if Input.Right == 2 then
      self.current.x = 2
    elseif Input.Left == 2 then
      self.current.x = -2
    else
      self.current.x = 0
    end
  else
    if Input.Right == 2 then
      self.current.x = 2
      self.current.y = 0
    elseif Input.Left == 2 then
      self.current.y = 0
      self.current.x = -2
    end
  end

  Player.Move(1.5*self.current.x,1.5*self.current.y)
end

function self.Quit()
  self.isactive = false
end

return self