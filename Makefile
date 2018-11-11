
NODE_DIR := target/node
NODE_DIR_ABS := $(CURDIR)/$(NODE_DIR)
NODE_MODULES_DIR := $(NODE_DIR)/lib/node_modules
NODE_MODULES_DIR_ABS := $(CURDIR)/$(NODE_MODULES_DIR)

target:
	mkdir target

$(NODE_DIR): target
	cd target && curl 'https://nodejs.org/dist/v10.13.0/node-v10.13.0-linux-x64.tar.xz' | tar xJ \
	  && mv node-v10.13.0-linux-x64 node
	touch $@

$(NODE_MODULES_DIR)/%: export PATH := $(NODE_DIR_ABS)/bin:$(PATH)
$(NODE_MODULES_DIR)/%: export NODE_PATH := $(NODE_MODULES_DIR_ABS)

$(NODE_MODULES_DIR)/minimist $(NODE_MODULES_DIR)/puppeteer-core: $(NODE_DIR)
	npm install -g puppeteer-core minimist

dep: $(NODE_MODULES_DIR)/minimist $(NODE_MODULES_DIR)/puppeteer-core

.PHONY: test clean dep