---@diagnostic disable: undefined-global, lowercase-global, undefined-field
music = "mus_aph" --デフォルトのBGMをA.U.T.O.P.H.B.I.Aにする

encountertext = "Another ANGEL blocked your way!" --ナレーション
nextwaves = {"5"} --次の攻撃（カスタムも可）
wavetimer = 30.0 --攻撃時間
arenasize = {155, 130} --攻撃枠のサイズ

japanese = false
debugging = false

enemies = { "chara" } --敵のファイル名
enemypositions = { --画面上の敵の位置(x,y)
  {-20, 10},
}

flee = false --Freeオプションを表示しない

--Playerのステータス
Player.lv = 19
Player.name = 'DEBUG'
Player.maxhp = 92
Player.hp = Player.maxhp

deathtext = {
"[voice:v_sans][waitall:2][font:sans][color:ffffff]hey, kid, you cannot \ngive up just yet.",
"[voice:v_sans][waitall:2][font:sans][music:stop][color:ff0000]'cuz i haven't get your soul yet!",
} --死亡時のテキスト

Inventory.AddCustomItems({"Lasagna","Tea","SnowPiece","L. Hero","Steak"},{0,0,0,0,0})
Inventory.SetInventory({"Lasagna","SnowPiece","SnowPiece","SnowPiece","Tea","Steak","L. Hero","L. Hero"})

if windows then
  Misc.WindowName = "A.N.G.E.L.O.V.A.N.I.A -Unofficial Storyfell Chara Fight"
end

function EncounterStarting()
  Audio.Stop()
  State("ENEMYDIALOGUE")
end

function HandleItem(id,position)
  nextwaves = {"default"}
  -- アイテムの挙動
  local name = Inventory.GetItem(position)

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
    Audio.PlaySound("LegHero")
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

  -- ハードモードはアイテム禁止
  -- BattleDialog({"[color:ff0000]This isn't deserve to use for you.\nOur wounds wouldn't be good with underground's food.","You try to use".. name .. "\r but you suddenly throw it."})
  -- BattleDialog({"[font:det_jp][color:ff0000]これはつかうにあたいしない.\nぼくたちのきずは ちかのものじゃ\rなおせないだろうさ.","[font:det_jp]あなたは".. name .."[font:det_jp]をつかおうとした.\nが、とつぜん　\rあなたはそれをほうりなげた。"})
end