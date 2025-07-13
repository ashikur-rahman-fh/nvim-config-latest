# Terminal color codes
RED=\033[0;31m
GREEN=\033[0;32m
BLUE=\033[0;34m
NC=\033[0m

# Constants
NVIM_CONFIG_DIR ?= $(HOME)/.config/nvim
LUA_CONFIG_DIR ?= $(NVIM_CONFIG_DIR)/lua/ash

# Logging macros
define log_success
  echo "$(GREEN)[✔] $(1)$(NC)"
endef

define log_error
  echo "$(RED)[✘] $(1)$(NC)"
endef

define log_event
  echo "$(BLUE)[→] $(1)$(NC)"
endef

help:
	@$(call log_error,Please run make with specific option. i.e. make install.)
	@echo "Available options:"
	@echo "  clean"
	@echo "  install"

# Cleanup
clean:
	@rm -rf 	~/.local/share/nvim \
						~/.cache/nvim	\
						~/.local/state/nvim
	@$(call log_success,All config and cache are cleared.)

# Packer Plugin Manager
define clone_packer_cmd
	git clone --depth 1 https://github.com/wbthomason/packer.nvim ~/.local/share/nvim/site/pack/packer/start/packer.nvim > /dev/null 2>&1
endef

clone_packer:
	@$(call log_event,Checking for packer...)
	@if [ -d ~/.local/share/nvim/site/pack/packer/start/packer.nvim ]; then \
		$(call log_success,Packer is already installed. Skipping...); \
	else \
		$(call log_event,Installing packer...); \
		$(clone_packer_cmd) && \
		$(call log_success,Packer installed successfully.); \
	fi

update_packer:
	@$(call log_event,Removing packer...)
	@rm -rf ~/.local/share/nvim/site/pack/packer/start/packer.nvim
	@$(call log_event,Cloning packer...)
	@$(clone_packer_cmd)
	@$(call log_success,Packer updated successfully.)

remove_packer:
	@$(call log_event,Removing packer...)
	@rm -rf ~/.local/share/nvim/site/pack/packer/start/packer.nvim
	@$(call log_success,Packer removed.)

packer_sync:
	@$(call log_event,Running PackerSync)
	@nvim --headless -c "luafile $(LUA_CONFIG_DIR)/packer.lua" -c "autocmd User PackerComplete quitall" -c "PackerSync" > /dev/null 2>&1

	@$(call log_success,PackerSync was successful.)
move_after_to_tmp:
	@$(call log_event,Moving 'after' directory to 'after.tmp'...)
	@mv $(NVIM_CONFIG_DIR)/after $(NVIM_CONFIG_DIR)/after.tmp 2>/dev/null || true

move_tmp_to_after:
	@$(call log_event,Moving 'after.tmp' back to 'after' directory...)
	@mv $(NVIM_CONFIG_DIR)/after.tmp $(NVIM_CONFIG_DIR)/after 2>/dev/null || true

install:
	@$(MAKE) -s move_after_to_tmp
	@$(MAKE) -s clone_packer
	@$(MAKE) -s packer_sync
	@$(MAKE) -s move_tmp_to_after
