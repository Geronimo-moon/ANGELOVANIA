require 'Libraries/bulletType'
Arena.Resize(170,100)

local frame = 0

local boog = require 'Animations/backMonster'
boog.init('monsters/boog')

local chaser = SetBeam('rknifer',-200,-200)
chaser.ppcollision = true
chaser.SetVar('vx', 0)
chaser.SetVar('vy', 0)

local bullet = {}
local column = math.random(1,10)
local dir = 1 -- 1...right 0...left

function Update()
  frame = frame + 1
  boog.update(frame)

  local dx = Player.x - chaser.x
  local dy = Player.y - chaser.y
  local vx = chaser.GetVar('vx')/2 + dx/100
  local vy = chaser.GetVar('vy')/2 + dy/100
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

  if frame%15 == 0 then
    dir = (dir+1)%2
    column = math.random(1,10)
  end

  if frame % 3 == 0 then
    local blt = SetDefault('attack/fbullet',-Arena.width/2+Arena.width*dir,10*column-50)
    blt.SetVar('dir',2*dir-1)
    table.insert(bullet,blt)
  end

  for i = 1, #bullet do
    if bullet[i].isactive then
      local dir = bullet[i].GetVar('dir')
      bullet[i].Move(-dir*4,0)
      bullet[i].sprite.rotation = bullet[i].sprite.rotation + (-1)^i*10
      if bullet[i].x >= Arena.width/2 or bullet[i].x <= -Arena.width/2 then
        bullet[i].Remove()
      end
    end
  end

  if frame == 700 then
    EndWave()
  end

end

function OnHit(bullet)
  Hit(bullet)
end