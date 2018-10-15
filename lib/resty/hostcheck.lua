local _VERSION = require("resty.hostcheck.version")
local dns = require("resty.hostcheck.dns")
local resolve
resolve = dns.resolve
local oneip
oneip = function(ip, host)
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
  oneip = oneip,
  _VERSION = _VERSION
}
