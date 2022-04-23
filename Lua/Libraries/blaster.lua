require 'Libraries.bulletType'
require 'Libraries.hsvToRgb'

function SetBlaster(name,x,y,layer,color)
  local path = 'attack/' .. name

  if layer == nil then
    layer = "Top"
  end
  if color == nil then
    color = "white"
  end

  local blaster = SetBeam(path,x,y,layer,color)

  blaster.SetVar('name',name)

  blaster.SetVar('name',name)

  return blaster
end

function UpdateBlaster(blaster,frame)
  local name = blaster.GetVar('name')

  if name == 'gaster' then
    if blaster.GetVar('frame') == nil then
      blaster.SetVar('frame',frame)
    end

    local spawn = frame - blaster.GetVar('frame')

    if spawn == 44 then
      blaster.sprite.Set('attack/'..name..'2')
    elseif spawn == 47 then
      blaster.sprite.Set('attack/'..name..'3')
    elseif spawn >= 50 then
      if spawn%6 == 2 then
        blaster.sprite.Set('attack/'..name..'4')
      elseif spawn%6 == 5 then
        blaster.sprite.Set('attack/'..name..'5')
      end

      if spawn == 50 then
        local beam = SetBeam('slash/slashb',blaster.x,blaster.y)
        beam.ppcollision = true
        beam.sprite.rotation = blaster.sprite.rotation
        blaster.SetVar('beam',beam)
      end
    end
  elseif name == 'chaos' then
    if blaster.GetVar('frame') == nil then
      blaster.SetVar('frame',frame)
    end

    local spawn = frame - blaster.GetVar('frame')

    if spawn == 50 then
      blaster.sprite.Set('attack/'..name..'2')
      local beam = SetBeam('slash/slashb',blaster.x,blaster.y)
      beam.ppcollision = true
      beam.sprite.rotation = blaster.sprite.rotation
      blaster.SetVar('beam',beam)
    end
  end
end