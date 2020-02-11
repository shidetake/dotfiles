MAKEFLAGS += --no-print-directory
MKDIR := cmd.exe /C mkdir

install:
	-make link SOURCE:=$(CURDIR)/.config               TARGET:=$(HOME)/.config
	-make link SOURCE:=$(CURDIR)/.config/nvim/init.vim TARGET:=$(HOME)/.vimrc
	-make link SOURCE:=$(CURDIR)/.gvimrc               TARGET:=$(HOME)/.gvimrc
	-make link SOURCE:=$(CURDIR)/.bashrc               TARGET:=$(HOME)/.bashrc
	-make link SOURCE:=$(CURDIR)/.bash_profile         TARGET:=$(HOME)/.bash_profile
	-make link SOURCE:=$(CURDIR)/.gitconfig            TARGET:=$(HOME)/.gitconfig
	-make link SOURCE:=$(CURDIR)/.gitignore            TARGET:=$(HOME)/.gitignore
	-make link SOURCE:=$(CURDIR)/.gitmessage           TARGET:=$(HOME)/.gitmessage
	-make link SOURCE:=$(CURDIR)/.git-completion.bash  TARGET:=$(HOME)/.git-completion.bash
	-make link SOURCE:=$(CURDIR)/.git-prompt.sh        TARGET:=$(HOME)/.git-prompt.sh
	-make link SOURCE:=$(CURDIR)/.rubocop.yml          TARGET:=$(HOME)/.rubocop.yml

link:
ifeq ($(OS),Windows_NT)
	@cmd.exe /C if not exist $(subst /,\,$(TARGET)) \
		cmd.exe /C mklink $(subst /,\,$(TARGET)) $(subst /,\,$(SOURCE))
else
	@if [ ! -e $(TARGET) ]; then\
		ln -s $(SOURCE) $(TARGET);\
	fi
endif
