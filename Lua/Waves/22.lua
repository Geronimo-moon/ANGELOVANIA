require 'Libraries/bulletType'
local orange = require 'Libraries/orangesoul'
local cyan = require 'Libraries/cyansoul'

frame = 0

Arena.Resize(300,200)

firstKnives = {}

function Update()
  frame = frame + 1

  if orange.isactive then
    orange.Update()
  end
  if cyan.isactive then
    cyan.Update()
  end

  if frame >= 10 and frame <= 60 then
    if frame % 5 == 0 then
      local knifer = SetNotime('knifel',320,Player.y)
      local knifel = SetNotime('knifer',-320,Player.y)
      local knifeu = SetNotime('knifed',Player.x,240)
      local knifed = SetNotime('knifeu',Player.x,-240)
      knifer.SetVar('mv',{-2,0,frame})
      knifel.SetVar('mv',{2,0,frame})
      knifeu.SetVar('mv',{0,-2,frame})
      knifed.SetVar('mv',{0,2,frame})
      table.insert(firstKnives,knifer)
      table.insert(firstKnives,knifeu)
      table.insert(firstKnives,knifed)
      table.insert(firstKnives,knifel)
    end
  end

  for i=1,#firstKnives do
    if firstKnives[i].isactive then
      local move = firstKnives[i].GetVar('mv')
      firstKnives[i].Move(move[1],move[2])
      for j=1,2 do
        if move[j] ~= 0 then
          local param = move[j]/math.abs(move[j])
          move[j] = param*(math.abs(move[j])+(frame-move[3])/5)
        end
      end
      firstKnives[i].SetVar('mv',move)
    end
  end

  -- if frame == 10 then
  --   orange.Init()
  -- end

  -- if frame == 240 then
  --   orange.Quit()
  --   cyan.Init()
  -- end

  -- if frame == 480 then
  --   cyan.Quit()
  -- end
end