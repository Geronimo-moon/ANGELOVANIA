---@diagnostic disable: undefined-global, lowercase-global

messages = {}

if Encounter.GetVar("japanese") == true then
  messages = {
    comments = {"[font:det_jp]キャラは\nあなたがよけるのをみてわらった.", "[font:det_jp]キャラは\nつかれたようにみえない.", "[font:det_jp][color:ff0000]なにかがかのじょに\rちからをかしているようだ."},
    commands = {"[font:det_jp]ぶんせき","[font:det_jp]いのる"},
    name = "[font:det_jp]キャラ ドリーマー",
    check = {"[font:det_jp]キャラ ドリーマー  LV ?\nドリーマーけのおかげで\rいきのびた しにぞこない.","[font:det_jp][color:ff0000]すでに,まもってくれる\rモンスターはいない."},
    currentdialogue = {
      "[font:det_jp_mini]ハロー.",
      "[font:det_jp_mini]けっきょく,\nボクらのルールに\nしたがうことに\nしたんだね.",
      "[font:det_jp_mini]いまさら,\nどうしてだい?",
      "[font:det_jp_mini]たくさんのじかんじくで,\nだれもころさずに\nさいこうの\nエンディングに\nたどりついたのに.",
      "[font:det_jp_mini]'ころすか、ころされるか.'\nたしかにそう\nいいつづけてきたさ.",
      "[font:det_jp_mini]でも...\nあんなエンディングを\nしってしまったら...\nねぇ.",
      "[font:det_jp_mini](ためいき)",
      "[font:det_jp_mini]そうだね,アズ.\nこのニンゲンが\n'てんし'だったんだ.",
      "[font:det_jp_mini]てんしは\nてんしでも\n'し'をもたらす\n'てんし'だったけど.",
      "[font:det_jp_mini]まぁいいか.\nところで,\nきょうは\nサイアクなひじゃないか?",
      "[font:det_jp_mini]とりはしんで,\nはながかれていき,\nまうのはちりばかり.",
      "[font:det_jp_mini]こんなひには,\nボクらのような\nにんげんは...",
      "[font:det_jp_mini]せいぜい\nたのしもうじゃないか",
      "[font:det_jp_mini][color:ff0000][effect:rotate][noskip][voice:v_floweymad]はじめようか,\nもうひとりの\nさつじんきさん?",
      "[func:State,DEFENDING][func:Autophobia][noskip]",
    },
    c0 = {"[font:det_jp_mini]なにをしているんだ?\n[font:det_jp_mini]あてられるか,\nためしてみなよ."},
    c1 = {'[font:det_jp_mini]なにを\nおどろいているんだい?\nわざわざくらうために\nつったってるやつなんて\nいないだろ?'},
    c2 = {'[font:det_jp_mini]いつもおもってたんだ.\nなんできみは\nみんなにやさしく\nありつづけられるのかって.'},
    c3 = {'[font:det_jp_mini]きみのような\nやさしいひとは\nはじめてだったんだ.','[font:det_jp_mini]ま,けっきょくきみも\nかれらとおなじだった\nみたいだけど.'},
    c4 = {'[font:det_jp_mini]でも,かんがえてみれば\nとうぜんか.','[font:det_jp_mini]ほんとうに\nやさしいひとは,\nリセットなんて\nしないだろうし.'},
    c5 = {'[font:det_jp_mini]そう,リセットだ.\nボクがしらないとでも\nおもったのかい?','[font:det_jp_mini]きみがじかんじくを\nすきかってに\nいじっていたこと.'},
    c6 = {'[font:det_jp_mini]きみがなんにんめかは\nしらないけど.\nでも,なんどころしても\nきみはやってくる.','[font:det_jp_mini]きみがいるかぎり,\nボクらに\nほんとうのへいわは\nおとずれないんだ.'}
  }
