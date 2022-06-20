require "Libraries/bulletType"
require 'Libraries/deadForce'
require 'Libraries/hsvToRgb'

frame = 0

Arena.Resize(150,150)

flames = {}
bflames = {}
vflames = {}

warns = {}
slashs = {}

screen999 = nil
deathtime = nil
died = false

function Update()
  frame = frame + 1

  if not died then
    if frame % 50 == 3 then
      local flame = SetDefault('attack/flame',Player.x,300)
      flame.ppcollision = true
      flame.sprite.Scale(4,4)
      table.insert(vflames,flame)
    elseif frame % 50 == 28 then
      local flame = SetDefault('attack/flame',320,Player.y)
      flame.ppcollision = true
      flame.sprite.Scale(4,4)
      table.insert(bflames,flame)
    end

    for i=1,#bflames do
      if bflames[i].isactive then
        bflames[i].Move(-5,0)
        if bflames[i].x == 0 then
          local x,y = bflames[i].x,bflames[i].y
          bflames[i].Remove()

          for j=0, 5 do
            local theta = math.pi*2*j/6
            local star = SetDefault('attack/flame',math.cos(theta)+x,math.sin(theta)+y)
            star.SetVar('theta',theta)
            star.SetVar('loc',{x,y})
            table.insert(flames,star)
          end

          local warn = SetSprite('slash/emerb',x,y)
          warn.SetVar('spawn',frame)
          table.insert(warns,warn)
          Audio.PlaySound('thunder')
        end
      end
    end

    for i=1,#vflames do
      if vflames[i].isactive then
        vflames[i].Move(0,-5)
        if vflames[i].y == 0 then
          local x,y = vflames[i].x,vflames[i].y
          vflames[i].Remove()

          for j=0, 6 do
            local theta = math.pi*2*j/7
            local star = SetDefault('attack/flame',math.cos(theta)+x,math.sin(theta)+y)
            star.SetVar('theta',theta)
            table.insert(flames,star)
          end

          local warn = SetSprite('slash/emerb',x,y)
          warn.SetVar('spawn',frame)
          warn.sprite.rotation = 90
          table.insert(warns,warn)
          Audio.PlaySound('thunder')
        end
      end
    end

    for i=1,#flames do
      if flames[i].isactive then
        local theta = flames[i].GetVar('theta')
        flames[i].Move(4*math.cos(theta),4*math.sin(theta))

        if flames[i].absx <= 0 or flames[i].absy <= 0 or flames[i].absx >= 640 or flames[i].absy >= 480 then
          flames[i].Remove()
        end
      end
    end

    for i=1,#warns do
      if warns[i].isactive then
        local spawn = warns[i].GetVar('spawn')
        warns[i].sprite.color = hsvToRgb((spawn+30-frame)*2,255,255)

        if spawn + 30 - frame == 0 then
          local slash = SetDieForce('slash/slashb',warns[i].x,warns[i].y)
          slash.sprite.rotation = warns[i].sprite.rotation
          slash.ppcollision = true
          table.insert(slashs,slash)
          warns[i].Remove()
        end
      end
    end

    for i=1,#slashs do
      if slashs[i].isactive then
        slashs[i].sprite.alpha = slashs[i].sprite.alpha - 0.1
        if slashs[i].sprite.alpha == 0.2 then
          slashs[i].SetVar('type','sprite')
        elseif slashs[i].sprite.alpha == 0 then
          slashs[i].Remove()
        end
      end
    end

    if frame == 700 then
      EndWave()
    end
  end

  if died then
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