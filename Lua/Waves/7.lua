require 'Libraries.bulletType'

Arena.Resize(220,220)

frame = -10
moves = {0,0}

uknives = {}
dknives = {}
rknives = {}
lknives = {}

lastmoves = {0,0}


function Update()
  frame = frame + 1
  local speed = 2-math.ceil(frame/270)/2

  if frame <= 500 then
    if frame == 0 then
      for i=1,11 do
        local uknife = SetNotime('knifed',-Arena.width/2+20*i,Arena.height/2-10)
        local dknife = SetNotime('knifeu',-Arena.width/2+20*i,-Arena.height/2+10)
        local rknife = SetNotime('knifel',Arena.width/2-10,-Arena.height/2+20*i)
        local lknife = SetNotime('knifer',-Arena.width/2+10,-Arena.height/2+20*i)
        table.insert(uknives,uknife)
        table.insert(dknives,dknife)
        table.insert(lknives,lknife)
        table.insert(rknives,rknife)
      end
    end

    Arena.Move(speed*moves[1],speed*moves[2],false)

    if frame % 10 == 0 and frame > 0 then
      for i=1,#uknives do
        uknives[i].Move(0,-2)
        dknives[i].Move(0,0)
        rknives[i].Move(-1,0)
        lknives[i].Move(1,0)
      end
      Arena.Resize(Arena.width-2,Arena.height-2)
    end

    if frame % 60 == 0 then
      lastmoves = moves
      while true do
        moves = {(-1)^(math.random(1,10)),(-1)^(math.random(1,10))}
        if moves ~= lastmoves then
          break
        end
      end
      if Arena.x < Arena.width then
        moves[1] = 1
      elseif Arena.x > 640-Arena.width then
        moves[1] = -1
      end
      if Arena.y < Arena.height then
        moves[2] = 1
      elseif Arena.y > 480-Arena.height then
        moves[2] = -1
      end
    end

    for i=1,#uknives do
      uknives[i].Move(speed*moves[1],speed*moves[2])
      dknives[i].Move(speed*moves[1],speed*moves[2])
      rknives[i].Move(speed*moves[1],speed*moves[2])
      lknives[i].Move(speed*moves[1],speed*moves[2])
    end
  end

  if frame == 550 then
    local color = math.random(1,2)
    for i=1,#uknives do
      if color == 1 then
        uknives[i].sprite.Set('bknifed')
        uknives[i].SetVar('color','blue')
      elseif color == 2 then
        uknives[i].sprite.Set('oknifed')
        uknives[i].SetVar('color','orange')
      end
    end
  end

  if frame >= 570 then
    for i=1,#uknives do
      if uknives[i].isactive then
        uknives[i].Move(0,-5)
        if uknives[i].y <= -240 then
          uknives[i].Remove()
        end
      end
    end
  end

  if frame == 610 then
    local color = math.random(1,2)
    for i=1,#dknives do
      if color == 1 then
        dknives[i].sprite.Set('bknifeu')
        dknives[i].SetVar('color','blue')
      elseif color == 2 then
        dknives[i].sprite.Set('oknifeu')
        dknives[i].SetVar('color','orange')
      end
    end
  end

  if frame >= 630 then
    for i=1,#dknives do
      if dknives[i].isactive then
        dknives[i].Move(0,5)
        if dknives[i].y >= 240 then
          dknives[i].Remove()
        end
      end
    end
  end

  if frame == 670 then
    local color = math.random(1,2)
    for i=1,#rknives do
      if color == 1 then
        rknives[i].sprite.Set('bknifel')
        rknives[i].SetVar('color','blue')
      elseif color == 2 then
        rknives[i].sprite.Set('oknifel')
        rknives[i].SetVar('color','orange')
      end
    end
  end

  if frame >= 690 then
    for i=1,#rknives do
      if rknives[i].isactive then
        rknives[i].Move(-5,0)
        if rknives[i].x <= -320 then
          rknives[i].Remove()
        end
      end
    end
  end

  if frame == 730 then
    local color = math.random(1,2)
    for i=1,#lknives do
      if color == 1 then
        lknives[i].sprite.Set('bknifer')
        lknives[i].SetVar('color','blue')
      elseif color == 2 then
        lknives[i].sprite.Set('oknifer')
        lknives[i].SetVar('color','orange')
      end
    end
  end

  if frame >= 750 then
    for i=1,#lknives do
      if lknives[i].isactive then
        lknives[i].Move(5,0)
        if lknives[i].x >= 320 then
          lknives[i].Remove()
        end
      end
    end
  end

  if frame == 800 then
    EndWave()
  end

end

function OnHit(bullet)
  Hit(bullet)
end