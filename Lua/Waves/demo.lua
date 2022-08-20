Audio.Stop()
Player.SetControlOverride(true)
local demo = CreateSprite('demo','Top')
demo.MoveTo(320,240)
Audio.PlaySound('demoend')
if Misc.FileExists('User/savedata') then
  local save = Misc.OpenFile('User/savedata','w')
  save.Delete()
end

function Update()
  return
end