require 'Libraries/deadForce'
require 'Libraries/bulletType'
require 'Libraries/hsvToRgb'

local screen999 = nil
local deathtime = nil
local died = false

local frame = 0
local dirs = {nil,nil}
local cuts1 = {nil,nil}

Arena.ResizeImmediate(18,18)

function Update()
  frame = frame + 1

  if not died then
    if frame == 1 then
    -- 最初のフレームで十字に切りかかる
      local dir1 = SetSprite("slash/0",0,0)
      local dir2 = SetSprite("slash/0",0,0)
      dir2.sprite.rotation = 90
      Audio.PlaySound("slice")
      dirs[1]=dir1
      dirs[2]=dir2
      Audio.PlaySound("thunder")
    end

    if dirs[1] ~= nil then
    -- 5フレームごとに斬撃のアニメーションを進める
      if frame == 5 then
        dirs[1].sprite.Set("slash/1")
        dirs[2].sprite.Set("slash/1")
      elseif frame == 10 then
        dirs[1].sprite.Set("slash/2")
        dirs[2].sprite.Set("slash/2")
      elseif frame == 15 then
        dirs[1].sprite.Set("slash/3")
        dirs[2].sprite.Set("slash/3")
      elseif frame == 20 then
        dirs[1].sprite.Set("slash/4")
        dirs[2].sprite.Set("slash/4")
      elseif frame == 25 then
        dirs[1].sprite.Set("slash/5")
        dirs[2].sprite.Set("slash/5")
      elseif frame == 30 then
        dirs[1].sprite.Set("slash/6")
        dirs[2].sprite.Set("slash/6")
      elseif frame == 35 then
        for i=1,#dirs do
          dirs[i].Remove()
          dirs[i] = nil
        end
      end
    end

    if frame == 30 then
      -- 十字に斬る
      local cut1 = SetDieForce("slash/slashv",0,0)
      local cut2 = SetDieForce("slash/slashb",0,0)
      cuts1[1] = cut1
      cuts1[2]=cut2
      if (die and not died) or Encounter.GetVar('debugging') then
        died = true
        local list = KillForce(frame)
        screen999 = list[1]
        deathtime = list[2]
      end
    end

    if cuts1[1] ~= nil then
      for i=1,#cuts1 do
        cuts1[i].sprite.alpha = cuts1[i].sprite.alpha - 0.1
        if cuts1[i].sprite.alpha == 0.2 then
          cuts1[i].SetVar("type","sprite")
        elseif cuts1[i].sprite.alpha == 0 then
          cuts1[i].Remove()
          cuts1[i] = nil
        end
      end
    end
  end

  -- 即死を食らっている場合999..を表示して殺す
  if deathtime ~= nil then
    KillCount(frame,deathtime,screen999)
  end
end

function OnHit(bullet)
  local die = Hit(bullet)
  -- 即死を食らっている場合999...を生成
  if die and not died then
    died = true
    local list = KillForce(frame)
    screen999 = list[1]
    deathtime = list[2]
  end
end

