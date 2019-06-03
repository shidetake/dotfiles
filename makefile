MAKEFLAGS += --no-print-directory
MKDIR := cmd.exe /C mkdir

install:
ifeq ($(OS),Windows_NT)
	@cmd.exe /C if not exist $(HOME)\.config \
		$(MKDIR)  $(HOME)\.config
ifndef XDG_CONFIG_HOME
	-cmd.exe /C setx /M XDG_CONFIG_HOME $(HOME)\.config\\
endif
else
	-mkdir -p ~/.config
endif
	-make link SOURCE:=$(HOME)/dotfiles/nvim                 TARGET:=$(HOME)/.config/nvim
	-make link SOURCE:=$(HOME)/dotfiles/nvim/init.vim        TARGET:=$(HOME)/.vimrc
	-make link SOURCE:=$(HOME)/dotfiles/.gvimrc              TARGET:=$(HOME)/.gvimrc
	-make link SOURCE:=$(HOME)/dotfiles/.bashrc              TARGET:=$(HOME)/.bashrc
	-make link SOURCE:=$(HOME)/dotfiles/.bash_profile        TARGET:=$(HOME)/.bash_profile
	-make link SOURCE:=$(HOME)/dotfiles/.gitconfig           TARGET:=$(HOME)/.gitconfig
	-make link SOURCE:=$(HOME)/dotfiles/.gitignore           TARGET:=$(HOME)/.gitignore
	-make link SOURCE:=$(HOME)/dotfiles/.gitmessage          TARGET:=$(HOME)/.gitmessage
	-make link SOURCE:=$(HOME)/dotfiles/.git-completion.bash TARGET:=$(HOME)/.git-completion.bash
	-make link SOURCE:=$(HOME)/dotfiles/.git-prompt.sh       TARGET:=$(HOME)/.git-prompt.sh
	-make link SOURCE:=$(HOME)/dotfiles/.rubocop.yml         TARGET:=$(HOME)/.rubocop.yml
	-make link SOURCE:=$(HOME)/dotfiles/peco                 TARGET:=$(HOME)/.config/peco

link:
ifeq ($(OS),Windows_NT)
	@cmd.exe /C if not exist $(subst /,\,$(TARGET)) \
		cmd.exe /C mklink $(subst /,\,$(TARGET)) $(subst /,\,$(SOURCE))
else
	@if [ ! -e $(TARGET) ]; then\
		ln -s $(SOURCE) $(TARGET);\
	fi
endif
