require 'Libraries/bulletType'

local frame = 0

Arena.Resize(150,150)

local box = SetSprite("empty", 0,0,"BelowBullet")
box.sprite.Mask("box")
box.sprite.Scale(Arena.width/box.sprite.width, Arena.height/box.sprite.height)

SetPPCollision(true)

local knives = {}

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

  if frame == 600 then
    EndWave()
  end
end

function OnHit(bullet)
  Hit(bullet)
end