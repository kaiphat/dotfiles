_G.merge = function(list)
  local result = list[1]

  for i = 2, #list do
    for key, value in pairs(list[i]) do
      result[key] = value
    end
  end

  return result
end
