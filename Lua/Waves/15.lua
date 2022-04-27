require 'Libraries.bulletType'
require 'Libraries.blaster'

Arena.Resize(400,360)

frame = 0

vknives = {}
bknives = {}
blasters = {}

local box = SetSprite("empty", 0,0,"BelowBullet")
box.sprite.Mask("box")

SetPPCollision(true)

count = 1

function Update()
  frame = frame + 1
  box.sprite.Scale(Arena.width/box.sprite.width, Arena.height/box.sprite.height)
  box.MoveTo(0,0)
  if frame % 100 == 60 then
    for i=1,count do
      local blst = SetBlaster('chaos',math.random(-Arena.width/2,Arena.width/2),math.random(-Arena.height/2,Arena.height/2))
      local num = 0
      if blst.x - Player.x >= 0 then
        num = 180
      end
      blst.sprite.rotation = num + 180*math.atan((Player.y-blst.y)/(Player.x-blst.x))/math.pi
      table.insert(blasters,blst)
    end
    count = count + 1
  end

  for i = 1, #blasters do
    if blasters[i].isactive then
      if blasters[i].GetVar('beam') ~= nil then
        blasters[i].Move(-10*math.cos(math.pi*blasters[i].sprite.rotation/180),-10*math.sin(math.pi*blasters[i].sprite.rotation/180))
        blasters[i].GetVar('center').Move(-10*math.cos(math.pi*blasters[i].sprite.rotation/180),-10*math.sin(math.pi*blasters[i].sprite.rotation/180))
        blasters[i].GetVar('beam').Move(-10*math.cos(math.pi*blasters[i].sprite.rotation/180),-10*math.sin(math.pi*blasters[i].sprite.rotation/180))
      end
      UpdateBlaster(blasters[i],frame)
    end
  end

  if frame%60 == 1 then
    local x = math.random(0,8)
    while true do
      local knife = SetNotime('knifed',-Arena.width/2+x*20,Arena.height/2+32)
      knife.sprite.SetParent(box.sprite)
      table.insert(vknives,knife)
      x = x+math.random(0,8)
      if -Arena.width/2+x*20 >= Arena.width then
        break
      end
    end
  elseif frame%60 == 31 then
    local y = math.random(0,7)
    while true do
      local knife = SetNotime('knifer',-Arena.width/2-32,-Arena.height/2+y*20)
      knife.sprite.SetParent(box.sprite)
      table.insert(bknives,knife)
      y = y+math.random(0,7)
      if -Arena.height/2+y*20 >= Arena.height then
        break
      end
    end
  end

  for i = 1, #vknives do
    if vknives[i].isactive then
      vknives[i].Move(0,-3)
      if vknives[i].absy <= 0 then
        vknives[i].Remove()
      end
    end
  end

  for i = 1, #bknives do
    if bknives[i].isactive then
      bknives[i].Move(3,0)
      if bknives[i].y >= Arena.width/2+32 then
        bknives[i].Remove()
      end
    end
  end

  if frame <= 350 and frame % 2 == 0 then
    Arena.Resize(Arena.width-1,Arena.height)
  end

  if frame >= 350 and frame % 2 == 0 then
    Arena.Resize(Arena.width,Arena.height-1)
  end

  if frame == 750 then
    EndWave()
  end
end

function OnHit(bullet)
  Hit(bullet)
end