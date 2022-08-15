require "Animations/chara"

messages = {}

SetGlobal('charaSpare',false)
SetGlobal('phase',1)

defensemisstext = "PARRYED"

function SetLang()
  if Encounter.GetVar("japanese") == true then
    messages = {
      comments = {"[font:det_jp]キャラは\rあなたがよけるのをみてわらった.", "[font:det_jp]キャラは\rつかれたようにみえない.", "[font:det_jp][color:ff0000]なにかがかのじょに\rちからをかしているようだ.", "[font:det_jp]つみのいしきは\rすでにきえさっている."},
      commands = {"[font:det_jp]ぶんせき","[font:det_jp]いのる","[font:det_jp]セーブ","[font:det_jp]リセット"},
      name = "[font:det_jp]キャラ ドリーマー",
      check = {"[font:det_jp]キャラ ドリーマー  LV ?\nドリーマーけのおかげで\rいきのびた しにぞこない.","[font:det_jp][color:ff0000]すでに,まもってくれる\rモンスターはいない."},
      currentdialogue = {
        "[font:det_jp_mini]ハロー.",
        "[font:det_jp_mini]けっきょく,\nボクらのルールに\nしたがうことに\nしたんだね.",
        "[font:det_jp_mini]いまさら,\nどうしてだい?",
        "[font:det_jp_mini]たくさんのじかんじくで,\nだれもころさずに\nさいこうの\nエンディングに\nたどりついたのに.",
        "[font:det_jp_mini]'ころすか、ころされるか.'\nたしかにそう\nいいつづけてきたさ.",
        "[font:det_jp_mini]でも...\nあんなエンディングを\nしってしまったら...\nねぇ.",
        "[func:CharaHead,chara/closedhead][font:det_jp_mini](ためいき)",
        "[font:det_jp_mini]そうだね,アズ.\nこのニンゲンが\n'てんし'だったんだ.",
        "[font:det_jp_mini]てんしは\nてんしでも\n'し'をもたらす\n'てんし'だったけど.",
        "[func:CharaHead,chara/head][font:det_jp_mini]まぁいいか.\nところで,\nきょうは\nサイアクなひじゃないか?",
        "[font:det_jp_mini]とりはしんで,\nはながかれていき,\nまうのはちりばかり.",
        "[font:det_jp_mini]こんなひには,\nボクらのような\nにんげんは...",
        "[font:det_jp_mini]せいぜい\nたのしもうじゃないか",
        "[font:det_jp_mini][color:ff0000][effect:rotate][noskip][voice:v_floweymad][func:CharaHead,chara/madhead][func:CharaBody,chara/body]はじめようか,\nもうひとりの\nさつじんきさん?",
        "[func:State,DEFENDING][func:Autophobia][func:CharaHead,chara/head]",
      },
      c0 = {"[font:det_jp_mini]なにをしているんだ?\n[font:det_jp_mini]あてられるか,\nためしてみなよ.","[next]"},
      c01 = {"[font:det_jp_mini]...あてるき,あるよな?\n[font:det_jp_mini]それともボクを\nおちょくってんの?","[next]"},
      c02 = {"[font:det_jp_mini]...もしかして,\nはんのうがきになる?\nこれいじょうは\nつきあわないよ?","[next]"},
      c04 = {"...","[next]"},
      c03 = {"[font:det_jp_mini]きみ, よっぽど\nヒマなんだねぇ...","[next]"},
      c1 = {'[font:det_jp_mini]なにを\nおどろいているんだい?\nわざわざくらうために\nつったってるやつなんて\nいないだろ?',"[next]"},
      c2 = {'[font:det_jp_mini]いつもおもってたんだ.\nなんできみは\nみんなにやさしく\nありつづけられるのかって.',"[next]"},
      c3 = {'[font:det_jp_mini][func:CharaHead,chara/closedhead]きみのような\nやさしいひとは\nはじめてだったんだ.','[font:det_jp_mini][func:CharaHead,chara/doubthead]ま,けっきょくきみも\nやつらとおなじだった\nみたいだけど.'},
      c4 = {'[font:det_jp_mini][func:CharaHead,chara/head]でも,かんがえてみれば\nとうぜんか.','[font:det_jp_mini]ほんとうに\nやさしいひとは,\nリセットなんて\nしないだろうし.'},
      c5 = {'[font:det_jp_mini]そう,リセットだ.\nボクがしらないとでも\nおもったのかい?','[font:det_jp_mini]きみがじかんじくを\nすきかってに\nいじっていたこと.'},
      c6 = {'[font:det_jp_mini]きみがなんにんめかは\nしらないけど.\nでも,なんどころしても\nきみはやってくる.','[font:det_jp_mini][func:CharaHead,chara/madhead]きみがいるかぎり,\nボクらに\nほんとうのへいわは\nおとずれないんだ.'},
      c7 = {'[font:det_jp_mini]きみにわかるのかな?\nきょうきのしはいが\nおわった よろこび.','[font:det_jp_mini][func:CharaHead,chara/closedhead]そして...','[font:det_jp_mini][func:CharaHead,chara/downhead]すべてが\nなかったことになった\nあの ぜつぼう.'},
      c8 = {'[font:det_jp_mini][func:CharaHead,chara/downhead]ボクのケツイではリセット\nすることはできない.\nただ,きえていく\nじかんじくのきおくが\nのこされるだけ.','[font:det_jp_mini]もちろんこんなこと,\nそうだんすらできない.','[font:det_jp_mini][func:CharaHead,chara/head]ボクがいったい,\nどれほど\nくるしんだとおもう?'},
      c9 = {'[font:det_jp_mini][func:CharaHead,chara/downhead]それでも...','[font:det_jp_mini]それでも,きみが\nみんなにやさしく\nしていたから,\nめをつむろうとおもった.','[font:det_jp_mini][func:CharaHead,chara/truemadhead]そのけっかが,\nこのザマだ.','[font:det_jp_mini][color:ff0000]まんぞくか?\nぼくらをもてあそんで.'},
      c10 = {'[font:det_jp_mini]まあ,きみのかんがえは\nどうでもいいんだ.\nどうせ,きいてもりかい\nできないだろうし.','[font:det_jp_mini]だいじなのは,\nきみがなんども\nみんなのしあわせを\nうばってるってことだ.','[func:CharaHead,chara/closedhead]...','[func:CharaHead,chara/head][font:det_jp_mini]...ひとつ,\nなつかしいはなしをしよう.','[font:det_jp_mini]スノーフルの\nとびらのはなし...\nいや,これはなんども\nはなしたか.','[font:det_jp_mini]でも...\n"これ"はしらないだろ?'},
      c11 = {'[font:det_jp_mini]おどろいてくれたかな?\nいせきにいたころ,\nパピルスにおそわったんだ.','[font:det_jp_mini]もっとも,\nかれはこのちからを\nきみをまもるために\nつかってほしかった\nみたいだけど.','[font:det_jp_mini][func:CharaHead,chara/winkedhead]どうせ,やくそくは\nなんどもやぶってる.\nこんかいばかりは,\nえんりょしないよ...'},
      c12 = {'[font:det_jp_mini][func:CharaHead,chara/closedhead]いせきが\nなつかしいな...\nみんなのこうげき\nひとつひとつ,\nいまでもおもいだせる.','[font:det_jp_mini]なかでも,かのじょは...\nアルフィーは\nひとすじなわでは\nいかなかった.','[font:det_jp_mini]もう\nたたかえないのが\nざんねんで\nしかたないよ...'},
      c13 = {'[font:det_jp_mini]あぁ,すまない.\nおもいでにひたって\nきみのことを\nわすれるところだった.','[font:det_jp_mini]...\nなんてね,\nじょうだんだ.','[font:det_jp_mini][func:CharaHead,chara/winkedhead]まさか,すべての\nげんきょうのまえで\nきをぬくわけ\nないだろ?'},
      c14 = {'[font:det_jp_mini]もちろん,まえの\nじかんじくなんて\nはなしはボクいがい\nだれもおぼえてない.','[font:det_jp_mini][func:CharaHead,chara/doubthead]だからこそ,\nボクはきみを\nゆるせないんだよ.','[font:det_jp_mini][func:CharaHead,chara/head]アズがどれほど\nちじょうに\nいきたがってたか\nしってるか?','[font:det_jp_mini]ちじょうにでたとき,\nアズはいつも\nめをかがやかせて\n"あのまるいものは\nなんだ?!"ってきくんだ.','[font:det_jp_mini]そこでボクが,\n"あれがたいようだ"\nってかえすんだ.','[font:det_jp_mini]でも"つぎのひ"には,\nかれはスノーフルの\nぼくのへやの\nとびらをたたいて\nこういうんだよ.','[font:det_jp_mini]"おきろ!\nなまけてばかりでは\nちじょうには\nでられないぞ!"'},
      c15 = {'[font:det_jp_mini]ホント,\nむなしくなるよ.\nこんなことばっか\nおこってるんだから\nたまったもんじゃない.','[font:det_jp_mini]そのうえ,\nこんかいのけつまつは\nこれときた.\nまいっちゃうのも\nむりないだろ?','[font:det_jp_mini]...ところで,\nアズを,\nボクのおとうとを\nころしたのは\nせいとうぼうえいか?','[font:det_jp_mini]たしかにイカレたこさ.\nでも,どうじにピュアで\nほんとにひとを\nころすなんてむりだ.','[font:det_jp_mini][func:CharaHead,chara/madhead]いまさら,うそなんて\nつかなくていい.[color:ff0000]\nじひもなく\nむぞうさにころした.\nちがうか?'},
      c16 = {'[font:det_jp_mini]きみのもくてきは\nなんなんだ?\nなんどくりかえしても\nかわらないボクらに\nあいそがつきた?','[font:det_jp_mini]それとも,ただ\nじぶんのちからを\nこじしたいだけ?','[font:det_jp_mini][func:CharaHead,chara/doubthead]...どれもふせいかい.\nたんなるこうきしん.\nそれがきみの\nケツイのもとだ.\nちがうか?'},
      c17 = {'[font:det_jp_mini]つまりきみがボクの\nともだちをころした\nってのは, たいした\nもんだいじゃない.','[font:det_jp_mini]きみがここで\nたのしみつづける\nかぎり, どうせみんな\nよみがえるんだ.','[font:det_jp_mini][func:CharaHead,chara/closedhead]だからいま,\nボクがしなきゃ\nいけないのは...','[font:det_jp_mini][func:CharaHead,chara/winkedhead]きみがにどと\nこのルートにきたいと\nおもえないように\nすることなんだ.'},
      c18 = {'[font:det_jp_mini]そういういみでは,\nママは\nおしいところまで\nいってたろうな.','[font:det_jp_mini]なんど\nあきらめたくなった?\nトリエルの\nほんきのまえに.','[font:det_jp_mini]もういちど\nあくむを\nよみがえらせて\nあげようか?'},
      c19 = {'[font:det_jp_mini]わかってる. ほんらい\nボクのちからは\nママにとおく\nおよばない.','[font:det_jp_mini]でも,ボクには\nせきにんがある.','[font:det_jp_mini]このぎゃくさつを\nここまでとめずにいた\nそのせきにんがね.','[font:det_jp_mini][func:CharaHead,chara/closedhead]だから,ボクは\nここにたっているしか\nないんだよ.'},
      c20 = {'[font:det_jp_mini]...ねぇ,ほんとうに\nつづけたいの?','[font:det_jp_mini]あきらめのわるさは\nほめてあげるけど.\nもっとゆういぎに\nじかんをつかいなよ.','[font:det_jp_mini]ボクだって,\nこんなことホントは\nしたくないんだよ?'},
      c21 = {'[font:det_jp_mini][func:Stop]オーケー,オーケー,\nきみ,からだを\nうごかすのすきなの?\nそれとも,すきなのは\nきりきざまれること?','[font:det_jp_mini]...はぁ,あのさ,\nボクにはきみの\nきもちがわからない.','[font:det_jp_mini]でも...\nむかしは,\nつうじあえたことも\nあっただろ?','[font:det_jp_mini][func:Spare]ねぇ,あいぼう.\nきみがもし...\nもし,そこにいるなら...','[font:det_jp_mini]もういちど,\nゼロから\nやりなおさないか?','[font:det_jp_mini]いまならまだまにあう.\nこのじかんじくをけして\nつぎでうまくやればいい.','[font:det_jp_mini]どうかな?\nやってみるかちは\nあるとおもうよ?'},
      spare = {'[font:det_jp_mini][func:Stop]はぁ, めんど...[func:CharaHead,chara/surprisedhead]\n...え?','[font:det_jp_mini]にがすっていうの?\nボクを?','[font:det_jp_mini][noskip]...','[font:det_jp_mini][noskip][func:CharaHead,chara/closedhead]......','[font:det_jp_mini][noskip]......[w:60]\nそっか','[func:KillSpare][next]'},
      c22 = {'[font:det_jp_mini][func:Stop]ま,だろうね.','[font:det_jp_mini]むしろ,\nあんしんしたよ.','[font:det_jp_mini]これで,えんりょなく\nきみのしたことを\nひなんできる.','[func:Angelovania][font:det_jp_mini][func:CharaHead,chara/madhead][func:CallKarma]じゅんびは\nいいな?'},
      c23 = {'[font:det_jp_mini]どうだい?\nとうさんとつくった\nタマシイのまほうさ.','[font:det_jp_mini]ああ,アズゴアは\nかなりイカレてた.\nボクをころそうと\nするくらいにはね...','[font:det_jp_mini][func:CharaHead,chara/closedhead]でも,けっきょくはボクを\nみとめてくれた.\nそうしていっしょに\nけんきゅうして\nみつけたんだ.','[func:CharaHead,chara/head][color:ff0000]"LOVE"[font:det_jp_mini][color:ff0000]をかこから\nよびもどすほうほうを.'},
      c24 = {'[font:det_jp_mini]王のめいれいで,\nきえたタイムラインの\nことはずっと\nさぐっていた.','[font:det_jp_mini]そこでたどりついたのが,\nじぶんのLOVEを\nきてんにして\nタイムラインをさぐる\nほうほうだ.','LOVE[font:det_jp_mini]のリコールは\nふくさんぶつに\nすぎなかったんだ.','[font:det_jp_mini]ま,こうしてつかうことに\nなるとはゆめにも\nおもわなかったけど.'},
      c25 = {'[font:det_jp_mini]つまり...わかるだろ?\n[w:20][color:ff0000][func:CharaHead,chara/madhead][voice:v_floweymad]ボクはいちど,\nみんなをころしている.','[font:det_jp_mini][func:CharaHead,chara/downhead]はじめてここにきて,\nルールをしって,\nLOVEをあつめた.','[font:det_jp_mini]ためらいもしなかった.\nちじょうでもここでも,\nただころした.','[font:det_jp_mini]そうすることだけが\nわたしの\nいきるすべだった.'},
      c26 = {'[font:det_jp_mini]あまりにたんたんと\nころしてたから,\nアンダインには\nあきれられたよ.','[font:det_jp_mini]あくやくはひとりで\nじゅうぶんだって\nやるきまんまんで\nおそってきたけど.','[font:det_jp_mini]じぶんよりも\nきかいてきなあいてに\nひょうしぬけ\nしたのかもね?'},
      c27 = {'[font:det_jp_mini]でも,すでにボクは\nたいりょうのLOVEを\nもっていた.','[font:det_jp_mini]かのじょもつよかった\nけど,それでも\nふじゅうぶんだった.','[font:det_jp_mini]まあ,あつめたLOVE\nっていみではきみの\nほうがおおいだろ?','[font:det_jp_mini]じゃ,\nボクもほんきを\nみせないとね...'},
      c28 = {'[font:det_jp_mini][func:CharaHead,chara/closedhead]...','[font:det_jp_mini][func:CharaHead,chara/doubthead]まだ,いきてるのか?','[func:CharaHead,chara/downhead]LOVE[font:det_jp_mini]をよびもどし,\nケツイとあわせて\nころしたみんなの\nちからをもつかって...','...','[font:det_jp_mini][func:CharaHead,chara/madhead]これいじょうやるなら,\nほんとうに\nとりかえしのつかない\nことになる.'},
    }
  else
    messages = {
      comments = {"Chara laughed \rlooking you're dodging.", "Chara doesn't looks tired.","[color:ff0000]It seems \rsomething is helping her.","The guilt is already\rgone."},
      commands = {"Check","Pray","Save","Reset"},
      name = "Chara Dreemurr",
      check = {"Chara Dreemurr  LV ?\nShe survived this world\r thanks to Dreemurr family.","[color:ff0000]Now, No one would protect her."},
      currentdialogue = {
        "Howdy.",
        "So, finally, \nyou accepted \nour rule.",
        "Why did you choose \nthat way now?",
        "Many other timelines,\nyou showed us \nawesome endings,\nwithout killing.",
        "That's true \nwe believed \nthe motto that \n'It's kill or be killed'.",
        "But...\nonce see that \npeaceful ending...",
        "[func:CharaHead,chara/closedhead]*sigh*",
        "Yes, Rei...\nthey're angel.",
        "The angel \ngiving us a DEATH...",
        "[func:CharaHead,chara/head]By the way, it's a\nterrible day outside.",
        "Birds are dying, \nflowers are withering, \ndusts are scattering...",
        "On days like these, \nhumans like us...",
        "have a GREAT TIME.",
        "[color:ff0000][effect:rotate][noskip][voice:v_floweymad][func:CharaHead,chara/madhead][func:CharaBody,chara/body]THEN, SHALL WE PLAY, \nANOTHER KILLER?",
        "[func:State,DEFENDING][func:Autophobia][func:CharaHead,chara/head]",
      },
      c0 = {"Hey, \nwhat are you doing?\nHit me \nif you're able.","[next]"},
      c01 = {"...You wanna hit, \nright? Or...are you\njust kidding me?","[next]"},
      c02 = {"...Ah, maybe\nwanna see my \nreaction? Then I \nwon't react to you","[next]"},
      c04 = {"...","[next]"},
      c03 = {"Don't you have \nanything \nbetter to do?","[next]"},
      c1 = {'Why do you \nget surprised?\nNo one would \nstand there \nand take it.',"[next]"},
      c2 = {'Always wondered \nwhy you can keep on\nbeing merciful \nfor everyone.',"[next]"},
      c3 = {"[func:CharaHead,chara/closedhead]I never met humans\nlike you, so \nI couldn't understand.","[func:CharaHead,chara/doubthead]Well, finally\nyou're same as them,\nthough."},
      c4 = {"[func:CharaHead,chara/head]Come to think of it,\nit's not strange.","Heartful people \nwouldn't do RESET, \nwould they?"},
      c5 = {"Yes, RESET.\nYou think \nI don't know that?","That you abused\ntimelines."},
      c6 = {"I don' know \nwhat number you are, \nbut I know you'll back \neven if I kill you.","[func:CharaHead,chara/madhead]With YOU,\nwe can't be \nhappy anymore."},
      c7 = {"You can't understand\nthese feelings.","[func:CharaHead,chara/closedhead]Happiness when crazy\nrule disappeared.\nand...","[func:CharaHead,chara/madhead]Despair when I \nsuddenly understand\nall of them were\nLOST."},
      c8 = {"[func:CharaHead,chara/downhead]My determination is\nnot enough to RESET.\nOnly can keep \nmemories about \ndisappearing timelines.","Of course,\nI can't rely on \nanyone.","[func:CharaHead,chara/head]Can you see\nhow much I struggled?"},
      c9 = {'[func:CharaHead,chara/downhead]Nevertheless...','Nevertheless, as you\nkeep being kind,\nI decided to\noverlook your fault.',"[func:CharaHead,chara/truemadhead]And...\nyou know the result.","[color:ff0000]You satisfied\nfooling with us?"},
      c10 = {"Well, your thought is \nnot important.\nEven if I heard it,\nI shouldn't be able to\nunderstand it.","The importance is...\nyou're destroying\ntheir happiness\nfor a long time.","[func:CharaHead,chara/closedhead]...","[func:CharaHead,chara/head]...By the way,\nhere's a \nnostalgic story.","Door in Snowdin...\nno, I told you it \nmany time.","But...you don't\nknow 'THIS'."},
      c11 = {"Surprised by this?\nwhen I lived in Ruins,\nPapyrus taught me \nthis.","Though, he wanted me\nto use this power for\nprotect you.","[func:CharaHead,chara/winkedhead]Anyway, I broke the \npromise many times...\nThis time, I won't\nbother myself to\nuse this power!"},
      c12 = {"[func:CharaHead,chara/closedhead]Oh, dear days \nin Ruins...\nI still remember\ntheir attack\none by one.","Above all, she...\nAlphys weren't dealt with\neasily.","I regret at\nthat I cannot \nfight against\nher anymore..."},
      c13 = {"Ah, it wasn't good \nduring fight\nto indulge in\nmemories and \nforget about you.","...\nwell, it's joke.","[func:CharaHead,chara/winkedhead]Who will be \ndistracted\nin front of the\ncause of all?"},
      c14 = {"Of course, nobody\nremember about \nprevious timeline \nexcept me.","[func:CharaHead,chara/doubthead]That never made \nme forgive you.","[func:CharaHead,chara/doubthead]Do you know\nhow eager Rei was\nto go to\nthe surface?","When we get to the\nsurface, he always \nsay:'What's that \nround thing?!' \nwith shining eye.","Then I answer,\n'That's the SUN.'","On the \"next\" day,\nknocking the door\nof my room \nat Snowdin,\nhe says...","'Get up!\nYou mustn't be lazy\nto go to \nthe surface!'"},
      c15 = {"It makes me really \nvoid. When this \nkind of thing \nhappens all the time,\nI can't stand it.","Not only that, this \ntime you reached\nthe ending like this.\nIt's not strange\nI got exhaused,right?","...By the way,\nwas it a \nself-defendence\nyou killed Rei,\nmy sweet brother?","You know he's crazy...\nbut also pure \nso that he couldn't \nkill humans.","[func:CharaHead,chara/madhead]Now you needn't lie.\n[color:ff0000]YOU killed him \nwith NO MERCY.\nDIDN'T YOU?"},
      c16 = {"What's your purpose?\nDisgusted to us \nafter we didn't \nchange in \nevery timeline?",'Or, you just\nwanna show off \nyour power?',"[func:CharaHead,chara/doubthead]...No,it's not. Just for \nyour curiosity. \nThat's the root of \nyour determination. \nIsn't it?"},
      c17 = {"In that case,\nit dosen't matter \nanymore\nyou killed my friends.","As long as \nyou have fun with\nthis world, they can\ncome back anyway.",'[func:CharaHead,chara/closedhead]So, what I have to\ndo now is...',"[func:CharaHead,chara/winkedhead]Make you never \nwant to come back\n\"this route\" again."},
      c18 = {"In that sense,\nMom was close enough \nto that purpose.","How many times \ndid you wanna\ngive up\nfacing Toriel's power?",'Would you like to\nget stuck on\nthat nightmare again?'},
      c19 = {"Yeah, I know\nmy power is \nno match for mom's.",'But...\nI have a \nresponsibility.','Responsibility for\nnot stopping this \nmassacre to \nthis extent.','[func:CharaHead,chara/closedhead]So I have no choice\nexcept for \nstanding here.'},
      c20 = {"...Hey,\nyou REALLY wanna\ncontinue?",'I praise your\ntenacity, though.\nUse times\nmore meaningfully.',"I don't wanna\ndo this either,\nyou know?"},
      c21 = {'Okay, okay,\nyou DO like moving \nthe body, right?\nOr you like\nbeing chopped?','...Well, I can\'t see\nyour feeling.','But...\none day we \nunderstood each \nother, didn\'t we?','[func:Spare]Hey, partner.\nif you...\nif you there...','Why don\'t we\nstart over from \nzero again?','It\'s not too late.\nDelete this timeline\nand do well next time.','How is it?\nIt\'s worth doing,\nisn\'t it?'},
      spare = {'[func:Stop]hehe, I know...[func:CharaHead,chara/surprisedhead]\n...what?','You...\nYou sparing me?','[noskip]...','[func:CharaHead,chara/closedhead][noskip]......','[noskip]......[w:60]\nAlright','[func:KillSpare][next]'},
      c22 = {'[func:Stop]Well, I know.','Rather,\nI felt relief.','Now I can blame you\nfor what you did\nwithout reservation.','[func:Angelovania][func:CharaHead,chara/madhead]Are you...\n[color:ff0000][func:CallKarma]READY?'},
      c23 = {'How\'s it going?\nIt\'s a soul-magic\nI created with \nmy father.','Yeah, Asgore was so \ncrazy that he tried \nto kill me...','[func:CharaHead,chara/closedhead]But at last, he \nrecognized me. That\'s \nhow we did our\nresearch together\nand found a way...','[func:CharaHead,chara/head][color:ff0000]To bring back\nthe past LOVE.'},
      c24 = {'At the king\'s order, \nI\'ve been trying to \nfind out about the \nlost timeline \nfor a long time.','So I came up with \nthe idea of using \nmy LOVE as a \nstarting point to \nexplore the timeline.','LOVE\'s recall was \njust a byproduct.','Well, little did \nI dream I\'d end up \nusing it like this.'},
      c25 = {'You know \nwhat I mean?\n[w:20][color:ff0000][func:CharaHead,chara/madhead][voice:v_floweymad]I have killed \neveryone once.','[func:CharaHead,chara/downhead]I came here in the \nfirst timeline, learned \nthe rules and \ngathered LOVE.','I felt no hesitate.\nEither here or \nsurface, I just killed \neveryone.','That was \nthe only way \nI could live.'},
      c26 = {'Undyne was shocked \nwith me because I\nkilled them\nmatter-of-factly.','She said that one \nvillain was enough, \nand attacked me with \na lot of motivation,\nthough.','Maybe, she was more\nupset with a \nmechanical opponent \nthan herself.'},
      c27 = {'But I already got \na lot of LOVE.','Though she was \nstrong, it was\nnot enough to\nbeat me.','By the way,\nIn the sense of \ncollected LOVE \nyou have more, \ndon\'t you?','Maybe, I\'m  gonna \nhave to try \na little harder \nthan THAT.'},
      c28 = {'[func:CharaHead,chara/closedhead]...','[func:CharaHead,chara/doubthead]You, still alive?','[func:CharaHead,chara/downhead]Calling LOVE back,\nand with that power\nI used the skill\nwhose I killed...','...','[func:CharaHead,chara/madhead]if you keep pushing\nme, you are REALLY \nnot going to like \nwhat happens next.'},
    }
  end
  comments = messages.comments --コメントのリスト
  commands = messages.commands --ACT時のコマンド
  name = messages.name --モンスターの名前
