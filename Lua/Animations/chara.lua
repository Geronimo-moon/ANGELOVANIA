function InitChara()
  local black = CreateSprite('chara/black')
  local head = CreateSprite('chara/head')
  local body = CreateSprite('chara/noknifebody')
  local leg = CreateSprite('chara/leg')

  local cut = CreateSprite('null')

  if Misc.FileExists('User/savedata') then
    body.Set('chara/body')
  end

  leg.SetParent(black)
  head.SetParent(leg)
  body.SetParent(leg)
  black.SetParent(body)
  leg.Scale(1.85,1.85)
  body.Scale(1.85,1.85)
  head.Scale(1.85,1.85)

  black.SetAnchor(0,0)

  leg.SetPivot(0.5,0)

  body.SetPivot(0.5,1)
  body.SetAnchor(0.5,1)

  head.SetPivot(0.5,0)
  head.SetAnchor(0.5,1)

  cut.SetParent(body)
  cut.x = 0
  cut.y = -25
  cut.rotation = 90

  leg.x = 0
  leg.y = -110
  body.x = 0
  body.y = -6+46*1.85
  head.x = -4
  head.y = 50
  black.x = 320
  black.y = 350

  SetGlobal('charahead',head)
  SetGlobal('charabody',body)
  SetGlobal('charaleg',leg)
  SetGlobal('charablack',black)
  SetGlobal('charadodge',false)
  SetGlobal('charaframe',0)
  SetGlobal('characut',cut)
end


function SetHead(text)
  local head = GetGlobal('charahead')
  head.Set(text)
end

function SetBody(text)
  local body = GetGlobal('charabody')
  body.Set(text)
end

function Dodging()
  SetGlobal('charaframe',90)
end

function CharaAnime()
  local head = GetGlobal('charahead')
  local body = GetGlobal('charabody')
  local leg = GetGlobal('charaleg')
  local cut = GetGlobal('characut')
  local frame = GetGlobal('charaframe')

  if frame > 0 then
    if frame == 5 then
      leg.Move(-5,0)
      cut.Set("slash/6")
      SetHead('chara/head')
      SetBody('chara/body')
    elseif frame == 10 then
      leg.Move(10,0)
      cut.Set("slash/5")
    elseif frame == 15 then
      leg.Move(-10,0)
      cut.Set("slash/4")
    elseif frame == 20 then
      leg.Move(10,0)
      cut.Set("slash/3")
    elseif frame == 25 then
      cut.Set("slash/2")
      leg.Move(-10,0)
    elseif frame == 30 then
      cut.Set("slash/1")
      SetBody('chara/body')
      leg.Move(5,0)
    elseif frame == 60 then
      Audio.PlaySound('thunder')
    elseif frame == 80 then
      SetBody('chara/parrybody')
    elseif frame == 90 then
      SetBody('chara/swingbody')
      SetHead('chara/madhead')
    end
    SetGlobal('charaframe',frame-1)
  else
    cut.Set('null')
  end

  leg.yscale = 1.85 + 0.005*math.sin(math.pi*Time.time)
  head.y = 50 + math.sin(math.pi*Time.time)
end