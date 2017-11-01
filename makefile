MKLINK = cmd.exe /C mklink
MKDIR = cmd.exe /C mkdir

install:
ifeq ($(OS),Windows_NT)
	-$(MKLINK) $(HOME)\.vimrc $(HOME)\dotfiles\.vimrc
	-$(MKDIR)  $(HOME)\.config\nvim
	-$(MKLINK) $(HOME)\.config\nvim\init.vim $(HOME)\dotfiles\.vimrc
ifndef XDG_CONFIG_HOME
	-cmd.exe /C setx /M XDG_CONFIG_HOME $(HOME)\.config\\
endif
	-$(MKLINK) $(HOME)\.gvimrc $(HOME)\dotfiles\.gvimrc
	-$(MKLINK) $(HOME)\.bashrc $(HOME)\dotfiles\.bashrc
	-$(MKLINK) $(HOME)\.bash_profile $(HOME)\dotfiles\.bash_profile
	-$(MKLINK) $(HOME)\.gitconfig $(HOME)\dotfiles\.gitconfig
	-$(MKLINK) $(HOME)\.gitignore $(HOME)\dotfiles\.gitignore
	-$(MKLINK) $(HOME)\.git-completion.bash $(HOME)\dotfiles\.git-completion.bash
	-$(MKLINK) $(HOME)\.git-prompt.sh $(HOME)\dotfiles\.git-prompt.sh
else
	-ln -s ~/dotfiles/.vimrc ~/.vimrc
	-mkdir -p ~/.config/nvim
	-ln -s ~/dotfiles/.vimrc ~/.config/nvim/init.vim
	-ln -s ~/dotfiles/.gvimrc ~/.gvimrc
	-ln -s ~/dotfiles/.bashrc ~/.bashrc
	-ln -s ~/dotfiles/.bash_profile ~/.bash_profile
	-ln -s ~/dotfiles/.gitconfig ~/.gitconfig
	-ln -s ~/dotfiles/.gitignore ~/.gitignore
	-ln -s ~/dotfiles/.git-completion.bash ~/.git-completion.bash
	-ln -s ~/dotfiles/.git-prompt.sh ~/.git-prompt.sh
endif
