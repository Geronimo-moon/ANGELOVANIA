require 'Animations.chara'
require 'Animations.mode'
music = "mus_first"

playerskipdocommand = true

encountertext = "Another ANGEL blocked your way!" --ナレーション

nextwaves = {"opening"} --次の攻撃（カスタムも可）
wavetimer = math.huge --攻撃時間
arenasize = {155, 130} --攻撃枠のサイズ

japanese = false
debugging = false
noob = false

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
  Inventory.SetInventory(itemlist)
else
  Inventory.SetInventory({"Lasagna","SnowPiece","SnowPiece","SnowPiece","Tea","Steak","L. Hero","L. Hero"})
end

if windows then
  Misc.WindowName = "A.N.G.E.L.O.V.A.N.I.A -Unofficial Storyfell Chara Fight"
end

function EncounterStarting()
  Audio.LoadFile('mus_aph')
  Audio.LoadFile('mus_ang')
  Audio.LoadFile('mus_azi')
  Audio.Stop()
  Audio.LoadFile('mus_first')
  InitChara()
  if not Misc.FileExists('User/savedata') then
    Audio.Pitch(0.2)
    State("ENEMYDIALOGUE")
  else
    encountertext = RandomEncounterText()
    Audio.LoadFile("mus_aph")
  end
end

function Update()
  -- デバッグモードの設定
  if not noob and Input.GetKey('S')~=0 and Input.GetKey('U')~=0 and Input.GetKey('D')~=0 and Input.GetKey('O')~=0 then
    debugging = true
    Player.name = "DEBUG"
    SetMode('debug')
  end

  if debugging then
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
  end

  -- noobモードの設定
  if (not debugging and Input.GetKey('N')~=0) or noob then
    noob = true
    SetMode('noob')
  end
  if noob and Input.GetKey('M')~=0 then
    noob = false
    SetMode('none')
  end

  CharaAnime()
  ModeAnime()
end

function DefenseEnding()
  if enemies[1].GetVar('turn') >= 1 then
    encountertext = RandomEncounterText()
  end
end

function HandleItem(id,position)
  nextwaves = {"default"}
  -- アイテムの挙動
  local name = Inventory.GetItem(position)

  if noob then
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

function HandleSpare()
	State("ENEMYDIALOGUE")
  nextwaves = {"default"}
end