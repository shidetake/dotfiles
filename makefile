MAKEFLAGS += --no-print-directory

install:
	-make link SOURCE:=$(CURDIR)/.config               TARGET:=$(HOME)/.config
	-make link SOURCE:=$(CURDIR)/.config/nvim/init.vim TARGET:=$(HOME)/.vimrc
	-make link SOURCE:=$(CURDIR)/.gvimrc               TARGET:=$(HOME)/.gvimrc
	-make link SOURCE:=$(CURDIR)/.bashrc               TARGET:=$(HOME)/.bashrc
	-make link SOURCE:=$(CURDIR)/.zshrc                TARGET:=$(HOME)/.zshrc
	-make link SOURCE:=$(CURDIR)/.zprofile             TARGET:=$(HOME)/.zprofile
	-make link SOURCE:=$(CURDIR)/.bash_aliases         TARGET:=$(HOME)/.bash_aliases
	-make link SOURCE:=$(CURDIR)/.bash_profile         TARGET:=$(HOME)/.bash_profile
	-make link SOURCE:=$(CURDIR)/.gitconfig            TARGET:=$(HOME)/.gitconfig
	-make link SOURCE:=$(CURDIR)/.gitignore            TARGET:=$(HOME)/.gitignore
	-make link SOURCE:=$(CURDIR)/.gitmessage           TARGET:=$(HOME)/.gitmessage
	-make link SOURCE:=$(CURDIR)/.git-completion.bash  TARGET:=$(HOME)/.git-completion.bash
	-make link SOURCE:=$(CURDIR)/.git-prompt.sh        TARGET:=$(HOME)/.git-prompt.sh
	-make link SOURCE:=$(CURDIR)/.rubocop.yml          TARGET:=$(HOME)/.rubocop.yml
	-make link SOURCE:=$(CURDIR)/.ptignore             TARGET:=$(HOME)/.ptignore
ifeq ($(OS),Windows_NT)
	-make link SOURCE:=$(CURDIR)/.gitconfig.windows    TARGET:=$(HOME)/.gitconfig.os
	-make link SOURCE:=$(CURDIR)/.bashrc.windows       TARGET:=$(HOME)/.bashrc.os
	-make link SOURCE:=$(CURDIR)/.bash_aliases.windows TARGET:=$(HOME)/.bash_aliases.os
else
	-make link SOURCE:=$(CURDIR)/.gitconfig.mac        TARGET:=$(HOME)/.gitconfig.os
	-make link SOURCE:=$(CURDIR)/.bashrc.mac           TARGET:=$(HOME)/.bashrc.os
	-make link SOURCE:=$(CURDIR)/.bash_aliases.mac     TARGET:=$(HOME)/.bash_aliases.os
endif

link:
ifeq ($(OS),Windows_NT)
	@cmd.exe /C if not exist $(subst /,\,$(TARGET)) \
		cmd.exe /C mklink $(subst /,\,$(TARGET)) $(subst /,\,$(SOURCE))
else
	@if [ ! -e $(TARGET) ]; then\
		ln -s $(SOURCE) $(TARGET);\
	fi
endif
