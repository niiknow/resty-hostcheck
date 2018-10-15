_VERSION  = require "resty.hostcheck.version"
dns       = require "resty.hostcheck.dns"

import resolve from dns

oneip = (ip, host) ->
    answers, err = resolve(host)
    if not answers
        return nil, error("failed to resolve dns: " .. (err or "unknown"))

    for item in *answers
        if (item == ip)
            return item

    nil, answers

{ :oneip , :_VERSION }
