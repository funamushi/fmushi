BROWSERIFY = ./node_modules/.bin/browserify
WATCHIFY    = ./node_modules/.bin/watchify
BUILD_DIR 	= public/js
BUNDLE 		= $(BUILD_DIR)/bundle.js
ENTRY		= src/client/index.js

SRC = $(ENTRY)
ifneq ($(wildcard src/client/lib),)
  SRC += $(shell find src/client/lib -type f -name '*.js')
endif

.PHONY: all clean info

all: $(BUNDLE)

clean:
	rm -f $(BUNDLE)

info:
	@echo "Source:" $(SRC)

watch:
	$(WATCHIFY) -t babelify $(ENTRY) --verbose -o $(BUNDLE)

$(BUILD_DIR):
	mkdir -p $(BUILD_DIR)

$(BUNDLE): $(BUILD_DIR) $(SRC)
	$(BROWSERIFY) $(ENTRY) -t babelify --debug --verbose -o $@

