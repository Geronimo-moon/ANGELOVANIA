require 'Animations/chara'
require 'Animations/mode'
music = "mus_menu"

playerskipdocommand = true

if Misc.FileExists('User/savedata') then
  japanese = ("true" == Misc.OpenFile('User/savedata','r').ReadLine(14))
else
  japanese = false
end

debugging = false
noob = false
ez = false
extreme = false

function SetLang()
  if japanese then
    encountertext = "[font:det_jp]もうひとりのてんしが\rゆくてをはばんだ!"
  else
    encountertext = "Another ANGEL blocked your way!"
  end

  if japanese then
    deathtext = {
      "[voice:v_sans][waitall:2][font:det_jp_mini][color:ffffff]おい,ガキんちょ. \nあきらめるには　はやすぎるぜ?",
      "[voice:v_sans][waitall:2][font:det_jp_mini][music:stop][color:ff0000]なんてったって まだ\nオマエのタマシイを もらってないからな!",
      } --死亡時のテキスト

    Inventory.AddCustomItems({"[font:det_jp_mini][color:ffffff]ラザニア","[font:det_jp_mini][color:ffffff]ちゃば","[font:det_jp_mini][color:ffffff]ゆきだるまのかけら","[font:det_jp_mini][color:ffffff]レジェンドヒーロー","[font:det_jp_mini][color:ffffff]フェイスステーキ"},{0,0,0,0,0})

    if Misc.FileExists('User/savedata') then
      local save = Misc.OpenFile('User/savedata','r')
      Player.hp = tonumber(save.ReadLine(2))
      local items = tonumber(save.ReadLine(4))
      local itemlist = {}
      for i=1,items do
        local item = save.ReadLine(4+i)
        if item == "Lasagna" then
          item = "[font:det_jp_mini][color:ffffff]ラザニア"
        elseif item == "Tea" then
          item = "[font:det_jp_mini][color:ffffff]ちゃば"
        elseif item == "SnowPiece" then
          item = "[font:det_jp_mini][color:ffffff]ゆきだるまのかけら"
        elseif item == "L. Hero" then
          item = "[font:det_jp_mini][color:ffffff]レジェンドヒーロー"
        elseif item == "Steak" then
          item = "[font:det_jp_mini][color:ffffff]フェイスステーキ"
        end
        table.insert(itemlist,item)
      end
      noob = ("true" == save.ReadLine(13))
      ez = ("true" == save.ReadLine(16))
      extreme = ("true" == save.ReadLine(17))
      Inventory.SetInventory(itemlist)
    else
      Inventory.SetInventory({"[font:det_jp_mini][color:ffffff]ラザニア","[font:det_jp_mini][color:ffffff]ゆきだるまのかけら","[font:det_jp_mini][color:ffffff]ゆきだるまのかけら","[font:det_jp_mini][color:ffffff]ゆきだるまのかけら","[font:det_jp_mini][color:ffffff]ちゃば","[font:det_jp_mini][color:ffffff]フェイスステーキ","[font:det_jp_mini][color:ffffff]レジェンドヒーロー","[font:det_jp_mini][color:ffffff]レジェンドヒーロー"})
    end
  else
    deathtext = {
      "[voice:v_sans][waitall:2][font:sans][color:ffffff]hey, kid, you cannot \ngive up just yet.",
      "[voice:v_sans][waitall:2][font:sans][music:stop][color:ff0000]'cuz i haven't get your soul yet!",
      } --死亡時のテキスト

    Inventory.AddCustomItems({"Lasagna","Tea","SnowPiece","L. Hero","Steak"},{0,0,0,0,0})

    if Misc.FileExists('User/savedata') then
      local save = Misc.OpenFile('User/savedata','r')
      Player.hp = tonumber(save.ReadLine(2))
      local items = tonumber(save.ReadLine(4))
      local itemlist = {}
      for i=1,items do
        local item = save.ReadLine(4+i)
        if item == "[font:det_jp_mini][color:ffffff]ラザニア" then
          item = "Lasagna"
        elseif item == "[font:det_jp_mini][color:ffffff]ちゃば" then
          item = "Tea"
        elseif item == "[font:det_jp_mini][color:ffffff]ゆきだるまのかけら" then
          item = "SnowPiece"
        elseif item == "[font:det_jp_mini][color:ffffff]レジェンドヒーロー" then
          item = "L. Hero"
        elseif item == "[font:det_jp_mini][color:ffffff]フェイスステーキ" then
          item = "Steak"
        end
        table.insert(itemlist,item)
      end
      noob = ("true" == save.ReadLine(13))
      ez = ("true" == save.ReadLine(16))
      extreme = ("true" == save.ReadLine(17))
      Inventory.SetInventory(itemlist)
    else
      Inventory.SetInventory({"Lasagna","SnowPiece","SnowPiece","SnowPiece","Tea","Steak","L. Hero","L. Hero"})
    end
  end
