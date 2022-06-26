function InitChara()
  local black = CreateSprite('chara/black')
  local head = CreateSprite('chara/head')
  local body = CreateSprite('chara/noknifebody')
  local leg = CreateSprite('chara/leg')

  if Misc.FileExists('User/savedata') then
    body.Set('chara/body')
  end

  leg.SetParent(black)
  body.SetParent(leg)
  black.SetParent(body)
  head.SetParent(body)

  black.SetAnchor(0,0)

  leg.SetPivot(0.5,0)

  body.SetPivot(0.5,0)
  body.SetAnchor(0.5,1)

  head.SetPivot(0.5,0)
  head.SetAnchor(0.5,1)

  leg.x = 0
  leg.y = -110
  body.x = -22
  body.y = -3
  head.x = 20
  head.y = -40
  black.x = 320
  black.y = 350

  SetGlobal('charahead',head)
  SetGlobal('charabody',body)
  SetGlobal('charaleg',leg)
  SetGlobal('charablack',black)
  SetGlobal('charadodge',0)
  SetGlobal('charaback',0)
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
  local move = 100
  SetGlobal('charadodge',move)
end

function Backing()
  local move = 101.2
  SetGlobal('charaback',move)
end

function CharaAnime()
  local black = GetGlobal('charablack')
  local head = GetGlobal('charahead')
  local body = GetGlobal('charabody')
  local leg = GetGlobal('charaleg')
  local dodge = GetGlobal('charadodge')
  local back = GetGlobal('charaback')

  if dodge > 0 then
    local move = -dodge/8
    black.Move(move,0)
    SetGlobal('charadodge',dodge - 5)
    head.Set('chara/winkedhead')
  end
  if back > 0 then
    local move = back/16
    black.Move(move,0)
    SetGlobal('charaback',back - 5/2)
    head.Set('chara/head')
  end
  leg.Scale(1, 1+0.01*math.sin(Time.time*2))
  body.MoveTo(-22,-3 + 0.1*math.sin(Time.time*2))
  head.MoveTo(20,-40 + 0.1*math.sin(Time.time*2))
end