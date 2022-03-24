---@diagnostic disable: undefined-global
-- 即死攻撃
function SetDieForce(path,x,y,layer,color)
  if layer == nil then
    layer = ""
  end
  if color == nil then
    color = "white"
  end

  local bullet = CreateProjectile(path,x,y,layer)
  bullet.SetVar("type","force")
  bullet.SetVar("color",color)

  return bullet
end
-- 無敵なし攻撃（キャラ・サンズ用）
function SetNotime(path,x,y,layer,color)
  if layer == nil then
    layer = ""
  end
  if color == nil then
    color = "white"
  end

  local bullet = CreateProjectile(path,x,y,layer)
  bullet.SetVar("type","notime")
  bullet.SetVar("color",color)

  return bullet
end
  -- 通常攻撃
function SetDefault(path,x,y,layer,color)
  if layer == nil then
    layer = ""
  end
  if color == nil then
    color = "white"
  end

  local bullet = CreateProjectile(path,x,y,layer)
  bullet.SetVar("type","default")
  bullet.SetVar("color",color)

  return bullet
end
  -- ビーム（無敵なし・大ダメージ）
function SetBeam(path,x,y,layer,color)
  if layer == nil then
    layer = ""
  end
  if color == nil then
    color = "white"
  end

  local bullet = CreateProjectile(path,x,y,layer)
  bullet.SetVar("type","beam")
  bullet.SetVar("color",color)

  return bullet
end

-- スプライト（ダメージなし）
function SetSprite(path,x,y,layer)
  if layer == nil then
    layer = ""
  end
  local color = "white"

  local bullet = CreateProjectile(path,x,y,layer)
  bullet.SetVar("type","sprite")
  bullet.SetVar("color",color)

  return bullet
end

-- 被弾時の処理 出力…即死か否か
function Hit(bullet)
  local color = bullet.GetVar("color")
-- 青攻撃・オレンジ攻撃の判定
  if color == "blue" then
    if not Player.ismoving then
      return false
    end
  elseif color == "orange" then
    if Player.ismoving then
      return false
    end
  end
-- 攻撃タイプに応じたダメージ
  local type = bullet.GetVar("type")
  if type == 'force' then
    return true
  elseif type == 'notime' then
    Player.Hurt(1,0.001)
  elseif type == 'default' then
    Player.Hurt(10,1)
  elseif type == 'beam' then
    Player.Hurt(5,0.001)
  end

  return false
end