require 'Libraries.bulletType'
require 'Libraries.blaster'

frame = 0

knives = {}
blasters = {}

function Update()
  frame = frame + 1

  if frame == 1 then
    local blst = SetBlaster('gaster',-150,150)
    blst.sprite.rotation = -45
    table.insert(blasters,blst)
  end

  for i = 1, #blasters do
    if blasters[i].isactive then
      UpdateBlaster(blasters[i],frame)
    end
  end
end

function OnHit(bullet)
  Hit(bullet)
end