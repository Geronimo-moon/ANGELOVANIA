---@diagnostic disable: undefined-global
-- 即死攻撃の処理　arg1:frame ...現在フレーム

function KillForce(frame)
  Encounter['noob'] = false
  Encounter['ez'] = false
  Encounter['extreme'] = false
  Audio.Stop()
  Player.SetControlOverride(true)
  local screen = CreateProjectile("dead", 0, 80)
  local now = frame
  return {screen,now}
end
-- 即死画面の処理　arg1:frame ...現在フレーム,arg2:dead ...死亡時刻,arg3:screen ...99999のオブジェクト
function KillCount(frame,dead,screen)
  if frame % 5 == 0 then
    local dx = 5*(-1)^(frame % 10)
    screen.Move(dx, 0)
  end
  if (frame-dead) >= 60 then 
    Player.Hurt(Player.maxhp,0.001,false,false)
  end
end
