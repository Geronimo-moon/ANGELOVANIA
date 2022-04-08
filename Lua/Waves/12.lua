require 'Libraries.bulletType'
require 'Libraries.deadForce'
require 'Libraries.hsvToRgb'

Arena.Resize(150,150)

screen999 = nil
deathtime = nil
died = false

frame = 0
dir = 1
volts = {}
warns = nil
warns2 = nil
slash = nil
slash2 = nil
spawn = true

function Update()
  frame = frame + 1

  if frame % 25 == 0 and spawn then
    local seed = (2*math.random(0,3)+1)/4*math.pi
    local start = math.random(1,8)/4*math.pi
    for i=1,6 do
      local volt = SetDefault('attack/volt',190*math.cos(start+seed*i),190*math.sin(start+seed*i))
      volt.SetVar('data',{start,seed*i})
      volt.SetVar('diff',190)
      volt.sprite.rotation = 180*(start+seed*i)/math.pi
      table.insert(volts,volt)
    end
  end

  for i=1,#volts do
    if volts[i].isactive then
      local start = volts[i].GetVar('data')[1]
      local seed = volts[i].GetVar('data')[2]
      volts[i].SetVar('diff', volts[i].GetVar('diff')-3)
      local diff = volts[i].GetVar('diff')
      volts[i].MoveTo(diff*math.cos(start+seed+math.pi/90*dir),diff*math.sin(start+seed+math.pi/90*dir))
      volts[i].SetVar('data',{start,seed+math.pi/90*dir})

      volts[i].sprite.rotation = 180*(start+seed+math.pi/90*dir)/math.pi
      if volts[i].x^2 <= 4 and volts[i].y^2 <= 4 then
        volts[i].Remove()
      end
    end
  end

  if frame % 90 == 0 then
    if math.random(1,2) == 2 then
      dir = -dir
    end
  end

  if frame == 600 then
    warns = SetSprite('slash/emerb',0,0)
    local t = math.random(1,360)
    warns.SetVar('theta',math.pi*t/180)
    warns.sprite.rotation = t
    Audio.PlaySound('thunder')
    warns2 = SetSprite('slash/emerb',0,0)
    local t2 = t + 90
    warns2.SetVar('theta',math.pi*t2/180)
    warns2.sprite.rotation = t2
    Audio.PlaySound('thunder')
  end

  if warns ~= nil then
    warns.sprite.color = hsvToRgb((630-frame)*2,255,255)
    warns.SetVar('theta',warns.GetVar('theta') + math.pi/90*dir)
    warns.sprite.rotation = 180*warns.GetVar('theta')/math.pi

    warns2.sprite.color = hsvToRgb((630-frame)*2,255,255)
    warns2.SetVar('theta',warns2.GetVar('theta') + math.pi/90*dir)
    warns2.sprite.rotation = 180*warns2.GetVar('theta')/math.pi

    if 630-frame == 0 then
      spawn = false
      local theta = warns.GetVar('theta')
      for i=1,#volts do
        volts[i].Remove()
      end
      slash = SetDieForce('slash/slashb',0,0)
      slash.ppcollision = true
      slash.sprite.rotation = 180*theta/math.pi

      warns.Remove()
      warns = nil

      local theta2 = warns2.GetVar('theta')

      slash2 = SetDieForce('slash/slashb',0,0)
      slash2.ppcollision = true
      slash2.sprite.rotation = 180*theta2/math.pi

      warns2.Remove()
      warns2 = nil
    end
  end

  if not died then
    if slash ~= nil then
      slash.sprite.alpha = slash.sprite.alpha - 0.1
      slash2.sprite.alpha = slash2.sprite.alpha - 0.1
      if slash.sprite.alpha == 0.2 then
        slash.SetVar('type','sprite')
        slash2.SetVar('type','sprite')
      elseif slash.sprite.alpha == 0 then
        slash.Remove()
        slash2.Remove()
        EndWave()
      end
    end
  end

  if deathtime ~= nil then
    KillCount(frame,deathtime,screen999)
  end
end

function OnHit(bullet)
  local die = Hit(bullet)
  -- 即死を食らっている場合999...を生成
  if die and not died then
    died = true
    local list = KillForce(frame)
    screen999 = list[1]
    deathtime = list[2]
  end
end