end

SetLang()

cancheck = false --falseの時デフォルトのCHECKを削除する

sprite = "null" --スプライトの画像　
dialogbubble = "rightwide" --吹き出しの形
dialogueprefix = "" -- モンスターのテキストの初めに挿入

hp = 2000
atk = 1
def = 99
xp = 49999
gold = 0

turn = 0 --攻撃された回数でターンを管理
prayed = 0 --回復回数の計測
missed = 0

if Misc.FileExists('User/savedata') then
  local save = Misc.OpenFile('User/savedata','r')
  turn = tonumber(save.ReadLine(1))
  prayed = tonumber(save.ReadLine(3))
  SetGlobal("phase",tonumber(save.ReadLine(15)))
  if GetGlobal('phase') == 1.5 then
    SetGlobal('charaSpare',true)
  end
end

randomdialogue = {"[next]"}

if not Misc.FileExists('User/savedata') then
  currentdialogue = messages.currentdialogue
  currentdialogue = messages.c28
end

function HandleAttack(damage)
-- プレイヤーが攻撃したとき
  if damage == -1 then
    Encounter.SetVar("nextwaves",{"default"})
    missed = missed + 1
    if missed == 1 then
      currentdialogue = messages.c0
    elseif missed == 2 then
      currentdialogue = messages.c01
    elseif missed == 3 then
      currentdialogue = messages.c02
    elseif missed == 4 then
      currentdialogue = messages.c03
    else
      currentdialogue = messages.c04
    end
    if GetGlobal('charaSpare') then
      Encounter.SetVar("nextwaves",{"21"})
      currentdialogue = "[next]"
    end
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
    elseif turn == 7 then
      Encounter.SetVar("nextwaves",{"7"})
      currentdialogue = messages.c7
    elseif turn == 8 then
      Encounter.SetVar("nextwaves",{"8"})
      currentdialogue = messages.c8
    elseif turn == 9 then
      Encounter.SetVar("nextwaves",{"9"})
      currentdialogue = messages.c9
    elseif turn == 10 then
      Encounter.SetVar("nextwaves",{"10"})
      currentdialogue = messages.c10
    elseif turn == 11 then
      Encounter.SetVar("nextwaves",{"11"})
      currentdialogue = messages.c11
    elseif turn == 12 then
      Encounter.SetVar("nextwaves",{"12"})
      currentdialogue = messages.c12
    elseif turn == 13 then
      Encounter.SetVar("nextwaves",{"13"})
      currentdialogue = messages.c13
    elseif turn == 14 then
      Encounter.SetVar("nextwaves",{"14"})
      currentdialogue = messages.c14
    elseif turn == 15 then
      Encounter.SetVar("nextwaves",{"15"})
      currentdialogue = messages.c15
    elseif turn == 16 then
      Encounter.SetVar("nextwaves",{"16"})
      currentdialogue = messages.c16
    elseif turn == 17 then
      Encounter.SetVar("nextwaves",{"17"})
      currentdialogue = messages.c17
    elseif turn == 18 then
      Encounter.SetVar("nextwaves",{"18"})
      currentdialogue = messages.c18
    elseif turn == 19 then
      Encounter.SetVar("nextwaves",{"19"})
      currentdialogue = messages.c19
    elseif turn == 20 then
      Encounter.SetVar("nextwaves",{"20"})
      currentdialogue = messages.c20
    elseif turn == 21 then
      Encounter.SetVar("nextwaves",{"21"})
      currentdialogue = messages.c21
      SetGlobal('charaSpare',true)
      SetGlobal('phase',1.5)
    elseif turn == 22 then
      Encounter.SetVar("nextwaves",{"22"})
      currentdialogue = messages.c22
      SetGlobal('charaSpare',false)
      SetGlobal('phase',2)
      if Encounter.GetVar('japanese') then Inventory.SetInventory({"[font:det_jp_mini][color:ffffff]ラザニア","[font:det_jp_mini][color:ffffff]ゆきだるまのかけら","[font:det_jp_mini][color:ffffff]ゆきだるまのかけら","[font:det_jp_mini][color:ffffff]ゆきだるまのかけら","[font:det_jp_mini][color:ffffff]ちゃば","[font:det_jp_mini][color:ffffff]フェイスステーキ","[font:det_jp_mini][color:ffffff]レジェンドヒーロー","[font:det_jp_mini][color:ffffff]レジェンドヒーロー"})
      else Inventory.SetInventory({"Lasagna","SnowPiece","SnowPiece","SnowPiece","Tea","Steak","L. Hero","L. Hero"}) end
      prayed = 0
    elseif turn == 23 then
      Encounter.SetVar("nextwaves",{"23"})
      currentdialogue = messages.c23
    elseif turn == 24 then
      Encounter.SetVar("nextwaves",{"24"})
      currentdialogue = messages.c24
    elseif turn == 25 then
      Encounter.SetVar("nextwaves",{"25"})
      currentdialogue = messages.c25
    elseif turn == 26 then
      Encounter.SetVar("nextwaves",{"26"})
      currentdialogue = messages.c26
    elseif turn == 27 then
      Encounter.SetVar("nextwaves",{"27"})
      currentdialogue = messages.c27
    elseif turn == 28 then
      Encounter.SetVar("nextwaves",{"28"})
      currentdialogue = messages.c28
    end
  end
