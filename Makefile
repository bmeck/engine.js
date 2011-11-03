SHELL := /bin/bash
BUILD_ID := build-$(shell date +'%s')
BUILD_BASEDIR=../engine.js-builds
BUILD_DIR = $(BUILD_BASEDIR)/$(BUILD_ID)
MKDIR = mkdir -p
NODE_VERSION ?= v0.4.12
GOTO_BUILD_DIR = cd $(BUILD_DIR); source ~/.nvm/nvm.sh; nvm use $(NODE_VERSION); 
all: test

test: unit-test end-to-end-test

unit-test:
	jasmine-node spec/engine/
	jasmine-node spec/mixins/

end-to-end-test: deploy
	$(GOTO_BUILD_DIR) jasmine-node node_modules/engine.js/spec/end-to-end/basic_spec.js
	$(GOTO_BUILD_DIR) jasmine-node node_modules/engine.js/spec/end-to-end/errors_spec.js
	$(GOTO_BUILD_DIR) jasmine-node node_modules/engine.js/spec/end-to-end/configuration_spec.js

deploy:
	$(MKDIR) $(BUILD_DIR)
	$(GOTO_BUILD_DIR) npm install --dev ../../robust.js

clean:
	rm -r $(BUILD_BASEDIR)
	rm *.ipc
