local self = {
  blue = require 'soul/blue',
  cyan = require 'soul/cyan',
  green = require 'soul/green',
  yellow = require 'soul/yellow',
  purple = require 'soul/purple'
}

self.currentSoul = {"red"} -- 現在のソウル状態
self.sprites = {l=nil,r=nil,ur=nil,ul=nil,d=nil} -- ソウル複数時のダミー
self.lastKeys = { -- オレンジソウル用状態記録
  UpArrow = false,
  DownArrow = false,
  RightArrow = false,
  LeftArrow = false,
  active = false
}

local colorList = {
  red = {1,0,0},
  blue = {0,0,1},
  orange = {1,0.45,0},
  cyan = {0.15,0.7,0.95},
  green = {0.24,0.7,0.43},
  yellow = {1,1,0},
  purple = {0.53,0.28,0.60}
} -- 各色のカラーコード

function self.Init(list)
  self.currentSoul = list
  Audio.PlaySound('change')
  if #list == 1 then
    Player.sprite.color = colorList[list[1]]
  elseif #list == 2 then
    local l = CreateSprite("soul/lsoul")
    local r = CreateSprite("soul/rsoul")
    l.SetParent(Player.sprite)
    r.SetParent(Player.sprite)
    l.MoveTo(-4,0)
    r.MoveTo(4,0)
    l.color = colorList[list[1]]
    r.color = colorList[list[2]]
    self.sprites.l = l
    self.sprites.r = r
  elseif #list == 3 then
    local ul = CreateSprite("soul/ulsoul")
    local ur = CreateSprite("soul/ursoul")
    local d = CreateSprite("soul/dsoul")
    ul.SetParent(Player.sprite)
    ur.SetParent(Player.sprite)
    d.SetParent(Player.sprite)
    ul.MoveTo(-4,4)
    ur.MoveTo(4,4)
    d.MoveTo(0,-4)
    ul.color = colorList[list[1]]
    ur.color = colorList[list[2]]
    d.color = colorList[list[3]]
    self.sprites.ul = ul
    self.sprites.ur = ur
    self.sprites.d = d
  end

  if (#list == 1 and list[1] == "red") then
    Player.SetControlOverride(false)
  else
    Player.SetControlOverride(true)
  end

  for i = 1, #list do
    if list[i] == "orange" then
      self.orangeKey(true)
      if #list == 1 then
        self.lastKeys.RightArrow = true
      end
    elseif list[i] == "red" and #list == 1 then
      return
    else
      self[list[i]].Init()
    end
  end
end

function self.Update() -- 毎フレームの更新
  local originalMove = false
  if (#self.currentSoul == 1 and self.currentSoul[1] == "red") then
    return
  else
    if self.lastKeys.active then
      self.orangeKey()
    end
    for i = 1, #self.currentSoul do
      if self.currentSoul[i] ~= 'orange' then
        originalMove = originalMove or self[self.currentSoul[i]].Control(self.lastKeys) -- アップデート・プレーヤーを動かしたか確認
      end
    end
  end

  if not originalMove then
    self.Control(self.lastKeys)
  end
end

function self.Control(key) -- プレーヤーを動かしてないなら矢印操作で動かす
  local move = {x=0,y=0}
  local div = 1
  if Input.GetKey('UpArrow') == 2 or key.UpArrow then
    move.y = move.y + 2
  end
  if Input.GetKey('DownArrow') == 2 or key.DownArrow then
    move.y = move.y - 2
  end
  if Input.GetKey('RightArrow') == 2 or key.RightArrow then
    move.x = move.x + 2
  end
  if Input.GetKey('LeftArrow') == 2 or key.LeftArrow then
    move.x = move.x - 2
  end

  if Input.Cancel > 0 and not key.active then
    div = div*2
  end
  if key.active then
    div = div*2/3
  end

  Player.Move(move.x/div,move.y/div)
end

function self.Change(list)
  for key, value in pairs(self.sprites) do
    if value ~= nil then
      value.Remove()
    end
    self.sprites[key] = nil
  end
  self.lastKeys = {
    UpArrow = false,
    DownArrow = false,
    RightArrow = false,
    LeftArrow = false,
    active = false
  }

  if not (#self.currentSoul == 1 and self.currentSoul[1] == "red") then
    for i = 1, #self.currentSoul do
      if self.currentSoul[i] ~= 'orange' then
        self[self.currentSoul[i]].Quit()
      end
    end
  end

  if list ~= nil then
    self.Init(list)
  else
    self.Init({"red"})
  end
end

function self.orangeKey(force) -- オレンジソウル用キーコントロール
  if not force and Input.GetKey('UpArrow') <= 0 and Input.GetKey('DownArrow') <= 0 and Input.GetKey('RightArrow') <= 0 and Input.GetKey('LeftArrow') <= 0 then
    return
  else
    self.lastKeys = {
      UpArrow = Input.GetKey('UpArrow') > 0,
      DownArrow = Input.GetKey('DownArrow') > 0,
      RightArrow = Input.GetKey('RightArrow') > 0,
      LeftArrow = Input.GetKey('LeftArrow') > 0,
      active = true
    }
  end
end

return self