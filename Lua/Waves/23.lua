require 'Libraries/bulletType'
local soul = require 'Libraries/soulManager'
soul.Init({"orange"})

Arena.Resize(420,100)
Player.MoveTo(-Arena.width/2+20,0)

local frame = 0
local rknives = {}
local lknives = {}
local dspears = {}
local uspears = {}

SetPPCollision(true)

local gore = require 'Animations/backMonster'
gore.init('monsters/asgore')

function Update()
  frame = frame + 1
  gore.update(frame)
  if frame <= 525 then
    if frame % 150 == 75 then
      Arena.Move(0,80,false)
      for i=1,#dspears-1 do
        dspears[i].MoveToAbs(dspears[i].absx,dspears[i].absy+80)
      end
      if frame ~= 525 then
        Audio.PlaySound('asgore')
        dspears[#dspears].MoveToAbs(dspears[#dspears].absx,dspears[#dspears].absy+180)
      end
      for i=1,#uspears do
        uspears[i].MoveToAbs(uspears[i].absx,uspears[i].absy+80)
      end
    elseif frame % 150 == 0 and frame > 0 then
      Arena.Move(0,-80,false)
      for i=1,#dspears do
        dspears[i].MoveToAbs(dspears[i].absx,dspears[i].absy-80)
      end
      for i=1,#uspears-1 do
        uspears[i].MoveToAbs(uspears[i].absx,uspears[i].absy-80)
      end
      Audio.PlaySound('asgore')
      uspears[#uspears].MoveToAbs(uspears[#uspears].absx,uspears[#uspears].absy-180)
    elseif frame % 150 == 45 then
      Audio.PlaySound('BeginBattle1')
      local spear = SetDefault("attack/trident",-Arena.width/2 + 70*(frame - frame%75)/75,-Arena.height/2-128)
      spear.sprite.color = {1,0,0}
      spear.sprite.rotation = 180
      table.insert(dspears,spear)
    elseif frame % 150 == 120 then
      Audio.PlaySound('BeginBattle1')
      local spear = SetDefault("attack/trident",-Arena.width/2 + 70*(frame - frame%75)/75,Arena.height/2+128)
      spear.sprite.color = {1,0,0}
      table.insert(uspears,spear)
    end

    if frame % 45 == 0 then
      local lknife = SetNotime("knifed",Arena.width/2,Arena.height/3-Arena.y+90)
      local rknife = SetNotime("knifeu",-Arena.width/2,-Arena.height/3-Arena.y+90)
      local rknife2 = SetNotime("knifeu",-Arena.width/2,Arena.height-Arena.y+90)
      table.insert(lknives,lknife)
      table.insert(rknives,rknife)
      table.insert(rknives,rknife2)
    end

    for i=1,#lknives do
      if lknives[i].isactive then
        lknives[i].Move(-2,0)
        lknives[i].sprite.Scale(1,1+1/2*(math.cos(math.pi*frame/120)))
        if lknives[i].x <= -Arena.width/2 or frame == 515 then
          lknives[i].Remove()
        end
      end
    end

    for i=1,#rknives do
      if rknives[i].isactive then
        rknives[i].Move(2,0)
        rknives[i].sprite.Scale(1,1/2+(math.sin(math.pi*frame/120))^2)
        if rknives[i].x >= Arena.width/2 or frame == 515 then
          rknives[i].Remove()
        end
      end
    end
  else
    if frame >= 520 and frame <= 540 then
      for i = 1, #dspears do
        dspears[i].Move(0,-(dspears[i].y+178)/3)
      end
      for i = 1, #uspears do
        uspears[i].Move(0,-(uspears[i].y-178)/3)
      end
    end

    if frame == 540 then
      soul.Change({'cyan'})
      local index = math.random(1,14)
      if index <= 7 then
        if index%2 == 1 then
          dspears[(index-1)/2+1].sprite.color = {0.15,0.7,0.95}
          dspears[(index-1)/2+1].SetVar('color','blue')
        else
          uspears[(index)/2].sprite.color = {0.15,0.7,0.95}
          uspears[(index)/2].SetVar('color','blue')
        end
      else
        if index%2 == 0 then
          dspears[(index-8)/2+1].sprite.color = {1,0.45,0}
          dspears[(index-8)/2+1].SetVar('color','orange')
        else
          uspears[(index-7)/2].sprite.color = {1,0.45,0}
          uspears[(index-7)/2].SetVar('color','orange')
        end
      end
      for i=1,#dspears do
        dspears[i].MoveTo(dspears[i].x,-178)
      end
      for i=1,#uspears do
        uspears[i].MoveTo(uspears[i].x,178)
      end
    end

    if frame == 660 then
      Audio.PlaySound('asgore')
      for i=1,#dspears do
        dspears[i].MoveToAbs(dspears[i].absx,dspears[i].absy+100)
      end
      for i=1,#uspears do
        uspears[i].MoveToAbs(uspears[i].absx,uspears[i].absy-100)
      end
    end

    if frame == 720 then
      soul.Change()
      gore.destroy()
      EndWave()
    end
  end

  soul.Update()
end

function OnHit(bullet)
  Hit(bullet)
end