
.PHONY: test build watch clean init doc

test:
	busted -c spec

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