end

nextwaves = {"title"} --次の攻撃（カスタムも可）
wavetimer = math.huge --攻撃時間
arenasize = {155, 130} --攻撃枠のサイズ

enemies = { "chara" } --敵のファイル名
enemypositions = { --画面上の敵の位置(x,y)
  {-20, 10},
}

flee = false --Freeオプションを表示しない

--Playerのステータス
Player.lv = 19
Player.name = 'Shifty'
Player.maxhp = 92
Player.hp = Player.maxhp

SetLang()

if windows then
  Misc.WindowName = "A.N.G.E.L.O.V.A.N.I.A -Unofficial Storyfell Chara Fight"
end

function EncounterStarting()
  Audio.LoadFile('mus_aph')
  Audio.LoadFile('mus_ang')
  Audio.LoadFile('mus_azi')
  Audio.LoadFile('mus_first')
  Audio.Stop()
  Audio.LoadFile('mus_menu')
  InitChara()
  if ez then
    Player.maxhp = 150
    Player.hp = 150
  elseif extreme then
    Player.maxhp = 1
    Player.hp = 1
  end
  if not Misc.FileExists('User/savedata') then
    State("DEFENDING")
  else
    encountertext = RandomEncounterText()
    if GetGlobal('phase') ==1 then
      Audio.LoadFile("mus_aph")
    elseif GetGlobal('phase') ==1.5 then
      Audio.LoadFile("spare")
      if japanese then
        encountertext = "[font:det_jp]キャラは\rにがしてくれるようだ."
      else
        encountertext = "Chara is sparing you."
      end
    elseif GetGlobal('phase') ==2 then
      Audio.LoadFile("mus_ang")
      InitKarma()
    end
  end
  SetGlobal('currentPlayer',{x=Player.x,y=Player.y})
  SetGlobal('isMoving',false)
end

function Update()
  -- デバッグモードの設定
  if not (noob or ez or extreme) and Input.GetKey('S')~=0 and Input.GetKey('U')~=0 and Input.GetKey('D')~=0 and Input.GetKey('O')~=0 then
    debugging = true
    Player.name = "DEBUG"
    SetMode('debug')
  end

  if debugging then
    SetMode('debug')
    if Input.GetKey('Delete')~=0 then
      debugging = false
      Player.name = "Shifty"
      SetMode('none')
    end
    if GetCurrentState() == "DEFENDING" and Input.GetKey('J')~=0 then
      State("ACTIONSELECT")
    end
    if GetCurrentState() == "ENEMYDIALOGUE" and Input.GetKey('K')~=0 then
      State("DEFENDING")
    end
  elseif noob then
    SetMode('noob')
  elseif ez then
    SetMode('ez')
  elseif extreme then
    SetMode('extreme')
  else
    SetMode('none')
  end

  CharaAnime()
  ModeAnime()
  if Karma ~= nil then
    Karma.Update()
  end

  if GetGlobal("currentPlayer").x ~= Player.x or GetGlobal("currentPlayer").y ~= Player.y then
    SetGlobal('isMoving',true)
    SetGlobal('currentPlayer',{x=Player.x,y=Player.y})
  else
    SetGlobal('isMoving',false)
  end
end

function DefenseEnding()
  if noob then
    Player.Heal(10)
  end
  if ez then
    Player.Heal(50)
  end
  if enemies[1].GetVar('turn') >= 1 then
    encountertext = RandomEncounterText()
    if GetGlobal('charaSpare') then
      if japanese then
        encountertext = "[font:det_jp]キャラは\rにがしてくれるようだ."
      else
        encountertext = "Chara is sparing you."
      end
    end
  end
end

