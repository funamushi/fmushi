BUILD_DIR 	= public/js
BUNDLE 		= $(BUILD_DIR)/bundle.js
ENTRY		= client/index.js

SRC = $(ENTRY)
ifneq ($(wildcard client/lib),)
  SRC += $(shell find client/lib -type f -name '*.js')
endif

.PHONY: all clean info

all: $(BUNDLE)

clean:
	rm -f $(BUNDLE)

info:
	@echo "Source:" $(SRC)

$(BUILD_DIR):
	mkdir -p $(BUILD_DIR)

$(BUNDLE): $(BUILD_DIR) $(SRC)
	./node_modules/.bin/browserify $(ENTRY) -t babelify --debug --verbose -o $@

