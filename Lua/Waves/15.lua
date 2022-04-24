require 'Libraries.bulletType'
require 'Libraries.blaster'

frame = 0

Arena.Resize(400,360)

knives = {}
blasters = {}

SetPPCollision(true)

function Update()
  frame = frame + 1

  if frame == 1 then
    local blst = SetBlaster('chaos',-10,10)
    blst.sprite.rotation = -45
    table.insert(blasters,blst)
  end

  for i = 1, #blasters do
    if blasters[i].isactive then
      UpdateBlaster(blasters[i],frame,600)
    end
  end
end

function OnHit(bullet)
  Hit(bullet)
end