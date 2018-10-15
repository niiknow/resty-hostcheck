_VERSION  = require "resty.hostcheck.version"
dns       = require "resty.hostcheck.dns"

import resolve from dns

class HostCheck
    new: (opts={}) =>
        @_VERSION = _VERSION
        opts = opts or {}
        defOpts = {
            ip: "127.0.0.1",
            nameservers: {"127.0.0.1"}
        }
        opts.ip = opts.ip or defOpts.ip
        opts.nameservers = opts.nameservers or defOpts.nameservers
        @options = opts

    oneip: (host, ip = nil) =>
        ip = ip or @options.ip
        answers, err = resolve(host, @options.nameservers)

        if not answers
            return nil, error("failed to resolve dns: " .. (err or "unknown"))

        for item in *answers
            if (item == ip)
                return item

        nil, answers

HostCheck