end

function BeforeDamageCalculation()
  -- ダメージ計算の前にダメージを0にする
  SetDamage(0)
  Dodging()
end

function HandleCustomCommand(command)
-- ACTのコマンドの動作
  Encounter.SetVar("nextwaves",{"default"})
  if GetGlobal('charaSpare') then
    Encounter.SetVar("nextwaves",{"21"})
  end
  if command == "CHECK" or command == "[FONT:DET_JP]ぶんせき" then
    BattleDialog(messages.check)
  elseif command == "PRAY" or command == "[FONT:DET_JP]いのる" then
    if prayed == 0 then
      Player.Heal(20)
      if Encounter.GetVar("japanese") == true then
        BattleDialog({'[font:det_jp]あなたはいのった. \n20HP かいふくした.'})
      else
        BattleDialog({'You prayed. You recovered 20 HP.'})
      end
    elseif prayed == 1 then
      Player.Heal(20)
      if Encounter.GetVar("japanese") == true then
        BattleDialog({'[font:det_jp]あなたはいのった. \n20HP かいふくした.'})
      else
        BattleDialog({'You prayed. You recovered 20 HP.'})
      end
    elseif prayed == 2 then
      Player.Heal(40)
      if Encounter.GetVar("japanese") == true then
        BattleDialog({'[font:det_jp]あなたはいのった. \n40HP かいふくした.'})
      else
        BattleDialog({'You prayed. You recovered 40 HP.'})
      end
    elseif prayed == 3 then
      Player.Heal(40)
      if Encounter.GetVar("japanese") == true then
        BattleDialog({'[font:det_jp]あなたはいのった. \n40HP かいふくした.'})
      else
        BattleDialog({'You prayed. You recovered 40 HP.'})
      end
    elseif prayed == 4 then
      Player.Heal(60)
      if Encounter.GetVar("japanese") == true then
        BattleDialog({'[font:det_jp]あなたはいのった. \n60HP かいふくした.'})
      else
        BattleDialog({'You prayed. You recovered 60 HP.'})
      end
    elseif prayed == 5 then
      Player.Heal(60)
      if Encounter.GetVar("japanese") == true then
        BattleDialog({'[font:det_jp]あなたはいのった. \n60HP かいふくした.'})
      else
        BattleDialog({'You prayed. You recovered 60 HP.'})
      end
    elseif prayed == 6 then
      Player.Heal(80)
      if Encounter.GetVar("japanese") == true then
        BattleDialog({'[font:det_jp]あなたはいのった. \n80HP かいふくした.'})
      else
        BattleDialog({'You prayed. You recovered 80 HP.'})
      end
    elseif prayed == 7 then
      Player.Heal(80)
      if Encounter.GetVar("japanese") == true then
        BattleDialog({'[font:det_jp]あなたはいのった. \n80HP かいふくした.'})
      else
        BattleDialog({'You prayed. You recovered 80 HP.'})
      end
    elseif prayed == 8 then
      Player.Heal(99)
      if Encounter.GetVar("japanese") == true then
        BattleDialog({'[font:det_jp]あなたはいのった. \nHPが ぜんかいふくした.'})
      else
        BattleDialog({'You prayed. Your HP maxed out.'})
      end
    elseif prayed >= 9 then
      if Encounter.GetVar("japanese") == true then
        BattleDialog({'[font:det_jp][color:ff0000]たくさんだ!　\nもう　じゅうぶんいのっただろ!'},{"あなたはいのろうとした.\nが、すでにいのりはつきていた。"})
      else
        BattleDialog({"[color:ff0000]That's enough! Prayed too much!","You tried to pray.\nBut no prayers left."})
      end
    end
    prayed = prayed + 1
  elseif command == "SAVE" or command == "[FONT:DET_JP]セーブ" then
    Audio.PlaySound('saved')
    if not Misc.DirExists('User') then
      Misc.CreateDir('User')
    end
    local save = Misc.OpenFile('User/savedata','w')
    if not Misc.FileExists('User/savedata') then
      save.Write('\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n')
    end
    save.ReplaceLine(1,tostring(turn)) --savefileの一行目をターンにする
    save.ReplaceLine(2,tostring(Player.hp)) --savefileの二行目をHPにする
    save.ReplaceLine(3,tostring(prayed)) --savefileの三行目を回復回数にする
    local items = Inventory.ItemCount -- アイテムの数を記録し名前を続ける
    save.ReplaceLine(4,tostring(items))
    for i=1,items do
      save.ReplaceLine(4+i,tostring(Inventory.GetItem(i)))
    end
    save.ReplaceLine(13,tostring(Encounter.GetVar('noob')))
    save.ReplaceLine(14,tostring(Encounter.GetVar('japanese')))
    save.ReplaceLine(15,tostring(GetGlobal("phase")))
    save.ReplaceLine(16,tostring(Encounter.GetVar('ez')))
    save.ReplaceLine(17,tostring(Encounter.GetVar('extreme')))

    if Encounter.GetVar("japanese") == true then
      BattleDialog({'[font:det_jp][color:ff0000]ひとり のこっている.\n[color:ffffff]ケツイが みなぎった.'})
    else
      BattleDialog({"[color:ff0000]One left.\n[color:ffffff]You filled with DETERMINATION."})
    end
  elseif command == "RESET" or command == "[FONT:DET_JP]リセット" then
    if Misc.FileExists('User/savedata') then
      local save = Misc.OpenFile('User/savedata','w')
      save.Delete()
    end
    Misc.DestroyWindow()
  end
