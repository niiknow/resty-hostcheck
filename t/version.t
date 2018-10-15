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

=== TEST 1: hostcheck version
--- http_config eval: $::HttpConfig
--- config
	location /t {
		content_by_lua '
			local hc = (require "resty.hostcheck")()
			ngx.say(hc._VERSION)
		';
	}
--- request
	GET /t
--- response_body_like chop
^\d+\.\d+\.\d+$
--- no_error_log
[error]


