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

  local blaster = SetSprite(path,x,y,layer)

  blaster.SetVar('name',name)

  blaster.SetVar('name',name)

  Audio.PlaySound('blaster')

  return blaster
end

function UpdateBlaster(blaster,frame,time)
  local name = blaster.GetVar('name')

  if time == nil or time <= 100 then
    time = 100
  end

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
      if spawn%8 == 2 then
        blaster.sprite.Set('attack/'..name..'4')
      elseif spawn%8 == 6 then
        blaster.sprite.Set('attack/'..name..'5')
      end

      if spawn == 50 then
        local beam = SetBeam('slash/slashb',blaster.x+800*math.cos(math.pi*blaster.sprite.rotation/180),blaster.y+800*math.sin(math.pi*blaster.sprite.rotation/180))
        beam.sprite.Scale(1,5/2*blaster.sprite.yscale)
        beam.sprite.color = hsvToRgb(0,255,200)
        beam.sprite.rotation = blaster.sprite.rotation
        blaster.SetVar('beam',beam)
      end

      blaster.GetVar('beam').sprite.yscale = (2+math.cos((frame-50)*math.pi/4)/2)*blaster.sprite.yscale

      -- blaster.Move(-10*math.cos(math.pi*blaster.sprite.rotation/180),-10*math.sin(math.pi*blaster.sprite.rotation/180))
      -- blaster.GetVar('beam').Move(-10*math.cos(math.pi*blaster.sprite.rotation/180),-10*math.sin(math.pi*blaster.sprite.rotation/180))

      if time - spawn <= 10 then
        blaster.sprite.alpha = blaster.sprite.alpha - 0.1
        blaster.GetVar('beam').sprite.alpha = blaster.GetVar('beam').sprite.alpha - 0.1
        if blaster.sprite.alpha == 0 then
          blaster.Remove()
          blaster.GetVar('beam').Remove()
        end
      end
    end

  elseif name == 'chaos' then
    if blaster.GetVar('frame') == nil then
      blaster.SetVar('frame',frame)
    end

    local spawn = frame - blaster.GetVar('frame')

    if spawn == 50 then
      blaster.sprite.Set('attack/'..name..'2')
      local beam = SetBeam('slash/slashb',blaster.x+800*math.cos(math.pi*blaster.sprite.rotation/180),blaster.y+800*math.sin(math.pi*blaster.sprite.rotation/180))
      beam.sprite.Scale(1,blaster.sprite.yscale)
      beam.sprite.rotation = blaster.sprite.rotation
      beam.sprite.color = hsvToRgb((spawn-50)%255,255,200)
      beam.sprite.color[1] = 1
      beam.sprite.alpha = 0.5
      local center = SetSprite('slash/slashb',blaster.x+800*math.cos(math.pi*blaster.sprite.rotation/180),blaster.y+800*math.sin(math.pi*blaster.sprite.rotation/180))
      center.sprite.Scale(1,blaster.sprite.yscale/2)
      center.sprite.rotation = blaster.sprite.rotation
      center.sprite.color = hsvToRgb(0,175,255)
      blaster.SetVar('beam',beam)
      blaster.SetVar('center',center)
    end

    if spawn >= 50 then
      -- blaster.Move(-10*math.cos(math.pi*blaster.sprite.rotation/180),-10*math.sin(math.pi*blaster.sprite.rotation/180))
      -- blaster.GetVar('center').Move(-10*math.cos(math.pi*blaster.sprite.rotation/180),-10*math.sin(math.pi*blaster.sprite.rotation/180))
      -- blaster.GetVar('beam').Move(-10*math.cos(math.pi*blaster.sprite.rotation/180),-10*math.sin(math.pi*blaster.sprite.rotation/180))
      blaster.GetVar('beam').sprite.color = hsvToRgb((spawn-50)*4%255,255,200)
      blaster.GetVar('beam').sprite.color[1] = 1

      if time - spawn <= 5 then
        blaster.sprite.alpha = blaster.sprite.alpha - 0.2
        blaster.GetVar('beam').sprite.alpha = blaster.GetVar('beam').sprite.alpha - 0.1
        blaster.GetVar('center').sprite.alpha = blaster.GetVar('center').sprite.alpha - 0.1
        if blaster.sprite.alpha == 0 then
          blaster.Remove()
          blaster.GetVar('beam').Remove()
          blaster.GetVar('center').Remove()
        end
      end
    end
  end
end