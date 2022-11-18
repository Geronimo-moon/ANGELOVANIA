require 'Libraries/bulletType'
require "Animations/sans"
local frame = 0

local px = SetSprite('px',0,0)
px.sprite.color = {0,0,0}
px.sprite.alpha = 0
px.sprite.Scale(Misc.WindowWidth,Misc.WindowHeight)
px.MoveToAbs(Misc.WindowWidth/2,Misc.WindowHeight/2)

local japanese = Encounter.GetVar('japanese')

local texts = {
  sans1 = {"[color:ff0000]Nope, too late."}
}

local sansText = CreateText(texts.sans1,{Misc.WindowWidth/3,Misc.WindowHeight/2},2000,"Top")
sansText.SetFont('uidialog')
sansText.HideBubble()

function Update()
  frame = frame + 1

  if frame == 1 then
    px.sprite.alpha = 1
    local leg = GetGlobal('charaleg')
    leg.Move(-100,0)
  end

  if frame == 60 then
    px.sprite.alpha = 0
    InitSans()
  end
end

function OnHit(bullet)
  Hit(bullet)
end