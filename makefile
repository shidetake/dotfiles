MKDIR := cmd.exe /C mkdir

install:
ifeq ($(OS),Windows_NT)
	-$(MKDIR)  $(HOME)\.config\nvim
ifndef XDG_CONFIG_HOME
	-cmd.exe /C setx /M XDG_CONFIG_HOME $(HOME)\.config\\
endif
else
	-mkdir -p ~/.config/nvim
endif
	-make link SOURCE:=~/dotfiles/.vimrc               TARGET:=~/.vimrc
	-make link SOURCE:=~/dotfiles/.vimrc               TARGET:=~/.config/nvim/init.vim
	-make link SOURCE:=~/dotfiles/.gvimrc              TARGET:=~/.gvimrc
	-make link SOURCE:=~/dotfiles/.bashrc              TARGET:=~/.bashrc
	-make link SOURCE:=~/dotfiles/.bash_profile        TARGET:=~/.bash_profile
	-make link SOURCE:=~/dotfiles/.gitconfig           TARGET:=~/.gitconfig
	-make link SOURCE:=~/dotfiles/.gitignore           TARGET:=~/.gitignore
	-make link SOURCE:=~/dotfiles/.git-completion.bash TARGET:=~/.git-completion.bash
	-make link SOURCE:=~/dotfiles/.git-prompt.sh       TARGET:=~/.git-prompt.sh
	-make link SOURCE:=~/dotfiles/ftdetect             TARGET:=~/.config/nvim/ftdetect
	-make link SOURCE:=~/dotfiles/syntax               TARGET:=~/.config/nvim/syntax

link:
ifeq ($(OS),Windows_NT)
	@if not exist $(TARGET) (
		cmd.exe /C mklink $(TARGET) $(SOURCE)
	)
else
	@if [ ! -e $(TARGET) ]; then\
		ln -s $(SOURCE) $(TARGET);\
	fi
endif
