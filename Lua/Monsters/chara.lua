---@diagnostic disable: undefined-global, lowercase-global
comments = {"Chara laughed looking you're dodgeing.", "Chara doesn't looks tired."} --コメントのリスト
-- comments = {"[font:det_jp]キャラはあなたがよけるのをみてわらった.", "[font:det_jp]キャラはつかれたようにみえない."} --コメントのリスト

commands = {"Check","Pray"} --ACT時のコマンド
-- commands = {"[font:det_jp]ぶんせき","[font:det_jp]いのる"} --ACT時のコマンド

cancheck = false --falseの時デフォルトのCHECKを削除する

sprite = "chara_default" --スプライトの画像　
dialogbubble = "rightwide" --吹き出しの形
dialogueprefix = "" -- モンスターのテキストの初めに挿入
name = "Chara Dreemurr" --モンスターの名前
-- name = "[font:det_jp]キャラ ドリーマー"
hp = 2000
atk = 1
def = 99
xp = 49999
gold = 0

turn = 0 --攻撃された回数でターンを管理
prayed = 0 --回復回数の計測

randomdialogue = {"[next]"}

currentdialogue = {
  "Howdy.",
  "So, finally, \nyou accepted \nour motto.",
  "Why did you choose \nthat way now?",
  "Many other timelines,\nyou showed us \nawesome endings,\nwithout killing.",
  "That's true \nwe believed \nthe motto that \n'It's kill or be killed'.",
  "But...\nonce see that \npeaceful ending...",
  "*sigh*",
  "Yes, Rei...\nthey're angel.",
  "The angel \ngiving us a DEATH...",
  "Well, it's a\nterrible day outside.",
  "Birds are dying, \nflowers are withering, \ndusts are scattering...",
  "On days like these, \nANGELS like us...",
  "have a GREAT TIME.",
  "[color:ff0000][effect:rotate][noskip][voice:v_floweymad]THEN, LET'S GO, \nANOTHER KILLER!",
  "[func:State,DEFENDING][noskip]",
}

-- currentdialogue = {"Debugging.","[func:State,DEFENDING][func:Autophobia][noskip]"}

function HandleAttack(damage)
-- プレイヤーが攻撃したとき

  if damage == -1 then
    Encounter.SetVar("nextwaves",{"default"})
    currentdialogue = {"Hey, \nwhat are you doing?\nHit me \nif you're able."}
    -- currentdialogue = {"[font:det_jp_mini]なにをしているんだ?\n[font:det_jp_mini]あてられるか,\nためしてみなよ."}
  else
    turn = turn + 1
    --turnの値によってメッセージを変える
    if turn == 1 then
      Encounter.SetVar("nextwaves",{"1"})
      currentdialogue = {'Why do you \nget surprised?\nNo one would \nstand there \nand take it.'} --何かしたとき吹き出しに特別に表示されるテキスト
      -- currentdialogue = {'[font:det_jp_mini]なにを\nおどろいているんだい?\nわざわざくらうために\nつったってるやつなんて\nいないだろ?'} --何かしたとき吹き出しに特別に表示されるテキスト
    elseif turn == 2 then
      Encounter.SetVar("nextwaves",{"2"})
      currentdialogue = {'Always wondered \nwhy you can keep on\nbeing merciful \n for everyone.'} --何かしたとき吹き出しに特別に表示されるテキスト
      -- currentdialogue = {'[font:det_jp_mini]いつもおもってたんだ.\nなんできみは\nみんなにやさしく\nありつづけられるのかって.'} --何かしたとき吹き出しに特別に表示されるテキスト
    end
  end
end

function BeforeDamageCalculation()
  -- ダメージ計算の前にダメージを0にする
  SetDamage(0)
end

function HandleCustomCommand(command)
-- ACTのコマンドの動作
  Encounter.SetVar("nextwaves",{"default"})
  if command == "CHECK" then
    BattleDialog({"Chara Dreemurr  LV ?","She lived thanks to \rDreemurr family.\n[color:ff0000]Now, No one would protect her."})
    -- BattleDialog({"[font:det_jp]キャラ ドリーマー  LV ?","[font:det_jp]ドリーマーけのおかげで\rいきのびた しにぞこない.\n[color:ff0000]すでに,まもってくれる\rモンスターはいない."})
  elseif command == "PRAY" then
    if prayed == 0 then
      Player.Heal(20)
      BattleDialog({'You prayed. You recovered 20 HP.'})
      -- BattleDialog({'[font:det_jp]あなたはいのった. 20HP かいふくした.'})
    elseif prayed == 1 then
      Player.Heal(20)
      BattleDialog({'You prayed. You recovered 20 HP.'})
      -- BattleDialog({'[font:det_jp]あなたはいのった. 20HP かいふくした.'})
    elseif prayed == 2 then
      Player.Heal(40)
      BattleDialog({'You prayed. You recovered 40 HP.'})
      -- BattleDialog({'[font:det_jp]あなたはいのった. 40HP かいふくした.'})
    elseif prayed == 3 then
      Player.Heal(40)
      BattleDialog({'You prayed. You recovered 40 HP.'})
      -- BattleDialog({'[font:det_jp]あなたはいのった. 40HP かいふくした.'})
    elseif prayed == 4 then
      Player.Heal(60)
      BattleDialog({'You prayed. You recovered 60 HP.'})
      -- BattleDialog({'[font:det_jp]あなたはいのった. 60HP かいふくした.'})
    elseif prayed == 5 then
      Player.Heal(60)
      BattleDialog({'You prayed. You recovered 60 HP.'})
      -- BattleDialog({'[font:det_jp]あなたはいのった. 60HP かいふくした.'})
    elseif prayed == 6 then
      Player.Heal(80)
      BattleDialog({'You prayed. You recovered 80 HP.'})
      -- BattleDialog({'[font:det_jp]あなたはいのった. 80HP かいふくした.'})
    elseif prayed == 7 then
      Player.Heal(80)
      BattleDialog({'You prayed. You recovered 80 HP.'})
      -- BattleDialog({'[font:det_jp]あなたはいのった. 80HP かいふくした.'})
    elseif prayed == 8 then
      Player.Heal(99)
      BattleDialog({'You prayed. Your HP maxed out.'})
      -- BattleDialog({'[font:det_jp]あなたはいのった. 99HP かいふくした.'})
    elseif prayed >= 9 then
      BattleDialog({"[color:ff0000]That's enough! Prayed too much!","You tried to pray.\nBut no prayers left."})
      -- BattleDialog({'[font:det_jp][color:ff0000]たくさんだ!　\nもう　じゅうぶんいのっただろ!'},{"あなたはいのろうとした.\nが、すでにいのりはつきていた。"})
    end
    prayed = prayed + 1
  end
end

-- テキストコマンド用
function Autophobia()
  Audio.LoadFile('mus_aph')
end

function Angelovania()
  Audio.LoadFile('mus_ang')
end

function Azimuth()
  Audio.LoadFile('mus_azi')
end