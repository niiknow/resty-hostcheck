_VERSION  = require "hostcheck.version"
dns       = require "hostcheck.dns"

import resolve from dns

checkone = (ip, host) ->
    answers, err = resolve(host)
    if not answers
        return nil, error("failed to resolve dns: " .. (err or "unknown"))

    for item in *answers
        if (item == ip)
            return item

    nil, answers

{ :checkone , :_VERSION }
