function InitChara()
  local head = CreateSprite('chara/head')
  local body = CreateSprite('chara/noknifebody')
  local leg = CreateSprite('chara/leg')

  body.SetParent(leg)
  head.SetParent(body)

  leg.SetPivot(0.5,0)

  body.SetPivot(0.5,0)
  body.SetAnchor(0.5,1)

  head.SetPivot(0.5,0)
  head.SetAnchor(0.5,1)

  leg.x = 320
  leg.y = 240
  body.x = -22
  body.y = -3
  head.x = 20
  head.y = -40

  SetGlobal('charahead',head)
  SetGlobal('charabody',body)
  SetGlobal('charaleg',leg)
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
  local head = GetGlobal('charahead')
  local body = GetGlobal('charabody')
  local leg = GetGlobal('charaleg')
  local dodge = GetGlobal('charadodge')
  local back = GetGlobal('charaback')

  if dodge > 0 then
    local move = -dodge/8
    leg.Move(move,0)
    SetGlobal('charadodge',dodge - 5)
    head.Set('chara/winkedhead')
  end
  if back > 0 then
    local move = back/16
    leg.Move(move,0)
    SetGlobal('charaback',back - 5/2)
    head.Set('chara/head')
  end
  leg.Scale(1, 1+0.01*math.sin(Time.time*2))
  body.MoveTo(-22,-3 + 0.1*math.sin(Time.time*2))
  head.MoveTo(20,-40 + 0.1*math.sin(Time.time*2))
end