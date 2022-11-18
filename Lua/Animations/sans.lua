require 'Libraries/bulletType'

function InitSans()
  local scythe = SetDefault('sans/scythe',0,0,'Top')
  local head = CreateSprite('sans/head','Top')
  local body = CreateSprite('sans/body','Top')
  local leg = CreateSprite('sans/leg','Top')

  head.SetParent(leg)
  body.SetParent(leg)
  leg.Scale(1.7,1.7)
  body.Scale(1.7,1.7)
  head.Scale(1.7,1.7)
  scythe.sprite.Scale(2,2)


  leg.SetPivot(0.5,0)

  body.SetPivot(0.5,1)
  body.SetAnchor(0.5,1)

  head.SetPivot(0.5,0)
  head.SetAnchor(0.5,1)

  body.x = 10
  body.y = -6+46*1.7
  head.x = -4
  head.y = 63
  leg.x = 380
  leg.y = 240

  scythe.MoveToAbs(body.absx,body.absy-50)

  SetGlobal('sanshead',head)
  SetGlobal('sansbody',body)
  SetGlobal('sansleg',leg)
  SetGlobal('scythe',scythe)
end

function SansAnime()
  local head = GetGlobal('sanshead')
  local body = GetGlobal('sansbody')
  local leg = GetGlobal('sansleg')

  leg.yscale = 1.7 + 0.005*math.sin(math.pi*Time.time)
  head.y = 63 + math.sin(math.pi*Time.time)
end