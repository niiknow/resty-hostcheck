package = "resty-hostcheck"
version = "dev-1"

source = {
	url = "git://github.com/niiknow/resty-hostcheck.git"
}

description = {
	summary = "Host validation for openresty",
	homepage = "https://niiknow.github.io/resty-hostcheck",
	maintainer = "Tom Noogen <friends@niiknow.org>",
	license = "MIT"
}

dependencies = {
	"lua ~> 5.1",

	"ansicolors",
	"date",
	"etlua",
	"loadkit",
	"lpeg"

}

build = {
	type = "builtin",
	modules = {
		["hostcheck"] = "lib/resty/hostcheck/init.lua"
	}
}

