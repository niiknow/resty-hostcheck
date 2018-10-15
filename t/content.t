# vim:set ft= ts=4 sw=4 et fdm=marker:

use Test::Nginx::Socket::Lua;
use Cwd qw(cwd);

repeat_each(2);

plan tests => repeat_each() * (blocks() * 3);

my $pwd = cwd();

our $HttpConfig = qq{
	lua_package_path "$pwd/lib/?.lua;$pwd/?.lua;;";
};

$ENV{TEST_NGINX_RESOLVER} = '8.8.8.8';

no_long_string();
#no_diff();

run_tests();

__DATA__

=== TEST 1: hostcheck valid
--- http_config eval: $::HttpConfig
--- config
	location /t {
		content_by_lua '
			local hostcheck = require "resty.hostcheck"
			local hc = (require "resty.hostcheck")({ip = "192.138.189.150", nameservers = {"8.8.8.8", {"8.8.4.4", 53} }})
			local val, err  = hc:oneip("noogen.org")
			ngx.say(val)
		';
	}
--- request
	GET /t
--- response_body
192.138.189.150
--- no_error_log
[error]


