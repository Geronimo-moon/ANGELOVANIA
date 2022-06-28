require 'Libraries/bulletType'

Arena.Resize(200,100)
local frame = 0
local uknives = {}
local dknives = {}
local rstar = {}
local lstar = {}
local mstar = {}
local direction = 1

local asri = require 'Animations/backMonster'
asri.init('monsters/asri')

function Update()
  asri.update(frame)
  frame = frame + 1

  Arena.Resize(200,100*(3/4+1/2*(math.sin(frame*math.pi/90))^2))

  if frame % 40 == 0 and frame <= 573 then
    local uknife = SetNotime("knifed",100,Arena.height/2-20)
    local dknife = SetNotime("knifeu",-100,-Arena.height/2+20)
    uknife.ppcollision = true
    dknife.ppcollision = true
    table.insert(uknives,uknife)
    table.insert(dknives,dknife)
  end

  if frame % 90 == 23 and frame <= 573 then
    local star1 = SetDefault('attack/star',320,0)
    local star2 = SetDefault('attack/star',-320,0)

    table.insert(lstar,star2)
    table.insert(rstar,star1)
  end

  for i=1,#uknives do
    if uknives[i].isactive then
      uknives[i].Move(2.5*(-1)^direction,0)
      uknives[i].MoveTo(uknives[i].x,Arena.height/2-20)
      if uknives[i].x <= -Arena.width/2 then
        uknives[i].Remove()
      end
    end
  end

  for i=1,#dknives do
    if dknives[i].isactive then
      dknives[i].Move(-2.5*(-1)^direction,0)
      dknives[i].MoveTo(dknives[i].x,-Arena.height/2+20)
      if dknives[i].x >= Arena.width/2  then
        dknives[i].Remove()
      end
    end
  end

  for i=1,#lstar do
    if lstar[i].isactive then
      lstar[i].Move(10,0)
      lstar[i].MoveTo(lstar[i].x,0)

      lstar[i].sprite.rotation = 5*frame

      if lstar[i].x >= 320 then
        lstar[i].Remove()
      end
    end
  end

  for i=1,#rstar do
    if rstar[i].isactive then
      rstar[i].Move(-10,0)
      rstar[i].MoveTo(rstar[i].x,0)

      rstar[i].sprite.rotation = 360 - 5*frame

      if rstar[i].x <= -320 then
        rstar[i].Remove()
      end
    end
  end

  if frame >= 563 then
    for i=1,#uknives do
      if uknives[i].isactive then
        uknives[i].sprite.alpha = 0.1*(573 - frame)

        if uknives[i].sprite.alpha == 0 then
          uknives[i].Remove()
        end
      end
    end
    for i=1,#dknives do
      if dknives[i].isactive then
        dknives[i].sprite.alpha = 0.1*(573 - frame)
        if dknives[i].sprite.alpha == 0  then
          dknives[i].Remove()
        end
      end
    end
  end

  if frame == 595 then
    for i=1,#lstar do
      if lstar[i].isactive then
          lstar[i].Remove()
      end
    end
    for i=1,#rstar do
      if rstar[i].isactive then
          rstar[i].Remove()
      end
    end
  end

  if frame >= 595 then
    if frame % 20 == 15 then
      for i=0,8 do
        local theta = math.pi*2*i/9
        local star = SetDefault('attack/ministar',math.cos(theta),math.sin(theta))
        star.SetVar('theta',theta)
        table.insert(mstar,star)
      end
    elseif frame % 20 == 5 then
      for i=0,8 do
        local theta = math.pi*2*i/9+math.pi/9
        local star = SetDefault('attack/ministar',math.cos(theta),math.sin(theta))
        star.SetVar('theta',theta)
        table.insert(mstar,star)
      end
    end

    for i=1,#mstar do
      if mstar[i].isactive then
        local theta = mstar[i].GetVar('theta')
        mstar[i].Move(3*math.cos(theta),3*math.sin(theta))
      end
    end
  end

  if frame == 650 then
    asri.destroy()
    EndWave()
  end
end

function OnHit(bullet)
  Hit(bullet)
end