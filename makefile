SHELL := /bin/bash

help:
	@grep -E '^[ a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | \
	awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-15s\033[0m %s\n", $$1, $$2}'

ifndef LIGO
LIGO=ligo
endif
# ^ use LIGO en var bin if configured, otherwise use docker

compile = $(LIGO) compile contract  --project-root ./src ./src/$(1) -o ./compiled/$(2) $(3) 
# ^ Compile contracts to Michelson or Micheline

test = @$(LIGO) run test $(project_root) ./test/$(1) --no-warn
# ^ run given test file


.PHONY: test compile
compile: ## compile contracts to Michelson
	@mkdir -p compiled
	@$(call compile,contract.mligo,contract.tz, -m C)
	@$(call compile,contract.mligo,contract.mligo.json, -m C --michelson-format json)


test: ## run tests (SUITE=asset_approve make test)
ifndef SUITE
	@$(call test,contract.test.mligo)
# @$(call test,FA2_caller.test.mligo)

else
	@$(call test,$(SUITE).test.mligo)
endif


deploy: deploy_deps deploy.js ## deploy contract

deploy.js:
	@echo "Running deploy script\n"
	@cd deploy && npm i && npm run deploy_contract

deploy_deps:
	@echo "Installing deploy script dependencies"
	@cd deploy && npm install
	@echo ""

install:
	@$(LIGO) install