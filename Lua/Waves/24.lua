require 'Libraries/bulletType'

local frame = 0

Arena.Resize(200,200)
Player.MoveTo(50,50)

local baseFire = {SetDefault('attack/flame',170,0),SetDefault('attack/flame',170*math.cos(2/3*math.pi),170*math.sin(2/3*math.pi)),SetDefault('attack/flame',170*math.cos(4/3*math.pi),170*math.sin(4/3*math.pi))}
local flames = {}
local centerKnife = {SetNotime('bknifer',50,0,"","blue"),SetNotime('bknifer',0,50,"","blue"),SetNotime('bknifer',-50,0,"","blue"),SetNotime('bknifer',0,-50,"","blue")}
local place = {x={},y={}}

for i=1,#baseFire do
  baseFire[i].SetVar('theta',2/3*math.pi*(i-1))
  baseFire[i].sprite.Scale(5,5)
end
for i = 1, #centerKnife do
  centerKnife[i].SetVar('theta',math.pi*(i-1)/2)
  centerKnife[i].sprite.rotation = 90*(i-1)
  centerKnife[i].sprite.Scale(1.5,1)
end

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
  knife.MoveTo(144*math.cos(math.pi*i/15),144*math.sin(math.pi*i/15))
  knife.SetVar('theta',math.pi*i/15)
  table.insert(knives,knife)
end

function Update()
  frame = frame + 1
  box.MoveTo(0,0)

  if frame <= 621 then
    for i=1,#knives do
      local theta = knives[i].GetVar('theta')
      knives[i].MoveTo(144*math.cos(theta+math.pi/90),144*math.sin(theta+math.pi/90))
      knives[i].sprite.rotation = 2+theta*180/math.pi
      knives[i].SetVar('theta',theta+math.pi/90)
    end

    for i = 1, #centerKnife do
      local theta = centerKnife[i].GetVar('theta')
      centerKnife[i].MoveTo(50*math.cos(theta-math.pi/90),50*math.sin(theta-math.pi/90))
      centerKnife[i].sprite.rotation = theta*180/math.pi-2
      centerKnife[i].SetVar('theta',theta-math.pi/90)
    end

    for i=1,#baseFire do
      local theta = baseFire[i].GetVar('theta')
      baseFire[i].MoveTo(170*math.cos(theta+math.pi/71),170*math.sin(theta+math.pi/71))
      baseFire[i].SetVar('theta',theta+math.pi/71)
      if frame % 23 == 22 then
        place.x[i] = baseFire[i].x
        place.y[i] = baseFire[i].y
        Audio.PlaySound('heartsplosion')
      end
    end
  else
    for i=1,#knives do
      local theta = knives[i].GetVar('theta')
      knives[i].MoveTo((144+(621-frame)/2)*math.cos(theta+math.pi/90),(144+(621-frame)/2)*math.sin(theta+math.pi/90))
      knives[i].sprite.rotation = 2+theta*180/math.pi
      knives[i].SetVar('theta',theta+math.pi/90)
    end

    for i = 1, #centerKnife do
      local theta = centerKnife[i].GetVar('theta')
      centerKnife[i].MoveTo(50*math.cos(theta+math.pi/90),50*math.sin(theta+math.pi/90))
      centerKnife[i].sprite.rotation = theta*180/math.pi+4
      centerKnife[i].SetVar('theta',theta+math.pi/45)
    end
  end

  if place.x[1] then
    for j=0, 29 do
      local x = place.x[math.floor(j/10)+1]
      local y = place.y[math.floor(j/10)+1]
      local theta = math.pi*2*j/10
      local flame = SetDefault('attack/flame',math.cos(theta)+x,math.sin(theta)+y)
      flame.SetVar('theta',theta)
      flame.SetVar('loc',{x,y})
      table.insert(flames,flame)
    end
    if frame % 23 == 9 then
      place = {x={},y={}}
    end
  end

  for i=1,#flames do
    if flames[i].isactive then
      local theta = flames[i].GetVar('theta')
      flames[i].Move(10*math.cos(theta),10*math.sin(theta))

      if flames[i].absx <= 0 or flames[i].absy <= 0 or flames[i].absx >= 640 or flames[i].absy >= 480 then
        flames[i].Remove()
      end
    end
  end

  if frame == 570 then
    Audio.PlaySound('BeginBattle1')
  end

  if frame == 621 then
    for i = 1, #baseFire do
      baseFire[i].Remove()
    end

    for i=1,#centerKnife do
      centerKnife[i].SetVar('color',"white")
      centerKnife[i].sprite.Set('knifer')
    end

    Audio.PlaySound('change')
  end

  if frame == 700 then
    EndWave()
  end
end

function OnHit(bullet)
  Hit(bullet)
end