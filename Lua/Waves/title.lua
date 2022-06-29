local mask = CreateSprite("px", "Top")
mask.color = {0, 0, 0}
mask.Scale(640, 480)

local logo = CreateSprite('logo','Top')
logo.color = {255,0,0}
logo.MoveToAbs(320,440)

local title = CreateSprite('title','Top')
title.MoveToAbs(320,350)

local eng = CreateSprite('eng','Top')
eng.MoveToAbs(200,250)
eng.color = {255,255,0}
eng.SetVar('set',true)
local engbox = CreateSprite('choosebox','Top')
engbox.SetParent(eng)
engbox.color = {255,255,0}
engbox.MoveTo(-75,0)

local jpn = CreateSprite('jpn','Top')
jpn.MoveToAbs(440,250)
jpn.color = {255,0,0}
jpn.SetVar('set',false)
local jpnbox = CreateSprite('choosebox','Top')
jpnbox.SetParent(jpn)
jpnbox.color = {255,0,0}
jpnbox.MoveTo(-75,0)

local nb = CreateSprite('normal','Top')
nb.MoveToAbs(320,180)
nb.color = {255,0,0}
nb.SetVar('set',false)
local leftArrow = CreateSprite('arrow','Top')
leftArrow.SetParent(nb)
leftArrow.color = {255,0,0}
leftArrow.MoveTo(-190,0)
local rightArrow = CreateSprite('arrow','Top')
rightArrow.SetParent(nb)
rightArrow.color = {255,0,0}
rightArrow.Scale(-1,1)
rightArrow.MoveTo(190,0)

local fight = CreateSprite('UI/Buttons/fightbt_0',"Top")
fight.Scale(2,2)
fight.MoveToAbs(320,70)

local soul = CreateSprite('ut-heart','Top')
soul.color = {255,0,0}
soul.MoveToAbs(125,250)
soul.SetVar('place',1)

local press = false

local modes = {"practice","noobmenu",'normal',"extreme"}
local modeflag = {"ez","noob","normal","extreme"}
local current = 2 -- 1少ない

function Update()
  local place = {{125,250},{365,250},{225,180},{250,65}}

  if not press then
    if soul.GetVar('place') == 1 or soul.GetVar('place') == 2 then
      if Input.Left == 1 or Input.Right == 1 then
        Audio.PlaySound('menumove')
        soul.SetVar('place',(soul.GetVar('place'))%2+1)
        soul.MoveToAbs(place[soul.GetVar('place')][1],place[soul.GetVar('place')][2])
      elseif Input.Down == 1 then
        soul.alpha = 0
        nb.color = {255,255,0}
        Audio.PlaySound('menumove')
        soul.SetVar('place',3)
        soul.MoveToAbs(place[3][1],place[3][2])
      end

      if Input.Confirm == 1 then
        Audio.PlaySound('menuconfirm')
        if soul.GetVar('place') == 1 then
          eng.color = {255,255,0}
          engbox.color = {255,255,0}
          jpn.color = {255,0,0}
          jpnbox.color = {255,0,0}
          Encounter.SetVar('japanese',false)
          Encounter.Call('SetLang')
          Encounter["enemies"][1].Call('SetLang')
        else
          eng.color = {255,0,0}
          engbox.color = {255,0,0}
          jpn.color = {255,255,0}
          jpnbox.color = {255,255,0}
          Encounter.SetVar('japanese',true)
          Encounter.Call('SetLang')
          Encounter["enemies"][1].Call('SetLang')
        end
      end

    elseif soul.GetVar('place') == 3 then
      if Input.Up == 1 then
        soul.alpha = 1
        nb.color = {255,0,0}
        Audio.PlaySound('menumove')
        soul.SetVar('place',1)
        soul.MoveToAbs(place[1][1],place[1][2])
      elseif Input.Down == 1 then
        soul.alpha = 1
        nb.color = {255,0,0}
        Audio.PlaySound('menumove')
        soul.SetVar('place',4)
        soul.MoveToAbs(place[4][1],place[4][2])
        soul.Scale(2,2)
        fight.Set('UI/Buttons/fightbt_1')
      end

      if Input.Left == 1 then
        Audio.PlaySound('menumove')
        current = (current - 1)%4
        nb.Set(modes[current+1])
      elseif Input.Right == 1 then
        Audio.PlaySound('menumove')
        current = (current + 1)%4
        nb.Set(modes[current+1])
      end

    elseif soul.GetVar('place') == 4 then
      if Input.Up == 1 then
        Audio.PlaySound('menumove')
        soul.SetVar('place',3)
        nb.color = {255,255,0}
        soul.alpha = 0
        soul.MoveToAbs(place[3][1],place[3][2])
        soul.Scale(1,1)
        fight.Set('UI/Buttons/fightbt_0')
      end

      if Input.Confirm == 1 then
        Encounter.SetVar(modeflag[current+1],true)
        if current == 0 then
          Player.maxhp = 150
          Player.hp = 150
        elseif current == 3 then
          Player.maxhp = 1
          Player.hp = 1
        else
          Encounter.Call('InitKarma')
        end
        Audio.PlaySound('BeginBattle3')
        Encounter.SetVar('nextwaves',{'opening'})
        mask.Remove()
        logo.Remove()
        title.Remove()

        eng.Remove()
        jpn.Remove()
        engbox.Remove()
        jpnbox.Remove()
        nb.Remove()
        leftArrow.Remove()
        soul.Remove()
        fight.Remove()

        Encounter.GetVar('enemies')[1].SetVar("currentdialogue",Encounter.GetVar('enemies')[1].GetVar('messages').currentdialogue)
        Audio.LoadFile('mus_first')
        Audio.Pitch(0.2)
        State('ENEMYDIALOGUE')
      end
    end
  end
end

function OnHit(bullet)
  do return end
end