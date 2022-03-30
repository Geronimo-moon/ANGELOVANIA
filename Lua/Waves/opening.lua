---@diagnostic disable: undefined-global, lowercase-global
Arena.ResizeImmediate(155,130)
require 'Libraries.deadForce'
require 'Libraries.bulletType'
require 'Libraries.hsvToRgb'

screen999 = nil
deathtime = nil
died = false

frame = 0
dirs = {nil,nil}
cuts1 = {nil,nil}
warns1 = {nil,nil,nil,nil,nil,nil,nil,nil}
cuts2 = {nil,nil,nil,nil,nil,nil,nil,nil}
knives = {}
warns3 = {nil,nil,nil,nil,nil,nil,nil,nil}
cuts3 = {nil,nil,nil,nil,nil,nil,nil,nil}
warns4 = {nil,nil,nil,nil}
cuts4 = {nil,nil,nil,nil}
warns5 = {nil,nil,nil,nil,nil,nil,nil,nil}
cuts5 = {nil,nil,nil,nil,nil,nil,nil,nil}
warns6 = {nil,nil,nil,nil}
cuts6 = {nil,nil,nil,nil}

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

    if frame == 50 then
      local warn1 = SetSprite("slash/emerb",0,Arena.height/2-15)
      local warn2 = SetSprite("slash/emerb",0,-Arena.height/2+15)
      local warn3 = SetSprite("slash/emerv",Arena.width/2-15,0)
      local warn4 = SetSprite("slash/emerv",-Arena.width/2+15,0)
      Audio.PlaySound("thunder")
      warns1[1]=warn1
      warns1[2]=warn2
      warns1[3]=warn3
      warns1[4]=warn4
    end

    if warns1[1] ~= nil then
      for i=1,4 do
        warns1[i].sprite.color = hsvToRgb(60-(frame-50)*2,255,255)
        if frame == 80 then
          warns1[i].Remove()
          warns1[i] = nil
        end
      end
    end

    if frame == 60 then
      local warn5 = SetSprite("slash/emerbs",Arena.width/4-15,Arena.height/4-15)
      local warn6 = SetSprite("slash/emerbs",-Arena.width/4+15,-Arena.height/4+15)
      local warn7 = SetSprite("slash/emers",-Arena.width/4+15,Arena.height/4-15)
      local warn8 = SetSprite("slash/emers",Arena.width/4-15,-Arena.height/4+15)
      Audio.PlaySound("thunder")
      warns1[5]=warn5
      warns1[6]=warn6
      warns1[7]=warn7
      warns1[8]=warn8
    end

    if warns1[5] ~= nil then
      for i=5,8 do
        warns1[i].sprite.color = hsvToRgb(60-(frame-60)*2,255,255)
        if frame == 90 then
          warns1[i].Remove()
          warns1[i] = nil
        end
      end
    end

    if frame == 80 then
      local cut1 = SetDieForce("slash/slashb",0,Arena.height/2-15)
      local cut2 = SetDieForce("slash/slashb",0,-Arena.height/2+15)
      local cut3 = SetDieForce("slash/slashv",Arena.width/2-15,0)
      local cut4 = SetDieForce("slash/slashv",-Arena.width/2+15,0)

      cuts2[1]=cut1
      cuts2[2]=cut2
      cuts2[3]=cut3
      cuts2[4]=cut4
    end

    if cuts2[1] ~= nil then
      for i=1,4 do
        cuts2[i].sprite.alpha = cuts2[i].sprite.alpha - 0.1
        if cuts2[i].sprite.alpha == 0.2 then
          cuts2[i].SetVar("type","sprite")
        elseif cuts2[i].sprite.alpha == 0 then
          cuts2[i].Remove()
          cuts2[i] = nil
        end
      end
    end

    if frame == 90 then
      local cut5 = SetDieForce("slash/slashbs",Arena.width/4-15,Arena.height/4-15)
      local cut6 = SetDieForce("slash/slashbs",-Arena.width/4+15,-Arena.height/4+15)
      local cut7 = SetDieForce("slash/slashs",-Arena.width/4+15,Arena.height/4-15)
      local cut8 = SetDieForce("slash/slashs",Arena.width/4-15  ,-Arena.height/4+15)
      cut5.ppcollision = true
      cut6.ppcollision = true
      cut7.ppcollision = true
      cut8.ppcollision = true

      cuts2[5] = cut5
      cuts2[6] = cut6
      cuts2[7] = cut7
      cuts2[8] = cut8
    end

    if cuts2[5] ~= nil then
      for i=5,8 do
        cuts2[i].sprite.alpha = cuts2[i].sprite.alpha - 0.1
        if cuts2[i].sprite.alpha == 0.2 then
          cuts2[i].SetVar("type","sprite")
        elseif cuts2[i].sprite.alpha == 0 then
          cuts2[i].Remove()
          cuts2[i] = nil
        end
      end
    end

    if frame >= 80 and frame <= 240 then
      if frame % 10 == 0 then
        local knife = SetNotime("knifed",math.random(-Arena.width/2,Arena.width/2),Arena.height*2)
        knife.SetVar('spawn',frame)
        knife.ppcollision = true
        table.insert(knives,knife)
      end
    end

    for i=1,#knives do
      if knives[i].isactive then
        knives[i].Move(0,-7)
        if frame - knives[i].GetVar('spawn') >= 45 then
          knives[i].sprite.alpha = knives[i].sprite.alpha - 0.1
          if knives[i].sprite.alpha == 0 then
            knives[i].Remove()
          end
        end
      end
    end

    if frame == 280 then
      local warn1 = SetSprite("slash/emerb",0,Arena.height/2-15)
      local warn2 = SetSprite("slash/emerb",0,-Arena.height/2+15)
      local warn3 = SetSprite("slash/emerv",-Arena.width/2+40,0)
      local warn4 = SetSprite("slash/emerv",Arena.width/2-40,0)
      local warn5 = SetSprite("slash/emerb",0,Arena.height/2-35)
      local warn6 = SetSprite("slash/emerb",0,-Arena.height/2+35)
      local warn7 = SetSprite("slash/emerv",-Arena.width/2+10,0)
      local warn8 = SetSprite("slash/emerv",Arena.width/2-10,0)
      Audio.PlaySound("thunder")
      warns3[1]=warn1
      warns3[2]=warn2
      warns3[3]=warn3
      warns3[4]=warn4
      warns3[5]=warn5
      warns3[6]=warn6
      warns3[7]=warn7
      warns3[8]=warn8
    end

    if warns3[1] ~= nil then
      for i=1,8 do
        warns3[i].sprite.color = hsvToRgb(60-(frame-280)*2,255,255)
        if frame == 310 then
          warns3[i].Remove()
          warns3[i] = nil
        end
      end
    end

    if frame == 310 then
      local cut1 = SetDieForce("slash/slashb",0,Arena.height/2-15)
      local cut2 = SetDieForce("slash/slashb",0,-Arena.height/2+15)
      local cut3 = SetDieForce("slash/slashv",-Arena.width/2+40,0)
      local cut4 = SetDieForce("slash/slashv",Arena.width/2-40,0)
      local cut5 = SetDieForce("slash/slashb",0,Arena.height/2-35)
      local cut6 = SetDieForce("slash/slashb",0,-Arena.height/2+35)
      local cut7 = SetDieForce("slash/slashv",-Arena.width/2+10,0)
      local cut8 = SetDieForce("slash/slashv",Arena.width/2-10,0)

      cuts3[1] = cut1
      cuts3[2] = cut2
      cuts3[3] = cut3
      cuts3[4] = cut4
      cuts3[5] = cut5
      cuts3[6] = cut6
      cuts3[7] = cut7
      cuts3[8] = cut8
    end

    if cuts3[1] ~= nil then
      for i=1,8 do
        cuts3[i].sprite.alpha = cuts3[i].sprite.alpha - 0.1
        if cuts3[i].sprite.alpha == 0.2 then
          cuts3[i].SetVar("type","sprite")
        elseif cuts3[i].sprite.alpha == 0 then
          cuts3[i].Remove()
          cuts3[i] = nil
        end
      end
    end

    if frame == 330 then
      local warn1 = SetSprite("slash/emerbs",-10,-10)
      local warn2 = SetSprite("slash/emers",10,-10)
      local warn3 = SetSprite("slash/emerbs",10,10)
      local warn4 = SetSprite("slash/emers",-10,10)
      Audio.PlaySound("thunder")
      warns4[1]=warn1
      warns4[2]=warn2
      warns4[3]=warn3
      warns4[4]=warn4
    end

    if warns4[1] ~= nil then
      for i=1,4 do
        warns4[i].sprite.color = hsvToRgb(60-(frame-330)*2,255,255)
        if frame == 360 then
          warns4[i].Remove()
          warns4[i] = nil
        end
      end
    end

    if frame == 360 then
      local cut1 = SetDieForce("slash/slashbs",-10,-10)
      local cut2 = SetDieForce("slash/slashs",10,-10)
      local cut3 = SetDieForce("slash/slashbs",10,10)
      local cut4 = SetDieForce("slash/slashs",-10,10)
      cut1.ppcollision = true
      cut2.ppcollision = true
      cut3.ppcollision = true
      cut4.ppcollision = true
      cuts4[1] = cut1
      cuts4[2] = cut2
      cuts4[3] = cut3
      cuts4[4] = cut4
    end

    if cuts4[1] ~= nil then
      for i=1,4 do
        cuts4[i].sprite.alpha = cuts4[i].sprite.alpha - 0.1
        if cuts4[i].sprite.alpha == 0.2 then
          cuts4[i].SetVar("type","sprite")
        elseif cuts4[i].sprite.alpha == 0 then
          cuts4[i].Remove()
          cuts4[i] = nil
        end
      end
    end

    if frame == 380 then
      local warn1 = SetSprite("slash/emerb",0,Arena.height/2-15)
      local warn2 = SetSprite("slash/emerb",0,-Arena.height/2+15)
      local warn3 = SetSprite("slash/emerv",-Arena.width/2+40,0)
      local warn4 = SetSprite("slash/emerv",Arena.width/2-40,0)
      local warn5 = SetSprite("slash/emerb",0,Arena.height/2-35)
      local warn6 = SetSprite("slash/emerb",0,-Arena.height/2+35)
      local warn7 = SetSprite("slash/emerv",-Arena.width/2+10,0)
      local warn8 = SetSprite("slash/emerv",Arena.width/2-10,0)
      Audio.PlaySound("thunder")
      warns5[1]=warn1
      warns5[2]=warn2
      warns5[3]=warn3
      warns5[4]=warn4
      warns5[5]=warn5
      warns5[6]=warn6
      warns5[7]=warn7
      warns5[8]=warn8
    end

    if warns5[1] ~= nil then
      for i=1,8 do
        warns5[i].sprite.color = hsvToRgb(60-(frame-380)*2,255,255)
        if frame == 410 then
          warns5[i].Remove()
          warns5[i] = nil
        end
      end
    end

    if frame == 410 then
      local cut1 = SetDieForce("slash/slashb",0,Arena.height/2-15)
      local cut2 = SetDieForce("slash/slashb",0,-Arena.height/2+15)
      local cut3 = SetDieForce("slash/slashv",-Arena.width/2+40,0)
      local cut4 = SetDieForce("slash/slashv",Arena.width/2-40,0)
      local cut5 = SetDieForce("slash/slashb",0,Arena.height/2-35)
      local cut6 = SetDieForce("slash/slashb",0,-Arena.height/2+35)
      local cut7 = SetDieForce("slash/slashv",-Arena.width/2+10,0)
      local cut8 = SetDieForce("slash/slashv",Arena.width/2-10,0)

      cuts5[1] = cut1
      cuts5[2] = cut2
      cuts5[3] = cut3
      cuts5[4] = cut4
      cuts5[5] = cut5
      cuts5[6] = cut6
      cuts5[7] = cut7
      cuts5[8] = cut8
    end

    if cuts5[1] ~= nil then
      for i=1,8 do
        cuts5[i].sprite.alpha = cuts5[i].sprite.alpha - 0.1
        if cuts5[i].sprite.alpha == 0.2 then
          cuts5[i].SetVar("type","sprite")
        elseif cuts5[i].sprite.alpha == 0 then
          cuts5[i].Remove()
          cuts5[i] = nil
        end
      end
    end

    if frame == 430 then
      local warn1 = SetSprite("slash/emerb",0,Arena.height/2-30)
      local warn2 = SetSprite("slash/emerb",0,-Arena.height/2+30)
      local warn3 = SetSprite("slash/emerb",0,11)
      local warn4 = SetSprite("slash/emerb",0,-11)
      Audio.PlaySound("thunder")
      warns6[1]=warn1
      warns6[2]=warn2
      warns6[3]=warn3
      warns6[4]=warn4 
    end

    if warns6[1] ~= nil then
      for i=1,4 do
        warns6[i].sprite.color = hsvToRgb(60-(frame-430)*2,255,255)
        if frame == 460 then
          warns6[i].Remove()
          warns6[i] = nil
        end
      end
    end

    if frame == 460 then
      local cut1 = SetDieForce("slash/slashb",0,Arena.height/2-30)
      local cut2 = SetDieForce("slash/slashb",0,-Arena.height/2+30)
      local cut3 = SetDieForce("slash/slashb",0,11)
      local cut4 = SetDieForce("slash/slashb",0,-11)

      cuts6[1] = cut1
      cuts6[2] = cut2
      cuts6[3] = cut3
      cuts6[4] = cut4
    end

    if cuts6[1] ~= nil then
      for i=1,4 do
        cuts6[i].sprite.alpha = cuts6[i].sprite.alpha - 0.1
        if cuts6[i].sprite.alpha == 0.2 then
          cuts6[i].SetVar("type","sprite")
        elseif cuts6[i].sprite.alpha == 0 then
          cuts6[i].Remove()
          cuts6[i] = nil
        end
      end
    end

  end

  -- 即死を食らっている場合999..を表示して殺す
  if deathtime ~= nil then
    KillCount(frame,deathtime,screen999)
  end

  if frame == 500 and not died then
    EndWave()
    local enm = Encounter.GetVar("enemies")
    if Encounter.GetVar('japanese') then
      enm[1].SetVar("currentdialogue",{"[font:det_jp_mini]いきのこったようで\nなによりだ.","[font:det_jp_mini][color:ff0000][effect:rotate][noskip][voice:v_floweymad][func:CharaHead,chara/madhead]もっと\nくるしめてから\nころしてあげるよ!","[func:State,ACTIONSELECT][noskip][func:CharaHead,chara/head]"})
    else
      enm[1].SetVar("currentdialogue",{"I'm glad that \nyou're still alive.","[color:ff0000][effect:rotate][noskip][voice:v_floweymad][func:CharaHead,chara/madhead]I CAN MAKE YOU \nSUFFER AS HARD\nAS I CAN!","[func:State,ACTIONSELECT][noskip][func:CharaHead,chara/head]"})
    end
    
    -- 
    State("ENEMYDIALOGUE")
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

