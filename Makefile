OPENRESTY_PREFIX=/usr/local/openresty

PREFIX ?=          /usr/local
LUA_INCLUDE_DIR ?= $(PREFIX)/include
LUA_LIB_DIR ?=     $(PREFIX)/lib/lua/$(LUA_VERSION)
INSTALL ?= install

.PHONY: all test test-moon install build

all: build ;

install: all
	$(INSTALL) -d $(DESTDIR)/$(LUA_LIB_DIR)/resty/hostcheck
	$(INSTALL) lib/resty/*.* $(DESTDIR)/$(LUA_LIB_DIR)/resty
	$(INSTALL) lib/resty/hostcheck/*.* $(DESTDIR)/$(LUA_LIB_DIR)/resty/hostcheck

test: all
	PATH=$(OPENRESTY_PREFIX)/nginx/sbin:$$PATH prove -I../test-nginx/lib -r t

build:
	cd lib && $(MAKE) build

test-spec:
	cd lib && $(MAKE) test

clean:
	rm -rf doc/
	rm -rf t/servroot/

doc:
	cd lib && $(MAKE) doc
