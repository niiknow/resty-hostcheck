
.PHONY: test local build global watch clean

test:
	busted -c spec

local: build
	luarocks make --force --local resty-hostcheck-dev-1.rockspec

global: build
	sudo luarocks make resty-hostcheck-dev-1.rockspec

build:
	moonc resty

watch: build
	moonc -w resty

clean: build
	rm $$(find ./ | grep \.lua$$)

init:
	luarocks install busted
	luarocks install moonscript

doc: clean
	ldoc .
