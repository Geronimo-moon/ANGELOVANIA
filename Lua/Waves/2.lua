require 'Libraries/bulletType'

Arena.Resize(40,40)

frame = 0
offset = 0
index = {}
emers = {isactive = false}
knives = {}

function Update()
  frame = frame + 1
  if frame >= 10 and frame <= 490 then
    RandomShot(frame)
  end

  if frame >= 540 and frame <= 1020 then
    RandomShot(frame)
  end

  for i=1,#knives do
    if knives[i].isactive then
      local dir = knives[i].GetVar("direction")
      if dir == "left" then
        knives[i].Move(-10,0)
      elseif dir == "up" then
        knives[i].Move(0,10)
      elseif dir == "right" then
        knives[i].Move(10,0)
      elseif dir == "down" then
        knives[i].Move(0,-10)
      end
      if knives[i].absx <= 0 or knives[i].absx >= 640 or knives[i].absy <= 0 or knives[i].absy >= 480 then
        knives[i].Remove()
      end
    end
  end

  if frame == 1060 then
    EndWave()
  end
end

function RandomShot(frame)
  if offset == 0 then
    for i=1,#knives do
      if knives[i].isactive then
        knives[i].Remove()
      end
    end
    index = {}
    knives = {}
    emers = {isactive = false}
    for i=1,8 do
      local a = math.random(1,4)
      table.insert(index,a)
    end
    offset = frame

  elseif (frame-offset)%30 == 0 then
    local n = math.floor((frame-offset)/30)
    if n <= 8 then
      if index[n] == 1 then
        if emers.isactive then
          emers.Remove()
        end
        local warn = SetSprite("warnboxb",0,10)
        warn.sprite.color = {255,100,0}
        emers = warn
        Audio.PlaySound("BeginBattle1")
      elseif index[n] == 2 then
        if emers.isactive then
          emers.Remove()
        end
        local warn = SetSprite("warnboxv",10,0)
        warn.sprite.color = {255,100,0}
        emers = warn
        Audio.PlaySound("BeginBattle1")
      elseif index[n] == 3 then
        if emers.isactive then
          emers.Remove()
        end
        local warn = SetSprite("warnboxb",0,-10)
        warn.sprite.color = {255,100,0}
        emers = warn
        Audio.PlaySound("BeginBattle1")
      elseif index[n] == 4 then
        if emers.isactive then
          emers.Remove()
        end
        local warn = SetSprite("warnboxv",-10,0)
        warn.sprite.color = {255,100,0}
        emers = warn
        Audio.PlaySound("BeginBattle1")
      end

    elseif n >= 9 and n <= 16 then
      if emers.isactive then
        emers.Remove()
        emers = {isactive = false}
      end

      if index[n-8]==1 then
        local knife = SetNotime("knifel",256,10)
        knife.SetVar("direction","left")
        table.insert(knives,knife)
      elseif index[n-8]==2 then
        local knife = SetNotime("knifeu",10,-60)
        knife.SetVar("direction","up")
        table.insert(knives,knife)
      elseif index[n-8]==3 then
        local knife = SetNotime("knifer",-256,-10)
        knife.SetVar("direction","right")
        table.insert(knives,knife)
      elseif index[n-8]==4 then
        local knife = SetNotime("knifed",-10,176)
        knife.SetVar("direction","down")
        table.insert(knives,knife)
      end
    end
    if n == 16 then
      offset = 0
    end
  end

end

function OnHit(bullet)
  Hit(bullet)
end