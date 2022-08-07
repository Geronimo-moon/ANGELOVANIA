require 'Libraries/bulletType'
local orange = require 'Libraries/orangesoul'
local cyan = require 'Libraries/cyansoul'

local frame = 0

Arena.Resize(300,200)

local firstKnives = {}
local saves = {}
local secondKnives = {}

local safebox = SetSprite('warnbox',0,0)
safebox.sprite.color = {0,1,0}
safebox.sprite.Scale(0.5,0.5)
safebox.sprite.alpha = 0

local knives = {}
local shadows = {}

function Update()
  frame = frame + 1

  if orange.isactive then
    orange.Update()
  end
  if cyan.isactive then
    cyan.Update()
  end

  if frame >= 10 and frame <= 110 then
    if frame % 5 == 0 then
      if safebox.sprite.alpha == 1 and frame % 10 == 0 then
        safebox.sprite.alpha = 0
      end
      local knifer = SetBeam('rknifel',320,Player.y)
      local knifel = SetBeam('rknifer',-320,Player.y)
      local knifeu = SetBeam('rknifed',Player.x,240)
      local knifed = SetBeam('rknifeu',Player.x,-240)
      knifer.SetVar('mv',{-1,0,frame})
      knifel.SetVar('mv',{1,0,frame})
      knifeu.SetVar('mv',{0,-1,frame})
      knifed.SetVar('mv',{0,1,frame})
      table.insert(firstKnives,knifer)
      table.insert(firstKnives,knifeu)
      table.insert(firstKnives,knifed)
      table.insert(firstKnives,knifel)
    end
    if frame % 20 == 0 then
      local x = math.random(-Arena.width/4+25,Arena.width/4-25)
      local y = math.random(-Arena.height/4+25,Arena.height/4-25)
      table.insert(saves,{x,y})
      safebox.sprite.alpha = 1
      safebox.MoveTo(x,y)
      Audio.PlaySound('BeginBattle1')
    end
  end

  for i=1,#firstKnives do
    if firstKnives[i].isactive then
      local move = firstKnives[i].GetVar('mv')
      firstKnives[i].Move(move[1],move[2])
      for j=1,2 do
        if move[j] ~= 0 then
          local param = move[j]/math.abs(move[j])
          move[j] = param*(math.abs(move[j])+(frame-move[3])/7)
        end
      end
      firstKnives[i].SetVar('mv',move)
    end
    if firstKnives[i].absx <= -64 or firstKnives[i].absx >= 704 or firstKnives[i].absy <= -64 or firstKnives[i].absy >= 544 then
      firstKnives[i].Remove()
    end
  end

  if frame == 105 then
    orange.Init()
    if safebox.sprite.alpha == 1 then
      safebox.sprite.alpha = 0
    end
  end

  if frame >= 120 and frame <= 480 then
    if frame % 90 == 30 then
      local x = saves[(frame-30)/90][1]
      local y = saves[(frame-30)/90][2]
      local knifer = SetNotime('knifel',320,Player.y)
      local knifel = SetNotime('knifer',-320,Player.y)
      local knifeu = SetNotime('knifed',Player.x,240)
      local knifed = SetNotime('knifeu',Player.x,-240)
      knifer.sprite.Scale(10,-10)
      knifel.sprite.Scale(10,10)
      knifeu.sprite.Scale(-10,10)
      knifed.sprite.Scale(-10,10)
      knifer.ppcollision = true
      knifel.ppcollision = true
      knifeu.ppcollision = true
      knifed.ppcollision = true
      knifer.MoveTo(320+10*knifer.sprite.width,y-25-5*knifer.sprite.height)
      knifed.MoveTo(x-25-5*knifed.sprite.width,-240-10*knifed.sprite.height)
      knifeu.MoveTo(x+25+5*knifeu.sprite.width,240+10*knifeu.sprite.height)
      knifel.MoveTo(-320-10*knifel.sprite.width,y+25+5*knifel.sprite.height)
      knifer.SetVar('mv',{-15,0})
      knifel.SetVar('mv',{15,0})
      knifeu.SetVar('mv',{0,-15})
      knifed.SetVar('mv',{0,15})
      table.insert(secondKnives,knifer)
      table.insert(secondKnives,knifed)
      table.insert(secondKnives,knifeu)
      table.insert(secondKnives,knifel)
    end
  end

  for i=1,#secondKnives do
    if secondKnives[i].isactive then
      local move = secondKnives[i].GetVar('mv')
      secondKnives[i].Move(move[1],move[2])
    end
    if secondKnives[i].absx < -secondKnives[i].sprite.width*10 or secondKnives[i].absx > 640+secondKnives[i].sprite.width*10 or secondKnives[i].absy < -secondKnives[i].sprite.height*11 or secondKnives[i].absy > 480+secondKnives[i].sprite.height*10 then
      secondKnives[i].Remove()
    end
  end

  if frame == 550 then
    orange.Quit()
    Arena.Resize(200,200)
    cyan.Init()
  end

  if frame >= 550 and frame <= 630 then
    if frame % 8 == 0 then
      local knife = SetNotime("knifed",math.random(-Arena.width/2,Arena.width/2),Arena.height*2)
      knife.SetVar('spawn',frame)
      knife.SetVar('mv',{0,-7})
      knife.ppcollision = true
      table.insert(knives,knife)
    end
  end

  if frame >= 630 and frame <= 710 then
    if frame % 8 == 0 then
      local knife = SetNotime("knifeu",math.random(-Arena.width/2,Arena.width/2),-Arena.height*2)
      knife.SetVar('spawn',frame)
      knife.SetVar('mv',{0,7})
      knife.ppcollision = true
      table.insert(knives,knife)
    end
  end

  if frame >= 710 and frame <= 790 then
    if frame % 8 == 0 then
      local knife = SetNotime("knifer",-Arena.width*2,math.random(-Arena.height/2,Arena.height/2))
      knife.SetVar('spawn',frame)
      knife.SetVar('mv',{7,0})
      knife.ppcollision = true
      table.insert(knives,knife)
    end
  end

  if frame >= 790 and frame <= 870 then
    if frame % 8 == 0 then
      local knife = SetNotime("knifel",Arena.width*2,math.random(-Arena.height/2,Arena.height/2))
      knife.SetVar('spawn',frame)
      knife.SetVar('mv',{-7,0})
      knife.ppcollision = true
      table.insert(knives,knife)
    end
  end

  for i=1,#knives do
    if knives[i].isactive then
      mv = knives[i].GetVar('mv')
      knives[i].Move(mv[1],mv[2])
      if frame % 3 == 0 then
        local shadow = SetNotime(knives[i].sprite.spritename,knives[i].x,knives[i].y)
        shadow.SetVar('spawn',frame)
        shadow.ppcollision = true
        table.insert(shadows,shadow)
      end
      if frame - knives[i].GetVar('spawn') >= 150 then
        knives[i].sprite.alpha = knives[i].sprite.alpha - 0.1
        if knives[i].sprite.alpha == 0 then
          knives[i].Remove()
        end
      end
    end
  end

  for i=1,#shadows do
    if shadows[i].isactive then
      local spawn = shadows[i].GetVar('spawn')
      if (frame-spawn)%2 == 0 then
        shadows[i].sprite.alpha = shadows[i].sprite.alpha - 0.1

        if shadows[i].sprite.alpha == 0 then
          shadows[i].Remove()
        end
      end
    end
  end

  if frame == 900 then
    cyan.Quit()
    EndWave()
  end
end

function OnHit(bullet)
  local kr
  if Encounter["debugging"] or bullet.GetVar("type") == "sprite" then
    kr = 0
  elseif Encounter["noob"] or Encounter["ez"] then
    kr = 3
  else
    kr = 6
  end
  Encounter.Call("Karma_Inc", kr)
  Hit(bullet)
end