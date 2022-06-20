require 'Libraries/bulletType'
blue = require "Libraries/bluesoul"
blue.Initialize()
Audio.PlaySound("change")

Arena.Resize(200,140)

frame = 0

bonesl = {}
bonesr = {}
knivesl = {}
knivesr = {}
warnbox = nil
bones = {}

function Update()
  frame = frame + 1

  if blue ~= nil then
    blue.Update()
  end

  if frame <= 530 then
    if frame % 40 == 1 then
      local boner = SetDefault('attack/bonev70',Arena.width/2-5,Arena.height/2-35)
      local bonel = SetDefault('attack/bonev70',-Arena.width/2+5,Arena.height/2-35)
      table.insert(bonesl,boner)
      table.insert(bonesr,bonel)
    elseif frame % 40 == 4 then
      local boner = SetDefault('attack/bonev80',Arena.width/2-5,Arena.height/2-40)
      local bonel = SetDefault('attack/bonev80',-Arena.width/2+5,Arena.height/2-40)
      table.insert(bonesl,boner)
      table.insert(bonesr,bonel)
    elseif frame % 40 == 7 then
      local boner = SetDefault('attack/bonev90',Arena.width/2-5,Arena.height/2-45)
      local bonel = SetDefault('attack/bonev90',-Arena.width/2+5,Arena.height/2-45)
      table.insert(bonesl,boner)
      table.insert(bonesr,bonel)
    elseif frame % 40 == 10 then
      local boner = SetDefault('attack/bonev',Arena.width/2-5,20)
      local bonel = SetDefault('attack/bonev',-Arena.width/2+5,20)
      table.insert(bonesl,boner)
      table.insert(bonesr,bonel)
    elseif frame % 40 == 13 then
      local boner = SetDefault('attack/bonev90',Arena.width/2-5,Arena.height/2-45)
      local bonel = SetDefault('attack/bonev90',-Arena.width/2+5,Arena.height/2-45)
      table.insert(bonesl,boner)
      table.insert(bonesr,bonel)
    elseif frame % 40 == 16 then
      local boner = SetDefault('attack/bonev80',Arena.width/2-5,Arena.height/2-40)
      local bonel = SetDefault('attack/bonev80',-Arena.width/2+5,Arena.height/2-40)
      table.insert(bonesl,boner)
      table.insert(bonesr,bonel)
    elseif frame % 40 == 19 then
      local boner = SetDefault('attack/bonev70',Arena.width/2-5,Arena.height/2-35)
      local bonel = SetDefault('attack/bonev70',-Arena.width/2+5,Arena.height/2-35)
      table.insert(bonesl,boner)
      table.insert(bonesr,bonel)
    elseif frame % 40 == 21 then
      local boner = SetDefault('attack/bonev10',Arena.width/2-5,-Arena.height/2+5)
      local bonel = SetDefault('attack/bonev10',-Arena.width/2+5,-Arena.height/2+5)
      table.insert(bonesl,boner)
      table.insert(bonesr,bonel)
    elseif frame % 40 == 24 then
      local boner = SetDefault('attack/bonev20',Arena.width/2-5,-Arena.height/2+10)
      local bonel = SetDefault('attack/bonev20',-Arena.width/2+5,-Arena.height/2+10)
      table.insert(bonesl,boner)
      table.insert(bonesr,bonel)
    elseif frame % 40 == 27 then
      local boner = SetDefault('attack/bonev30',Arena.width/2-5,-Arena.height/2+15)
      local bonel = SetDefault('attack/bonev30',-Arena.width/2+5,-Arena.height/2+15)
      table.insert(bonesl,boner)
      table.insert(bonesr,bonel)
    elseif frame % 40 == 30 then
      local boner = SetDefault('attack/bonev40',Arena.width/2-5,-50)
      local bonel = SetDefault('attack/bonev40',-Arena.width/2+5,-50)
      table.insert(bonesl,boner)
      table.insert(bonesr,bonel)
    elseif frame % 40 == 33 then
      local boner = SetDefault('attack/bonev30',Arena.width/2-5,-Arena.height/2+15)
      local bonel = SetDefault('attack/bonev30',-Arena.width/2+5,-Arena.height/2+15)
      table.insert(bonesl,boner)
      table.insert(bonesr,bonel)
    elseif frame % 40 == 36 then
      local boner = SetDefault('attack/bonev20',Arena.width/2-5,-Arena.height/2+10)
      local bonel = SetDefault('attack/bonev20',-Arena.width/2+5,-Arena.height/2+10)
      table.insert(bonesl,boner)
      table.insert(bonesr,bonel)
    elseif frame % 40 == 39 then
      local boner = SetDefault('attack/bonev10',Arena.width/2-5,-Arena.height/2+5)
      local bonel = SetDefault('attack/bonev10',-Arena.width/2+5,-Arena.height/2+5)
      table.insert(bonesl,boner)
      table.insert(bonesr,bonel)
    end
  end

  for i=1,#bonesl do
    if bonesl[i].isactive then
      bonesl[i].Move(-6,0)
      if bonesl[i].x <= -Arena.width/2 then
        bonesl[i].Remove()
      end
    end
  end

  for i=1,#bonesr do
    if bonesr[i].isactive then
      bonesr[i].Move(6,0)
      if bonesr[i].x >= Arena.width/2 then
        bonesr[i].Remove()
      end
    end
  end

  if frame >= 530 then
    if frame % 10 == 0 and frame <= 580 then
      local knifel = SetNotime('knifel',320,-Arena.height/2+10+20*((frame/10)-53))
      local knifer = SetNotime('knifer',-320,-Arena.height/2+10+20*((frame/10)-53))
      table.insert(knivesl,knifel)
      table.insert(knivesr,knifer)
    end
  end

  for i=1,#knivesl do
    if knivesl[i].isactive then
      knivesl[i].Move(-8,0)
      if knivesl[i].absx <= 0 then
        knivesl[i].Remove()
      end
    end
  end

  for i=1,#knivesr do
    if knivesr[i].isactive then
      knivesr[i].Move(8,0)
      if knivesr[i].absx >= 640 then
        knivesr[i].Remove()
      end
    end
  end

  if Player.y >= 0 and frame >= 550 and blue ~= nil then
    blue = nil
    Audio.PlaySound('change')
    Player.SetControlOverride(false)
    Player.sprite.color = {255,0,0}
  end

  if frame == 610 then
    Audio.PlaySound('BeginBattle1')
    warnbox = SetSprite("attack/warnbox10",0,Arena.height/2-20)
  end

  if frame == 640 then
    warnbox.Remove()
    for i=1,20 do
      local bone = SetDefault("attack/bonev10",-Arena.width/2+5+10*(i-1),Arena.height/2-5)
      bone.sprite.rotation = 180
      table.insert(bones,bone)
    end
  end

  if frame == 642 then
    for i=1,#bones do
      bones[i].sprite.Set('attack/bonev20')
      bones[i].Move(0,-5)
    end
  end

  if frame == 644 then
    for i=1,#bones do
      bones[i].sprite.Set('attack/bonev30')
      bones[i].Move(0,-5)
    end
  end

  if frame == 646 then
    for i=1,#bones do
      bones[i].sprite.Set('attack/bonev40')
      bones[i].Move(0,-5)
    end
  end

  if frame >= 650 then
    if frame % 10 == 0 and frame <= 690 then
      local knifel = SetNotime('knifel',320,Arena.height/2-50-20*((frame/10)-65))
      local knifer = SetNotime('knifer',-320,Arena.height/2-50-20*((frame/10)-65))
      table.insert(knivesl,knifel)
      table.insert(knivesr,knifer)
    end
  end

  if frame == 715 then
    EndWave()
  end
end

function OnHit(bullet)
  Hit(bullet)
end