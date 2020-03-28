# Makefile for dotfiles (cf. https://github.com/pix/dotfiles)

DOT_FILE = ${shell find . -maxdepth 1 -type f -a ! -path . -a ! -path './.*' -a ! -name 'Makefile' -a ! -name 'Session.vim' -a ! -name 'crontab' | sed -e 's/\:/\\:/g' -e 's,^\./,,g'} 
DOT_DIR = ${shell find . -maxdepth 1 -type d -a ! -path . -a ! -path './.*' -a ! -name 'config'  -a ! -name 'udev' -a ! -name 'xdm' | sed -e 's/\:/\\:/g' -e 's,^\./,,g'} 
CONFIG_DIR = ${shell find ./config -maxdepth 1 -type d -a ! -path './config' -a ! -path './config/.*' | sed -e 's/\:/\\:/g' -e 's,^\./config/,,g'} 

all: install

install: history $(foreach f, $(DOT_FILE), install-file-$(f)) $(foreach f, $(DOT_DIR), install-dotdir-$(f)) $(foreach f, $(CONFIG_DIR), install-configdir-$(f))

history:
	@echo "  MKDIR Creating ~/.history"
	@mkdir -p $(HOME)/.history 2>/dev/null
	@echo "  MKDIR Creating ~/.vim-tmp"
	@mkdir -p $(HOME)/.vim-tmp/backup 2>/dev/null
	@mkdir -p $(HOME)/.vim-tmp/swap 2>/dev/null

install-configdir-%: config/%
	@echo "  LNDIR  $< to ~/.$<"
	@ln -snf $(CURDIR)/$< $(HOME)/.$<

install-dotdir-%: %
	@echo "  LNDIR  $< to ~/.$<"
	@ln -snf $(CURDIR)/$< $(HOME)/.$<

install-file-%: %
	@echo "  LN  $< to ~/.$<"
	@ln -sf $(CURDIR)/$< $(HOME)/.$<

clean: $(foreach f, $(DOT_DIR), clean-.$(f)) \
       $(foreach f, $(CONFIG_DIR), cleanconfig-$(f)) \
       $(foreach f, $(DOT_FILE), clean-.$(f))

cleanconfig-%:
	@echo "  CLEAN  ~/.config/$*"
	@sh -c "if [ -h ~/.config/$* ]; then rm ~/.config/$*; fi"

clean-%:
	@echo "  CLEAN  ~/$*"
	@sh -c "if [ -h ~/$* ]; then rm ~/$*; fi"

.PHONY : clean

