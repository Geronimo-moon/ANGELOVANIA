require 'Libraries/bulletType'
local blue = require 'Libraries/soulManager'
blue.Init({"blue"})

GetGlobal('charahead').Set("chara/head")

local frame = 0

Arena.Resize(200,150)

local warnbox = nil
local lbones = {}
local rbones = {}
local dbones = {}
local knives = {}
local db = false

local papy = require 'Animations/backMonster'
papy.init('monsters/papy')

function Update()
  papy.update(frame)
  frame = frame + 1
  blue.Update()

  if frame == 1 then
    warnbox = SetSprite('attack/warnbox112',-Arena.width/2+40,0)
    blue.blue.SetDir('left')
    Player.MoveTo(-Arena.width/2+8,0)
    Audio.PlaySound('BeginBattle1')
  end

  if frame == 21 then
    for i=1,15 do
      local bone = SetDefault('attack/boneb',-375,-Arena.height/2+5+10*(i-1))
      table.insert(lbones,bone)
    end
  end

  if frame > 21 and frame <= 41 then
    for i = 1,#lbones  do
      lbones[i].Move(15,0)
    end
  end

  if frame == 31 then
    warnbox.Remove()
  end

  if frame == 41 then
    warnbox = SetSprite('attack/warnbox112',Arena.width/2-40,0)
    blue.blue.SetDir('right')
    Player.MoveTo(Arena.width/2-8,0)
    Audio.PlaySound('BeginBattle1')
  end

  if frame == 61 then
    for i=1,15 do
      local bone = SetDefault('attack/boneb',375,-Arena.height/2+5+10*(i-1))
      table.insert(rbones,bone)
    end
  end

  if frame > 61 and frame <= 81 then
    for i = 1,#rbones  do
      rbones[i].Move(-15,0)
    end
  end

  if frame == 71 then
    warnbox.Remove()
  end

  if frame == 81 then
    blue.blue.SetDir('down')
  end

  if frame >= 81 then
    if frame % 50 == 5 then
      local knife = SetNotime('knifed',10,272)
      table.insert(knives,knife)
    elseif frame % 50 == 30 then
      local knife = SetNotime('knifed',-10,272)
      table.insert(knives,knife)
    end

    if frame % 60 == 0 then
      warnbox = SetSprite('attack/warnbox10',0,-Arena.height/2+20)
      warnbox.SetVar('spawn',frame)
      db = true
      Audio.PlaySound('BeginBattle1')
    end
  end

  if db and warnbox.GetVar('spawn') + 30 == frame then
    warnbox.sprite.alpha = 0
    for i=1,20 do
      local bone = SetDefault('attack/bonev10',-Arena.width/2+5+10*(i-1),-Arena.height/2+5)
      table.insert(dbones,bone)
    end
  end

  if db and warnbox.GetVar('spawn') + 33 == frame then
    for i=1,#dbones do
      dbones[i].sprite.Set('attack/bonev20')
      dbones[i].Move(0,5)
    end
  end

  if db and warnbox.GetVar('spawn') + 36 == frame then
    for i=1,#dbones do
      dbones[i].sprite.Set('attack/bonev30')
      dbones[i].Move(0,5)
    end
  end

  if db and warnbox.GetVar('spawn') + 39 == frame then
    for i=1,#dbones do
      dbones[i].sprite.Set('attack/bonev40')
      dbones[i].Move(0,5)
    end
  end

  if db and warnbox.GetVar('spawn') + 42 == frame then
    for i=1,#dbones do
      dbones[i].sprite.Set('attack/bonev30')
      dbones[i].Move(0,-5)
    end
  end

  if db and warnbox.GetVar('spawn') + 45 == frame then
    for i=1,#dbones do
      dbones[i].sprite.Set('attack/bonev20')
      dbones[i].Move(0,-5)
    end
  end

  if db and warnbox.GetVar('spawn') + 48 == frame then
    for i=1,#dbones do
      dbones[i].sprite.Set('attack/bonev10')
      dbones[i].Move(0,-5)
    end
  end

  if db and warnbox.GetVar('spawn') + 51 == frame then
    for i=1,#dbones do
      dbones[i].Remove()
    end
    dbones = {}
    warnbox.Remove()
    warnbox = nil
    db = false
  end

  for i=1,#knives do
    if knives[i].isactive then
      knives[i].Move(0,-7)
      if knives[i].absy <= 0 then
        knives[i].Remove()
      end
    end
  end

  if frame == 760 then
    blue.Change()
    papy.destroy()
    EndWave()
  end
end

function OnHit(bullet)
  Hit(bullet)
end