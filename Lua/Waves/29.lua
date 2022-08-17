require 'Libraries/bulletType'
Arena.Resize(180,140)

local frame = 0

local boog = require 'Animations/backMonster'
boog.init('monsters/boog')

local chaser = SetNotime('knifer',(-1)^(math.random(0,1))*180,(-1)^(math.random(0,1))*100)
chaser.SetVar('vx', 0)
chaser.SetVar('vy', 0)
local chaser2 = SetBeam('rknifer',(-1)^(math.random(0,1))*180,(-1)^(math.random(0,1))*100)
chaser2.SetVar('vx', 0)
chaser2.SetVar('vy', 0)

SetPPCollision(true)

local bullet = {}
local column = math.random(1,7)
local dir = 1 -- 1...right 0...left

local circle = {}

function Update()
  frame = frame + 1
  boog.update(frame)

  if frame <= 400 then
    local dx = Player.x - chaser.x
    local dy = Player.y - chaser.y
    local vx = chaser.GetVar('vx')/2 + dx/50
    local vy = chaser.GetVar('vy')/2 + dy/50
    chaser.Move(vx,vy)
    chaser.SetVar('vx',vx)
    chaser.SetVar('vy',vy)
    local tan = dy/dx
    local theta
    if dy >= 0 then
      if dx >= 0 then
        theta = math.atan(tan)
      else
        theta = math.pi + math.atan(tan)
      end
    else
      if dx >= 0 then
        theta = 2*math.pi + math.atan(tan)
      else
        theta = math.pi + math.atan(tan)
      end
    end
    chaser.sprite.rotation = theta*180/math.pi
    dx = Player.x - chaser2.x
    dy = Player.y - chaser2.y
    vx = chaser2.GetVar('vx')/2 + dx/50
    vy = chaser2.GetVar('vy')/2 + dy/50
    chaser2.Move(vx,vy)
    chaser2.SetVar('vx',vx)
    chaser2.SetVar('vy',vy)
    tan = dy/dx
    if dy >= 0 then
      if dx >= 0 then
        theta = math.atan(tan)
      else
        theta = math.pi + math.atan(tan)
      end
    else
      if dx >= 0 then
        theta = 2*math.pi + math.atan(tan)
      else
        theta = math.pi + math.atan(tan)
      end
    end
    chaser2.sprite.rotation = theta*180/math.pi
  else
    if chaser.isactive then
      chaser.Move(math.cos(chaser.sprite.rotation*math.pi/180),math.sin(chaser.sprite.rotation*math.pi/180))
      if chaser.x^2+chaser.y^2 > 300^2 then
        chaser.Remove()
      end
    end
    if chaser2.isactive then
      chaser2.Move(math.cos(chaser2.sprite.rotation*math.pi/180),math.sin(chaser2.sprite.rotation*math.pi/180))
      if chaser2.x^2+chaser2.y^2 > 300^2 then
        chaser2.Remove()
      end
    end
  end

  if frame%25 == 0 and frame <= 375 then
    dir = (dir+1)%2
    column = math.random(1,7)
  end

  if frame % 5 == 0 and frame <= 400 then
    local blt = SetDefault('attack/fbullet',-Arena.width/2+Arena.width*dir,20*column-80)
    blt.SetVar('dir',2*dir-1)
    blt.sprite.color = {1,0,0}
    table.insert(bullet,blt)
  end

  for i = 1, #bullet do
    if bullet[i].isactive then
      local bdir = bullet[i].GetVar('dir')
      bullet[i].Move(-bdir*3.5,0)
      bullet[i].sprite.rotation = bullet[i].sprite.rotation + (-1)^i*10
      if bullet[i].x >= Arena.width/2 or bullet[i].x <= -Arena.width/2 then
        bullet[i].Remove()
      end
    end
  end

  if frame == 400 then
    Arena.Resize(140,140)
  end

  if frame >= 400 and frame%40 == 0 then
    local color = {"blue","orange"}
    local list = {blue={0.15,0.7,0.95},orange={1,0.45,0}}
    for i = 0, 43 do
      local blt = SetDefault('attack/fbullet',140*math.cos(math.pi/22*i),140*math.sin(math.pi/22*i),"",color[math.random(1,2)])
      blt.sprite.color = list[blt.GetVar('color')]
      blt.sprite.Scale(0.65,0.65)
      blt.SetVar('theta',math.pi/22*i)
      blt.SetVar('spawn',frame)
      table.insert(circle,blt)
    end
  end

  for i = 1, #circle do
    if circle[i].isactive then
      local spawn = circle[i].GetVar('spawn')
      local theta = circle[i].GetVar('theta')
      circle[i].Move(-((frame-spawn)/8)*math.cos(theta),-((frame-spawn)/8)*math.sin(theta))
      circle[i].sprite.rotation = circle[i].sprite.rotation + 30
      if circle[i].x^2 + circle[i].y^2 >= 300^2 then
        circle[i].Remove()
      end
    end
  end

  if frame == 720 then
    EndWave()
  end
end

function OnHit(bullet)
  Hit(bullet)
end