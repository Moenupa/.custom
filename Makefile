SRC_DIR  := complgen
DEST_DIR := completions
COMPLGEN_VERSION := $(shell complgen --version 2>/dev/null || echo "NotInstalled")

# .usage files as sources
USAGE_FILES := $(wildcard $(SRC_DIR)/*.usage)
USAGE_NAMES := $(basename $(notdir $(USAGE_FILES)))

# artifact targets
BASH_COMPLETIONS := $(addprefix $(DEST_DIR)/,$(addsuffix .bash,$(USAGE_NAMES)))
ZSH_COMPLETIONS  := $(addprefix $(DEST_DIR)/_,$(USAGE_NAMES))
FISH_COMPLETIONS := $(addprefix $(DEST_DIR)/,$(addsuffix .fish,$(USAGE_NAMES)))
GENERATED_COMPLETIONS := $(BASH_COMPLETIONS) $(ZSH_COMPLETIONS) $(FISH_COMPLETIONS)

.DEFAULT_GOAL := all
.PHONY: check clean gen gen-bash gen-zsh gen-fish all

# Print the commands that would run, without generating files.
check:
	@echo ---------------------------------- Build Info ----------------------------------
	@echo complegen@$(COMPLGEN_VERSION) \(https://github.com/adaszko/complgen\)
	@for file in $(USAGE_FILES); do \
		echo "       -> $$file"; \
	done
	@echo --------------------------------------------------------------------------------
	@if ! command -v complgen >/dev/null 2>&1; then exit 1; fi

clean:
	@for target in $(GENERATED_COMPLETIONS); do \
		if [ -e "$$target" ] || [ -L "$$target" ]; then \
			echo "rm $$target"; \
			rm -f -- "$$target"; \
		fi; \
	done

gen-bash: check $(BASH_COMPLETIONS)
gen-zsh: check $(ZSH_COMPLETIONS)
gen-fish: check $(FISH_COMPLETIONS)
gen: check $(GENERATED_COMPLETIONS)
all: check clean gen

# deriv rules following complgen cmd interface
$(DEST_DIR):
	mkdir -p $@
$(DEST_DIR)/%.bash: $(SRC_DIR)/%.usage | $(DEST_DIR)
	complgen --bash $@ $<
$(DEST_DIR)/_%: $(SRC_DIR)/%.usage | $(DEST_DIR)
	complgen --zsh $@ $<
$(DEST_DIR)/%.fish: $(SRC_DIR)/%.usage | $(DEST_DIR)
	complgen --fish $@ $<
