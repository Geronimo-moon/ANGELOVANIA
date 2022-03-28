---@diagnostic disable: undefined-global, lowercase-global, undefined-field
music = "mus_aph" --デフォルトのBGMをA.U.T.O.P.H.B.I.Aにする

encountertext = "[font:det_jp]もうひとりのてんしが\rゆくてをはばんだ!"

nextwaves = {"opening"} --次の攻撃（カスタムも可）
wavetimer = 30.0 --攻撃時間
arenasize = {155, 130} --攻撃枠のサイズ

japanese = true
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
"[voice:v_sans][waitall:2][font:det_jp_mini][color:ffffff]おい,ガキんちょ. \nあきらめるには　はやすぎるぜ?",
"[voice:v_sans][waitall:2][font:det_jp_mini][music:stop][color:ff0000]なんてったって まだ\nオマエのタマシイを もらってないからな!",
} --死亡時のテキスト

Inventory.AddCustomItems({"[font:det_jp_mini][color:ffffff]ラザニア","[font:det_jp_mini][color:ffffff]ちゃば","[font:det_jp_mini][color:ffffff]ゆきだるまのかけら","[font:det_jp_mini][color:ffffff]レジェンドヒーロー","[font:det_jp_mini][color:ffffff]フェイスステーキ"},{0,0,0,0,0})
Inventory.SetInventory({"[font:det_jp_mini][color:ffffff]ラザニア","[font:det_jp_mini][color:ffffff]ゆきだるまのかけら","[font:det_jp_mini][color:ffffff]ゆきだるまのかけら","[font:det_jp_mini][color:ffffff]ゆきだるまのかけら","[font:det_jp_mini][color:ffffff]ちゃば","[font:det_jp_mini][color:ffffff]フェイスステーキ","[font:det_jp_mini][color:ffffff]レジェンドヒーロー","[font:det_jp_mini][color:ffffff]レジェンドヒーロー"})



if windows then
  Misc.WindowName = "A.N.G.E.L.O.V.A.N.I.A -Unofficial Storyfell Chara fight"
end

function EncounterStarting()
  Audio.Stop()
  State("ENEMYDIALOGUE")
end

function Update()
  -- デバッグモードの設定
  if Input.GetKey('S')~=0 and Input.GetKey('U')~=0 and Input.GetKey('D')~=0 and Input.GetKey('O')~=0 then
    debugging = true
    Player.name = "DEBUG"
  end

  if debugging then
    if Input.GetKey('Delete')~=0 then
      debugging = false
      Player.name = "Shifty"
    end
    if GetCurrentState() == "DEFENDING" and Input.GetKey('J')~=0 then
      State("ACTIONSELECT")
    end
    if GetCurrentState() == "ENEMYDIALOGUE" and Input.GetKey('K')~=0 then
      State("DEFENDING")
    end
  end

  -- noobモードの設定
  if not debugging and Input.GetKey('N')~=0 then
    noob = true
  end
  if noob and Input.GetKey('M')~=0 then
    noob = false
  end

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

  if id == '[FONT:DET_JP_MINI][COLOR:FFFFFF]ラザニア' then
    Player.Heal(99)
    BattleDialog({"[font:det_jp]パピルスのラザニアをたべた.\nHPがぜんかいふくした."})
    enemies[1].SetVar("currentdialogue",{"[font:det_jp_mini]ラザニア...\nパピルスの\nとくいりょうりだった.","[font:det_jp_mini][color:ff0000][effect:rotate][noskip][voice:v_floweymad]かれにたいして\nなにも\nおもわないのか?"})
  elseif id == '[FONT:DET_JP_MINI][COLOR:FFFFFF]ちゃば' then
    Player.Heal(90)
    enemies[1].SetVar("currentdialogue",{"[font:det_jp_mini]そのちゃば...\nアズゴアのラボに\nあったものだな?","[font:det_jp_mini][color:ff0000][effect:rotate][noskip][voice:v_floweymad]かれをころした\nそのあとでも,\nおいしく\nかんじるかい?[font:monster]=)"})
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

  -- ハードモードはアイテム禁止
  -- BattleDialog({"[font:det_jp][color:ff0000]これはつかうにあたいしない.\nぼくたちのきずは ちかのものじゃ\rなおせないだろうさ.","[font:det_jp]あなたは".. name .."[font:det_jp]をつかおうとした.\nが、とつぜん　\rあなたはそれをほうりなげた。"})
end

function HandleSpare()
	State("ENEMYDIALOGUE")
  nextwaves = {"default"}
end