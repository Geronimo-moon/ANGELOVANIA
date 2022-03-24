function hsvToRgb(h,s,v)
  local max = v
  local min = max-((s/255)*max)
  rgb = {}

  if 0 <= h and h < 60 then
    rgb = {max,math.floor((h/60)*(max-min)+min),math.floor(min)}
  elseif 60 <= h and h<120 then
    rgb = {math.floor((120-h)/60*(max-min)+min),max,math.floor(min)}
  elseif 120 <= h and h < 180 then
    rgb = {math.floor(min),max,math.floor((120-h)/60*(max-min)+min)}
  elseif 180 <= h and h < 240 then
    rgb = {math.floor(min),math.floor((240-h)/60*(max-min)+min),max}
  elseif 240 <= h and h < 300 then
    rgb = {math.floor((h-240)/60*(max-min)+min),math.floor(min),max}
  else
    rgb = {max,math.floor(min),math.floor((360-h)/60*(max-min)+min)}
  end
  
  for i = 1,3 do
    rgb[i] = rgb[i]/255
  end

  return rgb
end