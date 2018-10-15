local _VERSION = require("hostcheck.version")
local dns = require("hostcheck.dns")
local resolve
resolve = dns.resolve
local checkone
checkone = function(ip, host)
  local answers, err = resolve(host)
  if not answers then
    return nil, error("failed to resolve dns: " .. (err or "unknown"))
  end
  for _index_0 = 1, #answers do
    local item = answers[_index_0]
    if (item == ip) then
      return item
    end
  end
  return nil, answers
end
return {
  checkone = checkone,
  _VERSION = _VERSION
}
