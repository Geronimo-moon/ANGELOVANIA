local bar = CreateSprite("color")
local hphide = CreateSprite("color")
local kr = CreateSprite("krname")
local hp = {}
local d, t, i, v

Karma = {
  kr = 0,
  maxkr = 40,
  drain = 1,
  kr_t = 0,
  sprites = {bar = bar, hphide = hphide, kr = kr, hp = hp}
}

bar.y = 70
bar.scale(0, 20)
bar.color32 = {255, 40, 255}
bar.SetPivot(0, 0.5)
hphide.y = 70
hphide.scale(130, 20)
hphide.SetPivot(0, 0.5)
hphide.color = {0, 0, 0}
kr.y = 70
kr.SetPivot(0, 0.5)

function Karma_Inc(k)
  if Player.ishurting then return 0 end
  if k == nil then k = 6 end
  Karma.kr = Karma.kr + k
  return k
end

function Karma.Update()
  Karma.kr = math.max(Karma.kr, 0)
  Karma.kr = math.min(Karma.kr, Karma.maxkr)
  Karma.kr = math.min(Karma.kr, Player.hp - 1)
  if Karma.kr > 0 then
    Karma.kr_t = Karma.kr_t + Time.mult / 2
    for i, v in ipairs({{40, 1}, {30, 2}, {20, 5}, {1, 30}}) do
      if Karma.kr >= v[1] and Karma.kr_t >= v[2] / Karma.drain then
        Karma.kr_t = 0
        Karma.kr = Karma.kr - 1
        Player.hp = Player.hp - 1
      end
    end
  end

  d = 1.2
  --if Player.hp > Player.maxhp then d = d * Player.hp / Player.maxhp end
  --if Player.maxhp > 103 then d = d * 103 / Player.maxhp end
  bar.x = (Player.hp - Karma.kr) * d + 276
  bar.xscale = Karma.kr * d
  hphide.x = Player.maxhp * d + 285
  kr.x = Player.maxhp * d + 285
  if hp.isactive ~= true then
    hp = CreateText("[noskip][novoice][w:9] ", {430, 63}, 120)
    hp.HideBubble()
    hp.progressmode = "none"
    hp.color = {1, 1, 1}
    hp.SetFont("uibattlesmall")
    hp.NextLine()
  end
  hp.x = Player.maxhp * d + 325
  if Karma.kr > 0 then hp.color = bar.color else hp.color = {1, 1, 1} end
  t = "" .. Player.hp
  hp.SetText("[noskip][novoice][instant]" .. string.sub(t, 1, -2) .. "[charspacing:14]" .. string.sub(t, -1, -1) .. "/[charspacing:3]" .. Player.maxhp .. "[instant:stop] ")
  hp.NextLine()
end
