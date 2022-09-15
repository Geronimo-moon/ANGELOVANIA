require 'Libraries/bulletType'

Arena.Resize(230,230)

local frame = 0

local knives = {}
local bknives = {}
local oknives = {}

local start = math.random(1,360)
local bindex = start + 90
local oindex = math.random(1,360)

SetPPCollision(true)

local switch = 1

function Update()
  frame = frame + 1

  if frame % 3 == 0 then
    Audio.PlaySound('fly')
    local knife = SetBeam('rknifel',Arena.width*3/4*math.cos(math.pi*start/180),Arena.width*3/4*math.sin(math.pi*start/180))
    knife.SetVar('spawn',frame)
    knife.SetVar('theta',math.pi*start/180)
    knife.sprite.rotation = start
    table.insert(knives,knife)

    local bknife = SetNotime('bknifel',Arena.width*3/4*math.cos(math.pi*bindex/180),Arena.width*3/4*math.sin(math.pi*bindex/180),"","blue")
    bknife.SetVar('spawn',frame)
    bknife.SetVar('theta',math.pi*bindex/180)
    bknife.sprite.rotation = bindex
    bknife.sprite.Scale(1,0.8)
    table.insert(bknives,bknife)

    local oknife = SetNotime('oknifel',Arena.width*3/4*math.cos(math.pi*oindex/180),Arena.width*3/4*math.sin(math.pi*oindex/180),"","orange")
    oknife.SetVar('spawn',frame)
    oknife.SetVar('theta',math.pi*oindex/180)
    oknife.sprite.rotation = oindex
    oknife.sprite.Scale(1,0.9)
    table.insert(oknives,oknife)

    start = start - switch*8
    bindex = bindex - 8
    oindex = oindex + 12
  end

  for i=1,#knives do
    if knives[i].isactive then
      local theta = knives[i].GetVar('theta')
      if knives[i].GetVar('spawn') + 30 >= frame then
        knives[i].MoveTo((Arena.width*3/4+30*math.sin(((frame-knives[i].GetVar('spawn'))*math.pi/30)))*math.cos(theta),(Arena.width*3/4+30*math.sin(((frame-knives[i].GetVar('spawn'))*math.pi/30)))*math.sin(theta))
      else
        knives[i].Move(-10*math.cos(theta),-10*math.sin(theta))
      end

      if knives[i].absx <= 0 or knives[i].absy <= 0 or knives[i].absx >= 640 or knives[i].absy >= 480 then
        knives[i].Remove()
      end
    end
  end

  for i=1,#bknives do
    if bknives[i].isactive then
      local theta = bknives[i].GetVar('theta')
      if bknives[i].GetVar('spawn') + 30 >= frame then
        bknives[i].MoveTo((Arena.width*3/4+30*math.sin(((frame-bknives[i].GetVar('spawn'))*math.pi/30)))*math.cos(theta),(Arena.width*3/4+30*math.sin(((frame-bknives[i].GetVar('spawn'))*math.pi/30)))*math.sin(theta))
      else
        bknives[i].Move(-10*math.cos(theta),-10*math.sin(theta))
      end
      if bknives[i].absx <= 0 or bknives[i].absy <= 0 or bknives[i].absx >= 640 or bknives[i].absy >= 480 then
        bknives[i].Remove()
      end
    end
  end

  for i=1,#oknives do
    if oknives[i].isactive then
      local theta = oknives[i].GetVar('theta')
      if oknives[i].GetVar('spawn') + 30 >= frame then
        oknives[i].MoveTo((Arena.width*3/4+30*math.sin(((frame-oknives[i].GetVar('spawn'))*math.pi/30)))*math.cos(theta),(Arena.width*3/4+30*math.sin(((frame-oknives[i].GetVar('spawn'))*math.pi/30)))*math.sin(theta))
      else
        oknives[i].Move(-10*math.cos(theta),-10*math.sin(theta))
      end
      if oknives[i].absx <= 0 or oknives[i].absy <= 0 or oknives[i].absx >= 640 or oknives[i].absy >= 480 then
        oknives[i].Remove()
      end
    end
  end

  if frame == 600 then
    switch = -1
  end

  if frame == 1000 then
    EndWave()
  end
end

function OnHit(bullet)
  Hit(bullet)
end