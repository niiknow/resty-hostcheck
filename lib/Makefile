
.PHONY: test local build global watch clean

test:
	busted -c spec

local: build
	luarocks make --force --local hostcheck-dev-1.rockspec

global: build
	sudo luarocks make hostcheck-dev-1.rockspec

build:
	moonc *.moon
	moonc hostcheck

watch: build
	moonc -w hostcheck

clean: build
	rm $$(find ./ | grep \.lua$$)

init:
	luarocks install busted
	luarocks install moonscript
	luarocks install resty-dns-resolver
	luarocks install resty-lrucache

doc: clean
	ldoc .