end

-- テキストコマンド用
function Autophobia()
  Audio.Pitch(1)
  Audio.LoadFile('mus_aph')
end

function Angelovania()
  Audio.Pitch(1)
  Audio.LoadFile('mus_ang')
end

function Azimuth()
  Audio.Pitch(1)
  Audio.LoadFile('mus_azi')
end

function Stop()
  Audio.Stop()
end

function DogSong()
  Audio.LoadFile('dogsong')
end

function Spare()
  Audio.LoadFile('spare')
end

function KillSpare()
  Encounter.SetVar("nextwaves",{"spare"})
  Encounter.SetVar("deathmusic","none")
  if Encounter.GetVar("japanese") then
    Encounter.SetVar('deathtext',{'[font:det_jp][color:ffffff]うそだよ, まだ おそくないなんて...','[font:det_jp][color:ffffff]...すべて おそすぎたんだ...','[font:det_jp][color:ffffff]ボクの,かぞくは?','[font:det_jp][color:ffffff]...そもそも, ここにはいない.','[font:det_jp][color:ffffff]...このせかいの"ボク"は,\nおきざりにされるんだ...','[font:det_jp][color:ffffff]....','[font:det_jp][color:ffffff]いまさらの やさしさなんて...','[font:det_jp][color:ffffff]...あいぼう...わたしは, ただ...','[font:det_jp][color:ffffff]ともだちが...\nほしかっただけなのに...','[w:30][color:ffffff]BAD END "[font:det_jp][color:ffffff]ずるいよ"'})
  else
    Encounter.SetVar('deathtext',{'It was lie, that it\'s not too late...','It\'s literary...too late...','How about, my family?','They aren\'t here from the beginning.','"I" in this world, will be left alone...','....','After all this time, kindness is...','...partner...I, I just...','I just want...friends...','[w:30]BAD END "Unfair"'})
  end
end

function Delete()
  Misc.DestroyWindow()
end

function CharaHead(text)
  SetHead(text)
end

function CharaBody(text)
  SetBody(text)
end

function CallKarma()
  Encounter.Call('InitKarma')
  Audio.PlaySound('change')
end