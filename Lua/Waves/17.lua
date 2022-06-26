require 'Libraries/bulletType'

frame = 0

Arena.Resize(150,150)

local box = SetSprite("empty", 0,0,"BelowBullet")
box.sprite.Mask("box")
box.sprite.Scale(Arena.width/box.sprite.width, Arena.height/box.sprite.height)

SetPPCollision(true)

knives = {}

for i=0,29 do
  local knife = SetNotime('knifel',0,0)
  knife.sprite.SetParent(box.sprite)
  knife.sprite.Scale(1.5,1)
  knife.sprite.rotation = 12*i
  knife.MoveTo(80*math.cos(math.pi*i/15),80*math.sin(math.pi*i/15))
  knife.SetVar('theta',math.pi*i/15)
  table.insert(knives,knife)
end

local param = {math.random(1,3),math.random(4,6)}
local origin = {0,0}
local radius = 32

shot = {}

function Update()
  box.MoveTo(0,0)
  frame = frame + 1

  for i=1,#knives do
    local theta = knives[i].GetVar('theta')
    knives[i].MoveTo(origin[1]+(48+radius)*math.cos(theta+math.pi/90),origin[2]+(48+radius)*math.sin(theta+math.pi/90))
    knives[i].sprite.rotation = 2+theta*180/math.pi
    knives[i].SetVar('theta',theta+math.pi/90)
  end

  radius = 32+12*math.sin(frame*math.pi/60)
  origin = {Arena.width/8*math.sin(param[1]*frame/60),Arena.width/8*math.sin(param[2]*frame/60)}

  if frame % 60 == 0 then
    for i=1,2 do
      local knife = SetNotime('knifer',math.random((-1)^i*Arena.width/2,(-1)^i*Arena.width),Arena.height)
      local num = 0
      if knife.x - Player.x >= 0 then
        num = 180
      end
      knife.sprite.rotation = num + 180*math.atan((Player.y-knife.y)/(Player.x-knife.x))/math.pi
      knife.SetVar('theta',math.pi*knife.sprite.rotation/180)
      knife.sprite.alpha = 0
      table.insert(shot,knife)
    end
  end

  for i=1,#shot do
    if shot[i].isactive then
      shot[i].Move(7*math.cos(shot[i].GetVar('theta')),7*math.sin(shot[i].GetVar('theta')))
      if shot[i].sprite.alpha ~= 1 then
        shot[i].sprite.alpha = shot[i].sprite.alpha + 0.1
      end
      if shot[i].absx <= 0 or shot[i].absy <= 0 or shot[i].absx >= 640 or shot[i].absy >= 480 then
        shot[i].Remove()
      end
    end
  end

  if frame == 600 then
    EndWave()
  end
end

function OnHit(bullet)
  Hit(bullet)
end