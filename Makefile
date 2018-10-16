VERSION          = 0.3.2
OPENRESTY_PREFIX =/usr/local/openresty
PREFIX          ?=          /usr/local
LUA_INCLUDE_DIR ?= $(PREFIX)/include
LUA_LIB_DIR     ?=     $(PREFIX)/lib/lua/$(LUA_VERSION)
INSTALL         ?= install

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
	luarocks make --force --local resty-hostcheck-master-1.rockspec

global: build
	sudo luarocks make resty-hostcheck-master-1.rockspec

test-spec:
	cd lib && $(MAKE) test

clean:
	rm -rf doc/
	rm -rf t/servroot/
	cd lib && $(MAKE) clean

init:
	cd lib && $(MAKE) init

doc:
	cd lib && $(MAKE) doc

upload:
	@rm -f *-0.**.rockspec*
	@sed -e "s/master/$(VERSION)/g" resty-hostcheck-master-1.rockspec > resty-hostcheck-$(VERSION)-1.rockspec
	@echo "luarocks upload resty-hostcheck-$(VERSION)-1.rockspec --api-key=?"
