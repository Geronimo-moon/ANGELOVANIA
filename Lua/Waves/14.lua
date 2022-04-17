require 'Libraries.bulletType'

Arena.Resize(200,100)
frame = 0
uknives = {}
dknives = {}
rstar = {}
lstar = {}
direction = 1

function Update()
  frame = frame + 1

  Arena.Resize(200,100*(3/4+1/2*(math.sin(frame*math.pi/90))^2))

  if frame % 30 == 0 then
    local uknife = SetNotime("knifed",100,Arena.height/2-20)
    local dknife = SetNotime("knifeu",-100,-Arena.height/2+20)
    uknife.ppcollision = true
    dknife.ppcollision = true
    table.insert(uknives,uknife)
    table.insert(dknives,dknife)
  end

  if frame % 90 == 23 then
    local star1 = SetDefault('attack/star',320,0)
    local star2 = SetDefault('attack/star',-320,0)

    table.insert(lstar,star2)
    table.insert(rstar,star1)
  end

  for i=1,#uknives do
    if uknives[i].isactive then
      uknives[i].Move(3*(-1)^direction,0)
      uknives[i].MoveTo(uknives[i].x,Arena.height/2-20)
      if uknives[i].x <= -Arena.width/2 then
        uknives[i].Remove()
      end
    end
  end

  for i=1,#dknives do
    if dknives[i].isactive then
      dknives[i].Move(-3*(-1)^direction,0)
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

  if frame == 600 then
    EndWave()
  end
end

function OnHit(bullet)
  Hit(bullet)
end