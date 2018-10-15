OPENRESTY_PREFIX=/usr/local/openresty

PREFIX ?=          /usr/local
LUA_INCLUDE_DIR ?= $(PREFIX)/include
LUA_LIB_DIR ?=     $(PREFIX)/lib/lua/$(LUA_VERSION)
INSTALL ?= install

.PHONY: all install test build local global test-spec clean doc

all: build ;

install: all
	$(INSTALL) -d $(DESTDIR)/$(LUA_LIB_DIR)/resty/hostcheck
	$(INSTALL) lib/resty/*.* $(DESTDIR)/$(LUA_LIB_DIR)/resty
	$(INSTALL) lib/resty/hostcheck/*.* $(DESTDIR)/$(LUA_LIB_DIR)/resty/hostcheck

test: all
	PATH=$(OPENRESTY_PREFIX)/nginx/sbin:$$PATH prove -I../test-nginx/lib -r t

build:
	cd lib && $(MAKE) build

local: build
	luarocks make --force --local resty-hostcheck-0.2-0.rockspec

global: build
	sudo luarocks make resty-hostcheck-0.2-0.rockspec

test-spec:
	cd lib && $(MAKE) test

clean:
	rm -rf doc/
	rm -rf t/servroot/

doc:
	cd lib && $(MAKE) doc