else
  messages = {
    comments = {"Chara laughed looking you're dodgeing.", "Chara doesn't looks tired.","[color:ff0000]It seems something is helping her."},
    commands = {"Check","Pray"},
    name = "Chara Dreemurr",
    check = {"Chara Dreemurr  LV ?\nShe survived this world\r thanks to Dreemurr family.","[color:ff0000]Now, No one would protect her."},
    currentdialogue = {
      "Howdy.",
      "So, finally, \nyou accepted \nour rule.",
      "Why did you choose \nthat way now?",
      "Many other timelines,\nyou showed us \nawesome endings,\nwithout killing.",
      "That's true \nwe believed \nthe motto that \n'It's kill or be killed'.",
      "But...\nonce see that \npeaceful ending...",
      "*sigh*",
      "Yes, Rei...\nthey're angel.",
      "The angel \ngiving us a DEATH...",
      "By the way, it's a\nterrible day outside.",
      "Birds are dying, \nflowers are withering, \ndusts are scattering...",
      "On days like these, \nhumans like us...",
      "have a GREAT TIME.",
      "[color:ff0000][effect:rotate][noskip][voice:v_floweymad]THEN, SHALL WE PLAY, \nANOTHER KILLER?",
      "[func:State,DEFENDING][func:Autophobia][noskip]",
    },
    c0 = {"Hey, \nwhat are you doing?\nHit me \nif you're able."},
    c1 = {'Why do you \nget surprised?\nNo one would \nstand there \nand take it.'},
    c2 = {'Always wondered \nwhy you can keep on\nbeing merciful \nfor everyone.'},
    c3 = {"I never met humans\nlike you, so \nI couldn't understand.","Well, finally\nyou're same as them,\nthough."},
    c4 = {"Come to think of it,\nit's not strange.","Heartful people \nwouldn't do RESET, \nI think."},
    c5 = {"Yes, RESET.\nYou think \nI don't know that?","That you abused\ntimelines."},
    c6 = {"I don' know \nwhat number you are, \nbut I know you'll back \neven if I kill you.","With YOU,\nwe can't be \nhappy anymore."}
  }
end

comments = messages.comments --コメントのリスト

commands = messages.commands --ACT時のコマンド

cancheck = false --falseの時デフォルトのCHECKを削除する

sprite = "chara_default" --スプライトの画像　
dialogbubble = "rightwide" --吹き出しの形
dialogueprefix = "" -- モンスターのテキストの初めに挿入
name = messages.name --モンスターの名前
hp = 2000
atk = 1
def = 99
xp = 49999
gold = 0

turn = 0 --攻撃された回数でターンを管理
prayed = 0 --回復回数の計測

randomdialogue = {"[next]"}

if Encounter.GetVar('debugging') then
  currentdialogue = {"Debugging.","[func:State,DEFENDING][func:Autophobia][noskip]"}
  -- currentdialogue = messages.c6
else
  currentdialogue = messages.currentdialogue
end

function HandleAttack(damage)
-- プレイヤーが攻撃したとき
  if damage == -1 then
    Encounter.SetVar("nextwaves",{"default"})
    currentdialogue = messages.c0
  else
    turn = turn + 1
    --turnの値によってメッセージを変える
    if turn == 1 then
      Encounter.SetVar("nextwaves",{"1"})
      currentdialogue = messages.c1 --何かしたとき吹き出しに特別に表示されるテキスト
    elseif turn == 2 then
      Encounter.SetVar("nextwaves",{"2"})
      currentdialogue = messages.c2 --何かしたとき吹き出しに特別に表示されるテキスト
    elseif turn == 3 then
      Encounter.SetVar("nextwaves",{"3"})
      currentdialogue = messages.c3
    elseif turn == 4 then
      Encounter.SetVar("nextwaves",{"4"})
      currentdialogue = messages.c4
    elseif turn == 5 then
      Encounter.SetVar("nextwaves",{"5"})
      currentdialogue = messages.c5
    elseif turn == 6 then
      Encounter.SetVar("nextwaves",{"6"})
      currentdialogue = messages.c6
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
  if command == "CHECK" or command == "[FONT:DET_JP]ぶんせき" then
    BattleDialog(messages.check)
  elseif command == "PRAY" or command == "[FONT:DET_JP]いのる" then
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