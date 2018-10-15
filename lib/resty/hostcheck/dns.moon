resolver = require "resty.dns.resolver"
lrucache = require "resty.lrucache"

CACHE_SIZE        = 10000
MAXIMUM_TTL_VALUE = 2147483647 -- maximum value according to https://tools.ietf.org/html/rfc2181

cache, err        = lrucache.new(CACHE_SIZE)
if (not cache)
    return nil, error("failed to create the cache: " .. (err or "unknown"))

local *
a_records_and_max_ttl = (answers) ->
    addresses = {}
    ttl = MAXIMUM_TTL_VALUE

    for _, ans in ipairs(answers)
        if ans.address
            table.insert(addresses, ans.address)
            if ttl > ans.ttl
                ttl = ans.ttl

    addresses, ttl

resolve = (host, nameservers = nil) ->
    if (nameservers == nil)
        nameservers = {"8.8.8.8", {"8.8.4.4", 53} }
    cached_addresses = cache\get(host)
    if cached_addresses
        message = string.format(
            "addresses %s for host %s was resolved from cache",
            table.concat(cached_addresses, ", "),
            host
        )

        ngx.log(ngx.INFO, message)
        return cached_addresses

    r, err = resolver\new(
        nameservers: nameservers,
        retrans: 5
        timeout: 2000  -- 2 sec
    )

    if not r
        ngx.log(ngx.ERR, "failed to instantiate the resolver: " .. tostring(err))
        return nil, { host }

    answers, err = r\query(host, { qtype: r.TYPE_A }, {})
    if not answers
        ngx.log(ngx.ERR, "failed to query the DNS server: " .. tostring(err))
        return nil, { host }

    if answers.errcode
        ngx.log(ngx.ERR, string.format("server returned error code: %s: %s", answers.errcode, answers.errstr))
        return nil, { host }

    addresses, ttl = a_records_and_max_ttl(answers)
    if #addresses == 0
        ngx.log(ngx.ERR, "no A record resolved")
        return nil, { host }

    cache\set(host, addresses, ttl)
    addresses

{ :resolve }