function HandleItem(id,position)
  nextwaves = {"default"}
  if GetGlobal('charaSpare') then
    nextwaves = {"21"}
  end
  -- アイテムの挙動
  local name = Inventory.GetItem(position)

  if japanese then
    if noob or ez then
      if id == '[FONT:DET_JP_MINI][COLOR:FFFFFF]ラザニア' then
        Player.Heal(99)
        BattleDialog({"[font:det_jp]パピルスのラザニアをたべた.\nHPがぜんかいふくした."})
        enemies[1].SetVar("currentdialogue",{"[font:det_jp_mini]ラザニア...\nパピルスの\nとくいりょうりだった.","[font:det_jp_mini][color:ff0000][effect:rotate][noskip][voice:v_floweymad]かれにたいして\nなにも\nおもわないのか?"})
      elseif id == '[FONT:DET_JP_MINI][COLOR:FFFFFF]ちゃば' then
        Player.Heal(90)
        enemies[1].SetVar("currentdialogue",{"[font:det_jp_mini]そのちゃば...\nアズゴアのラボに\nあったものだな?","[font:det_jp_mini][color:ff0000][effect:rotate][noskip][voice:v_floweymad]かれをころした\nそのあとでも,\nおいしく\nかんじるかい?[font:monster][color:ff0000]=)"})
        if Player.hp < Player.maxhp then
          BattleDialog({"[font:det_jp]そのままたべたほうがおいしい. \n90HP かいふくした."})
        else
          BattleDialog({"[font:det_jp]そのままたべたほうがおいしい. \nHPがぜんかいふくした."})
        end
      elseif id == '[FONT:DET_JP_MINI][COLOR:FFFFFF]ゆきだるまのかけら' then
        Player.Heal(45)
        if Player.hp < Player.maxhp then 
          BattleDialog({"[font:det_jp]ゆきだるまのかけらをたべた. \n45HP かいふくした."})
        else
          BattleDialog({"[font:det_jp]ゆきだるまのかけらをたべた. \nHPがぜんかいふくした."})
        end
      elseif id == '[FONT:DET_JP_MINI][COLOR:FFFFFF]レジェンドヒーロー' then
        Player.Heal(40)
        if Player.hp < Player.maxhp then 
          BattleDialog({"[font:det_jp]レジェンドヒーローをたべた.","[font:det_jp]こうげきが4あがった! \n40HP かいふくした."})
        else
          BattleDialog({"[font:det_jp]レジェンドヒーローをたべた.","[font:det_jp]こうげきが4あがった! \nHPがぜんかいふくした."})
        end
      elseif id == "[FONT:DET_JP_MINI][COLOR:FFFFFF]フェイスステーキ" then
        Player.Heal(60)
        if Player.hp < Player.maxhp then 
          BattleDialog({"[font:det_jp]フェイスステーキをたべた. \n60HP かいふくした."})
        else
          BattleDialog({"[font:det_jp]フェイスステーキをたべた. \nHPがぜんかいふくした."})
        end
      end
    else
      BattleDialog({"[font:det_jp][color:ff0000]これはつかうにあたいしない.\nぼくたちのきずは ちかのものじゃ\rなおせないだろうさ.","[font:det_jp]あなたは".. name .."[font:det_jp]をつかおうとした.\nが、とつぜん\rあなたはそれをほうりなげた。"})
    end
  else
    if noob or ez then
      if id == 'LASAGNA' then
        Player.Heal(99)
        BattleDialog({"You ate Papyrus's lasagna. \nYour HP maxed out."})
        enemies[1].SetVar("currentdialogue",{"Lasagna...\nThat was Papyrus's \nSpecialties...","[color:ff0000][effect:rotate][noskip][voice:v_floweymad]You REALLY \nfeel nothing for him, \nhuh?"})
      elseif id == 'TEA' then
        Player.Heal(90)
        if Player.hp < Player.maxhp then
          BattleDialog({"They're better dry. \nYou recovered 90 HP!"})
          enemies[1].SetVar("currentdialogue",{"That leaves...\nYou stole them from \nAsgore's lab,right?","[color:ff0000][effect:rotate][noskip][voice:v_floweymad]Does it tastes good\nafter you \nkilled him?=)"})
        else
          BattleDialog({"They're better dry. \nYour HP maxed out."})
          enemies[1].SetVar("currentdialogue",{"That leaves...\nYou stole them from \nAsgore's lab,right?","[color:ff0000][effect:rotate][noskip][voice:v_floweymad]Does it tastes good\nafter you \nkilled him?=)"})
        end
      elseif id == 'SNOWPIECE' then
        Player.Heal(45)
        if Player.hp < Player.maxhp then 
          BattleDialog({"You ate the Snowman Pieces. \nYou recovered 45 HP!"})
        else
          BattleDialog({"You ate the Snowman Pieces. \nYour HP maxed out."})
        end
      elseif id == 'L. HERO' then
        Player.Heal(40)
        if Player.hp < Player.maxhp then 
          BattleDialog({"You ate the Legendary Hero. \nYour ATTACK increased by 4! \nYou recovered 40 HP!"})
        else
          BattleDialog({"You ate the Legendary Hero. \nYour ATTACK increased by 4! \nYour HP maxed out."})
        end
      elseif id == "STEAK" then
        Player.Heal(60)
        if Player.hp < Player.maxhp then 
          BattleDialog({"You ate the Face Steak. \nYou recovered 60 HP!"})
        else
          BattleDialog({"You ate the Face Steak. \nYour HP maxed out."})
        end
      end
    else
      BattleDialog({"[color:ff0000]This doesn't deserve to use.\nOur wounds wouldn't be good \rwith underground's food.","You try to use ".. name .. "\rbut you suddenly throw it."})
    end
  end
end

function HandleSpare()
  if GetGlobal('charaSpare') then
    enemies[1].SetVar('currentdialogue',enemies[1].GetVar('messages').spare)
    State("ENEMYDIALOGUE")
  else
    State("ENEMYDIALOGUE")
    nextwaves = {"default"}
  end
end

function InitKarma()
  require 'Libraries/karma'
end