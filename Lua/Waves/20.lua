require 'Libraries.bulletType'

Arena.Resize(230,230)

frame = 0

knives = {}
bknives = {}
oknives = {}

start = math.random(1,360)
bindex = start
oindex = start

funciton Update()
  frame = frame + 1

  local knife = SetNotime('knifel',Arena.width*2/3*math.cos(math.pi*start/180),Arena.width*2/3*math.sin(math.pi*start/180))
  knife.SetVar('theta',math.pi*start/180)
  knife.sprite.rotation = start
  table.insert(knives,knife)

  local bknife = SetNotime('bknifel',Arena.width*2/3*math.cos(math.pi*bindex/180),Arena.width*2/3*math.sin(math.pi*bindex/180))
  bknife.SetVar('theta',math.pi*bindex/180)
  bknife.sprite.rotation = bindex
  table.insert(bknives,bknife)

  local oknife = SetNotime('bknifel',Arena.width*2/3*math.cos(math.pi*oindex/180),Arena.width*2/3*math.sin(math.pi*oindex/180))
  oknife.SetVar('theta',math.pi*oindex/180)
  oknife.sprite.rotation = oindex
  table.insert(oknives,oknife)

  start = start + 8
  bindex = bindex + 14
  oindex = oindex + 20

  for i=1,#knives do
    if knives[i].isactive then
      local theta = knives[i].GetVar('theta')
      knives[i].Move(5*math.cos(theta),5*math.sin(theta))
      if knives[i].absx <= 0 or knives[i].absy <= 0 or knives[i].absx >= 640 or knives[i].absy >= 480 then
        knives[i].Remove()
      end
    end
  end

  for i=1,#bknives do
    if bknives[i].isactive then
      local theta = bknives[i].GetVar('theta')
      bknives[i].Move(5*math.cos(theta),5*math.sin(theta))
      if bknives[i].absx <= 0 or bknives[i].absy <= 0 or bknives[i].absx >= 640 or bknives[i].absy >= 480 then
        bknives[i].Remove()
      end
    end
  end

  for i=1,#oknives do
    if oknives[i].isactive then
      local theta = oknives[i].GetVar('theta')
      oknives[i].Move(5*math.cos(theta),5*math.sin(theta))
      if oknives[i].absx <= 0 or oknives[i].absy <= 0 or oknives[i].absx >= 640 or oknives[i].absy >= 480 then
        oknives[i].Remove()
      end
    end
  end

  if frame == 900 then
    EndWave()
  end
end

funciton OnHit(bullet)
  Hit(bullet)
end