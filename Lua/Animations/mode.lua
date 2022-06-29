require 'Libraries/hsvToRgb'

local mode1 = CreateSprite('null','Top')
local mode2 = CreateSprite('null','Top')
local mode3 = CreateSprite('null','Top')

mode1.SetPivot(0,0)
mode1.Scale(0.8,0.8)
mode1.alpha = 0.7
mode1.x = 460
mode1.y = 60

mode2.SetPivot(0,0)
mode2.Scale(0.8,0.8)
mode2.alpha = 0.7
mode2.x = 460 + 10*math.cos(2*math.pi/3)
mode2.y = 60 + 20*math.sin(2*math.pi/3)

mode3.SetPivot(0,0)
mode3.Scale(0.8,0.8)
mode3.alpha = 0.7
mode3.x = 460 + 10*math.cos(-2*math.pi/3)
mode3.y = 60 + 20*math.sin(-2*math.pi/3)

function SetMode (text)
  if text=="debug" then
    mode1.Set("debug")
    mode2.Set("debug")
    mode3.Set("debug")
  elseif text == "noob" then
    mode1.Set('noob')
    mode2.Set('noob')
    mode3.Set('noob')
  elseif text == "ez" then
    mode1.Set('ez')
    mode2.Set('ez')
    mode3.Set('ez')
  elseif text == 'extreme' then
    mode1.Set('extreme')
    mode2.Set('extreme')
    mode3.Set('extreme')
  else
    mode1.Set('null')
    mode2.Set('null')
    mode3.Set('null')
  end
end

function ModeAnime()
  mode1.color = hsvToRgb(Time.time*101%255,255,200)
  mode2.color = hsvToRgb(Time.time*101%255+85,255,200)
  mode3.color = hsvToRgb(Time.time*101%255+170,255,200)

  local mode1x = 460 + 10*math.cos(math.pi*Time.time/3)
  local mode1y = 60 + 20*math.sin(math.pi*Time.time/3)
  mode1.MoveTo(mode1x,mode1y)
  
  local mode2x = 460 + 10*math.cos(2*math.pi/3+math.pi*Time.time/3)
  local mode2y = 60 + 20*math.sin(2*math.pi/3+math.pi*Time.time/3)
  mode2.MoveTo(mode2x,mode2y)

  local mode3x = 460 + 10*math.cos(-2*math.pi/3+math.pi*Time.time/3)
  local mode3y = 60 + 20*math.sin(-2*math.pi/3+math.pi*Time.time/3)
  mode3.MoveTo(mode3x,mode3y)
end