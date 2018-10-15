_VERSION  = require "hostcheck.version"
dns       = require "hostcheck.dns"

import resolve from dns

checkone = (ip, host) ->
    answers, err = resolve(host)
    for item in *answers
        if (item == ip)
            return item

    nil, answers

{ :checkone , :_VERSION }
