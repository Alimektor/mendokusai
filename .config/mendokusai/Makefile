.PHONY: all install script

all: install

install: ## Install mendokusai
	bash -e $(HOME)/.config/mendokusai/install/install.sh

script:
	bash -xe "$(HOME)/.config/mendokusai/install/script.sh"

help: ## Show this help
        @grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[1;32m%-15s \033[1;33m%s\033[0m\n", $$1, $$2}'
