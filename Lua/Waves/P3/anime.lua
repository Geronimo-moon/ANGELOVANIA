require 'Libraries/bulletType'
require "Animations/sans"
require "Animations/chara"
local frame = 0

local px = SetSprite('px',0,0)
px.sprite.color = {0,0,0}
px.sprite.alpha = 0
px.sprite.Scale(Misc.WindowWidth,Misc.WindowHeight)
px.MoveToAbs(Misc.WindowWidth/2,Misc.WindowHeight/2)

local japanese = Encounter.GetVar('japanese')

local texts = {
  sans1 = {"[color:ff0000]Nope, too late."},
  chara1 = {'Sans...\nwhy...you here...?'},
  sans2 = {"why? cuz' ya failed, \nof course.","i gave ya too much\ntime. and the result is this.","why haven't you kill 'em?"},
  chara2 = {"[func:CharaHead,chara/damnhead]B-But I can fight even if I got hurt!","I can kill them..."},
  sans3 = {"[func:sansHead,sans/madhead][func:CharaHead,chara/surprisedhead][font:monster][novoice]SHUT UP.","[func:sansHead,sans/closedhead][func:CharaHead,chara/downhead][font:sans][voice:v_sans]i waited for long time.\nit was stupid to expect ya...","i should've kill 'em\nwhen entered my kingdom.","[font:monster][novoice][func:sansHead,sans/madhead][noskip]LIKE THIS.","heh, now you can do nothing.","welp, let's begin."}
}

local firstText = CreateText(texts.sans1,{Misc.WindowWidth/3,Misc.WindowHeight/2},2000,"Top")
firstText.SetFont('uidialog')
firstText.HideBubble()

local sansBubble = CreateSprite('UI/SpeechBubbles/rightwide',"BelowBullet")
sansBubble.MoveTo(Misc.WindowWidth/2+190,Misc.WindowHeight/2+170)
local sansText = CreateText('',{Misc.WindowWidth/2+110,Misc.WindowHeight/2+195},sansBubble.width-40,"Top",sansBubble.height-40)
sansText.deleteWhenFinished = false
sansText.progressmode = "none"
sansText.SetVoice('v_sans')
sansText.SetFont('sans')
sansText.HideBubble()
sansText.NextLine()

local charaBubble = CreateSprite('UI/SpeechBubbles/rightwide',"BelowBullet")
charaBubble.MoveTo(Misc.WindowWidth/2+60,Misc.WindowHeight/2+160)
local charaText = CreateText('',{Misc.WindowWidth/2-20,Misc.WindowHeight/2+185},charaBubble.width-40,"Top",charaBubble.height-40)
charaText.deleteWhenFinished = false
charaText.progressmode = "none"
charaText.HideBubble()
charaText.NextLine()

local scythe,cut

function Update()
  frame = frame + 1

  if frame == 1 then
    px.sprite.alpha = 1
    local leg = GetGlobal('charaleg')
    leg.Move(-100,0)
    local head = GetGlobal('charahead')
    head.Set('chara/surprisedhead')
  end

  if frame == 60 then
    firstText.DestroyText()
    px.sprite.alpha = 0
    InitSans()
    sansText.SendToTop()
    charaText.SendToTop()
    Audio.PlaySound('heavydmg')
    scythe = GetGlobal('scythe')
  elseif frame == 180 then
    talkChara(texts.chara1)
  elseif frame == 290 then
    charaText.NextLine()
    talkSans(texts.sans2)
  elseif frame == 320 then
    Audio.LoadFile('mus_dec')
    Audio.Volume(0.0)
    Audio.Pitch(1)
  elseif frame == 410 then
    sansText.NextLine()
  elseif frame == 590 then
    sansText.NextLine()
  elseif frame == 690 then
    sansText.NextLine()
    talkChara(texts.chara2)
  elseif frame == 840 then
    charaText.NextLine()
  elseif frame == 940 then
    charaText.NextLine()
    talkSans(texts.sans3)
  elseif frame == 1000 then
    sansText.NextLine()
  elseif frame == 1180 then
    sansText.NextLine()
  elseif frame == 1350 then
    sansText.NextLine()
    scythe.sprite.layer = "Top"
    Misc.ScreenShader.Set('cyfshaders','Invert')
  elseif frame > 1350 and frame <= 1469 then
    scythe.sprite.Scale(2*(frame/1350)^13,2*(frame/1350)^13)
    scythe.sprite.rotation = scythe.sprite.rotation + (frame/1350)
    scythe.Move(-0.5,-1)
  elseif frame > 1470 and frame <= 1479 then
    scythe.sprite.rotation = scythe.sprite.rotation - 30
  elseif frame == 1470 then
    Misc.ScreenShader.Revert()
    scythe.sprite.layer = "BelowArena"
    scythe.sprite.Scale(2,2)
    scythe.sprite.rotation = scythe.sprite.rotation + 290
    local body = GetGlobal('sansbody')
    scythe.MoveToAbs(body.absx,body.absy-50)
    px.sprite.alpha = 1
    UI.fightbtn.alpha = 0
    UI.actbtn.alpha = 0
    UI.itembtn.alpha = 0
    UI.mercybtn.alpha = 0
    UI.DisableButton("FIGHT")
    UI.DisableButton("ACT")
    UI.DisableButton("ITEM")
    UI.DisableButton("MERCY")
    Audio.PlaySound("bolt")
    Audio.Pause()
    cut = CreateSprite("slash/slashb","Top")
    cut.MoveTo(0,45)
    cut.Scale(1,1.5)
  elseif frame > 1470 and frame <= 1490 then
    cut.alpha = cut.alpha - 0.05
  elseif frame == 1530 then
    px.sprite.alpha = 0
    cut.Remove()
    sansText.NextLine()
  elseif frame == 1640 then
    sansText.NextLine()
  elseif frame == 1730 then
    sansText.NextLine()
    Audio.Unpause()
    Encounter.SetVar("nextwaves",{"P3/1"})
    EndWave()
    sansBubble.Remove()
    charaBubble.Remove()
    State("DIALOGRESULT")
    BattleDialog("[color:ff0000]But you can't do anything...")
  end

  if not sansText.isactive then
    sansBubble.alpha = 0
  end
  if not charaText.isactive then
    charaBubble.alpha = 0
  end
  if frame > 350 and frame <= 1460 then
    if frame % 15 == 0 then
      Audio.Volume(0.75*(frame-350)/1110)
    end
  end
end

function OnHit(bullet)
  return
end

function talkSans(text)
  sansBubble.alpha = 1
  sansText.SetText(text)
end

function talkChara(text)
  charaBubble.alpha = 1
  charaText.SetText(text)
end

function CharaHead(text)
  SetHead(text)
end

function CharaBody(text)
  SetBody(text)
end

function sansHead(text)
  SansHead(text)
end

function sansBody(text)
  SansBody(text)
end