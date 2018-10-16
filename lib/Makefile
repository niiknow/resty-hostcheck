
.PHONY: test build watch clean init doc

test: build
	busted -c spec

build:
	moonc resty

watch: build
	moonc -w resty

clean: build
	rm $$(find ./ | grep \.lua$$)

init:
	sudo luarocks install busted
	sudo luarocks install moonscript
	sudo luarocks install luacov

doc: clean
	ldoc .
