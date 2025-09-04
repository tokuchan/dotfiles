#. = Makefile

#. Sean\@Spillane.us

#. Setup support tooling and prepare for stowage.

#. == Introduction

#. This makefile governs the set up and installation of tooling. A principle of
# this makefile is that _all_ dependendant packages that are available as GIT
# repositories are handled as _submodules_, and all submodules are stored in the
# `submodules` directory, which should _never_ be installed via `stow`. When a
# package is to be installed, it _must_ be installed into a stowage directory at
# the top level. This makefile will so arrange the dependent packages to manage
# this.

#. NOTE: I assume that the `stow` tool is _already_ installed and available on
# the target system. Most of the time, I can convince the system owner to go
# along. In case I _can't_, I can make do with a docker image in this repo, but
# that's a last resort and quite a pain to use.

#. == Change Default Shell

#. I need to be able to source shell setup. Therefore, I must change the
# default shell.

SHELL := /bin/sh

#. == Primary Targets

#. Default Target

.PHONY: help # Show help for this Makefile
help::

.PHONY: all # Run all registered build rules
all::

#. Clean Target

.PHONY: clean # Run all *-clean rules
clean::

#. == Utilty Macros

#. Project Root

top := $(shell git rev-parse --show-toplevel)

#. == Submodules

#. All submodules are installed in the `submodules` directory. Therefore, I
# just need to initialize and check them out.

.PHONY: submodules # Check out and synchronize all submodules
submodules:
	git submodule sync
	git submodule init
	git submodule update

#. == Install system dependencies

.PHONY: system-dependencies # Install Ubuntu system dependencies
system-dependencies:
	if test $$(lsb_release -rs | grep '[0-9]') = '22.04'; then \
	       ./ubuntu22.04.install.requirements.sh; \
	       fi
	if test $$(lsb_release -rs | grep '[0-9]') = '24.04'; then \
	       ./ubuntu24.04.install.requirements.sh; \
	       fi

all:: system-dependencies

#. == Build reptyr Package

#. This package provides the reptyr command, which binds a new terminal to a
# running command. This allows one to e.g. reconnect to a backgrounded process
# that was lost when it's containing shell died.

.PHONY: reptyr # Build reptyr package
reptyr: submodules
	cd submodules/reptyr && make install PREFIX=$(top)/reptyr/.local

reptyr-clean:
	rm -rf $(top)/reptyr/

#. == Build Autojump Package

#. This package is in a submodule, so I will need submodules to work with it.
# Otherwise, I just need to install it to the stowage directory. I will put it in
# unidev.

.PHONY: autojump # Build the autojump stow package
autojump: submodules
	cd submodules/autojump && ./install.py -p $(top)/autojump/.local/

.PHONY: autojump-clean # Clean up the autojump stow package
autojump-clean:
	rm -rf $(top)/autojump/

all:: autojump
clean:: autojump-clean

#. == Install go if needed

.PHONY: golang # Build and install the go language tools
golang: go1.22.2.linux-amd64.tar.gz .golang.installed

.golang.installed:
	mkdir -p $(HOME)/.local/go
	rm -rf $(HOME)/.local/go && tar -C $(HOME)/.local -xf go1.22.2.linux-amd64.tar.gz
	touch .golang.installed

go1.22.2.linux-amd64.tar.gz:
	wget https://go.dev/dl/go1.22.2.linux-amd64.tar.gz

.PHONY: golang-clean # Clean up the go language installation
golang-clean:
	rm -rf $(HOME)/.local/go
	rm -f go1.22.2.linux-amd64
	rm -f .golang.installed

all:: golang
clean:: golang-clean

#. == Install lazygit (go package)

.PHONY: lazygit # Build the lazygit stow package
lazygit: GOBIN := $(top)/lazygit/.local/bin/
lazygit: GO := $(HOME)/.local/go/bin/go
lazygit: golang
	if command -v $(GO); \
	then \
		cd submodules/lazygit && GOBIN=$(GOBIN) $(GO) install; \
	else \
		echo 'Go not installed.'; \
	fi

all:: lazygit

#. == Set up dark theme for gitk

.PHONY: gitk # Install dark theme for gitk 
gitk: submodules 
	mkdir -p $(top)/git-config/.config/git
	cp $(top)/submodules/dracula-gitk/gitk $(top)/git-config/.config/git/

all:: gitk

#. == Install lazydocker (go package)

.PHONY: lazydocker # Build the lazydocker stow package
lazydocker: GOBIN := $(top)/lazydocker/.local/bin/
lazydocker: GO := $(HOME)/.local/go/bin/go
lazydocker: golang
	if command -v $(GO); \
	then \
		cd submodules/lazydocker && GOBIN=$(GOBIN) $(GO) install; \
	else \
		echo 'Go not installed.'; \
	fi

all:: lazydocker

#. == Build lastpass-cli package for stow

.PHONY: lastpass-cli # Build the lastpass-cli stow package
lastpass-cli: submodules
	mkdir -p lastpass-cli/.local
	cd submodules/lastpass-cli \
		&& cmake -DCMAKE_INSTALL_PREFIX:PATH=$(top)/lastpass-cli/.local/ -S . -B build \
		&& cmake --build build \
		&& cmake --build build -t install

.PHONY: lastpass-cli-clean # Clean up the lastpass-cli package
	cd submodules/lastpass-cli && make clean

all:: lastpass-cli
clean:: lastpass-cli-clean

#. == Build Rust Package
# This package requires I configure and run a special installer, which
# downloads and installs Rust from the official project pages. As usual, I will
# install it to a stowage directory.

.PHONY: rust # Build and install the rust language, and also build the rust configuration stow package
rust: export CARGO_HOME := $(shell readlink -f ./rust/.local/share/rust/cargo)
rust: export RUSTUP_HOME := $(shell readlink -f ./rust/.local/share/rust/rustup)
rust: rustup := $(CARGO_HOME)/bin/rustup
rust: rust/.local/share/rust/rustup.sh
	if command -v rustup; \
	then \
		echo 'Rust installed already.'; \
	else \
		./rust/.local/share/rust/rustup.sh --no-modify-path -q -y --default-toolchain stable; \
		mkdir -p rust/.local/share/bash-completion/completions; \
		$(rustup) completions bash > rust/.local/share/bash-completion/completions/rustup; \
		mkdir -p rust/.config/fish/completions; \
		$(rustup) completions fish > rust/.config/fish/completions/rustup.fish; \
		$(rustup) default stable-x86_64-unknown-linux-gnu; \
	fi
	stow rust

define run-cargo
  source /home/seans/dotfiles/rust/.local/share/rust/cargo/env && cargo $1
endef

define run-rusty
  $$HOME/.cargo/bin/$1
endef

.PHONY: rust-clean # Clean up the rust language stow package
rust-clean:
	rm -rf rust/.local/share/rust/rustup
	rm -rf rust/.local/share/rust/cargo

all:: rust
clean:: rust-clean

#. == Install jujitsu VCS program

#. This package requires rust to complete, and offers a VCS interface on top of
# git.

.PHONY: jujitsu # Build and install the jujitsu repo manager
jujitsu: rust
	$(call run-cargo,install --locked --bin jj jj-cli)

all:: jujitsu

#. == Install typest text processor

.PHONY: typest # Build and install the typest document processor
typest: rust
	$(call run-cargo,install --git https://github.com/typst/typst typst-cli)

all:: typest

#. == Install just command runner

.PHONY: just # Build and install the just command runner
just: rust
	$(call run-cargo,install just)

all:: just

#. == Build and prepare the neovide package.

.PHONY: neovide # Build the neovide editor and install it to the neovide stow package
neovide: submodules/neovide/target/release/neovide
	mkdir -p neovide/.local/bin
	cp submodules/neovide/target/release/neovide neovide/.local/bin/neovide

.PHONY: neovide-clean # Clean up the neovide stow package
neovide-clean:
	rm -rf neovide

submodules/neovide/target/release/neovide: rust
	cd submodules/neovide && $(call run-cargo,build --release) 

all:: neovide
clean:: neovide-clean

.PHONY: evcxr # Build and install the evcxr rust REPL
evcxr: rust
	$(call run-cargo,install evcxr_repl)

all:: evcxr

.PHONY: bacon # Build and install bacon rust build watch program
bacon: rust
	$(call run-cargo,install bacon)

all:: bacon

.PHONY: zoxide # Build and install the zoxide tool, and prepare the zoxide configuration stow package
zoxide: rust
	$(call run-cargo,install zoxide)
	mkdir -p zoxide/.config/fish/conf.d
	mkdir -p zoxide/.bashrc.d
	$(call run-rusty,zoxide init --cmd=cd fish > zoxide/.config/fish/conf.d/zoxide.fish)
	$(call run-rusty,zoxide init --cmd=cd bash > zoxide/.bashrc.d/zoxide.bash)

all:: zoxide

.PHONY: diffr # Build and install diffr, to enhance git diffs
diffr: rust
	$(call run-cargo,install diffr)
all:: diffr

.PHONY: lsd # Build and install the lsd enhanced directory lister
lsd: rust
	$(call run-cargo,install --git https://github.com/lsd-rs/lsd.git --branch master)

all:: lsd

.PHONY: nu # Build and install the nu shell
nu: rust
	cd submodules/nu/nushell \
		&& $(call run-cargo,build --release --workspace) \
		&& $(call run-cargo,install --path .) \
		&& mkdir -p $(top)/receipts \
		&& touch $(top)/receipts/nu-installed
all:: nu

.PHONY: nu_plugin_bash_env
nu_plugin_bash_env: nu

.PHONY: git-branchless # Build and install git-branchless to make git better
git-branchless: rust
	cargo install --locked git-branchless

all:: git-branchless

#. == Build the neovim package

.PHONY: neovim # Build the neovim editor and install it to the neovim stow package
neovim: neovim/.local/bin/nvim

neovim/.local/bin/nvim:
	mkdir -p neovim/.local/bin
	cd submodules/neovim \
		&& make CMAKE_BUILD_TYPE=RelWithDebInfo CMAKE_INSTALL_PREFIX=$(top)/neovim/.local/ install

.PHONY: neovim-clean # Clean up the neovim submodule and installation target
neovim-clean:
	rm -rf $(top)/neovim
	cd submodules/neovim && make clean

all:: neovim
clean:: neovim-clean

#. == Build emacs 29+

.PHONY: emacs # Build the EMACS editor and install it to the emacs stow package
emacs: submodules/emacs/Makefile
	make -C submodules/emacs -j 20 install

submodules/emacs/Makefile: submodules/emacs/configure
	cd submodules/emacs && ./configure --with-native-compilation --with-x --with-xwidgets --with-tree-sitter --prefix=$(top)/emacs/.local/
	#cd submodules/emacs && ./configure --with-native-compilation=yes --with-x --prefix=$(top)/emacs/.local/

submodules/emacs/configure: submodules/emacs/configure.ac submodules/emacs/autogen.sh
	cd submodules/emacs && ./autogen.sh

.PHONY: emacs-clean # Clean up the emacs submodule and installation target
emacs-clean:
	cd submodules/emacs && git reset --hard HEAD
	rm -rf emacs
	mkdir -p emacs/.local

all:: emacs
clean:: emacs-clean

#. == Install late-model node and npm (for EMACS lsp servers)

#. It so happens that many of the LSP modules are written in JS, and require a
# late model of node to work properly. Unfortunately, the underlying OS tends to
# lag far behind, so I install it manually here.

define nvm_install_config_bash
export NVM_DIR="$$HOME/.nvm"
[ -s "$$NVM_DIR/nvm.sh" ] && \. "$$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$$NVM_DIR/bash_completion" ] && \. "$$NVM_DIR/bash_completion"  # This loads nvm bash_completion
endef
export nvm_install_config_bash
PROFILE:=/dev/null
export PROFILE

.nvm-install: system-dependencies
	curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
	echo "$$nvm_install_config_bash" > $$HOME/.bashrc.d/nvm.bashrc
	touch .nvm-install

.PHONY: node-install # Install latest node.js system
node-install: .nvm-install
	bash --login -c 'source $$HOME/.nvm/nvm.sh && nvm install 20'

all:: node-install

#. Set up git-repo symlink for install

repo:
	mkdir -p repo/.local/bin
	ln -s $$(readlink -f ./submodules/git-repo/repo) repo/.local/bin/repo

repo-clean:
	rm -rf repo

all:: repo
clean:: repo-clean

#. == Install `entr` for convenient auto-refreshing commands

#. The entr program watches paths and runs commands when they change.

.PHONY: entr
entr: entr/.local/bin/entr

entr/.local/bin/entr: submodules/entr/configure system-dependencies
	cd submodules/entr \
		&& ./configure \
		&& CFLAGS='-static' make test \
		&& PREFIX='$(top)/entr/.local' make install

.PHONY: entr-clean
entr-clean:
	- rm .entr-receipt
	- rm -rf entr
	- cd submodules/entr && make clean

all:: entr
clean:: entr-clean

#. == Install neofetch system-information viewer

.PHONY: neofetch
neofetch: neofetch/.local/bin/neofetch

neofetch/.local/bin/neofetch: submodules/neofetch/Makefile system-dependencies
	cd submodules/neofetch \
		&& make PREFIX=$(top)/neofetch/.local install

.PHONY:neofetch-clean
neofetch-clean:
	- rm -rf neofetch
	- cd submodules/neofetch && make clean

all:: neofetch
clean:: neofetch-clean

#. == Install toolchest collection

.PHONY: toolchest
toolchest: submodules submodules/toolchest/README.md
	rm -rf toolchest
	mkdir -p toolchest
	cp --remove-destination -R submodules/toolchest/local toolchest/.local

all:: toolchest
clean:: rm -rf toolchest

#. == Install Tmux Package Manager

.PHONY: tmux-package-manager
tmux-package-manager:
	mkdir -p $(top)/tmux/.config/tmux/plugins
	- ln -s submodules/tpm $(top)/tmux/.config/tmux/plugins/tpm

.PHONY: tmux-package-manager-clean
tmux-package-manager-clean:
	rm -rf $(top)/tmux/.tmux/plugins/tpm

all:: tmux-package-manager
clean:: tmux-package-manager-clean

#. == Openport reverse SSH tunnel manager

.PHONY: openport # Manage reverse SSH tunnels
openport:
	curl -Lo openport.deb https://openport.io/download/debian64/latest.deb
	sudo dpkg --install ./openport.deb

all:: openport

#. == Make diff-pdf package

.PHONY: diff-pdf # Compute a diff between PDF files
diff-pdf: submodules system-dependencies
	cd submodules/diff-pdf \
		&& ./bootstrap \
		&& ./configure --prefix=$(top)/diff-pdf/.local/ \
		&& make \
		&& make install

all:: diff-pdf

#. == Rclone

.PHONY: rclone-build # Build rclone stow package
rclone-build: GOBIN := $(top)/rclone/.local/bin/
rclone-build: GO := $(HOME)/.local/go/bin/go
rclone-build: submodules system-dependencies golang
	cd submodules/rclone \
		&& GOBIN=$(GOBIN) $(GO) install -tags cmount -trimpath -ldflags -s

all:: rclone-build

#. == Git Annex

#. NOTE: Git annex requires some stuff be added to the configuration for apt.
# The configuration file is in /etc/apt/sources.list.d/ubuntu.sources. You need
# to add `deb-src` and `noble-proposed` to make the results look like this:
# ````
# ## See the sources.list(5) manual page for further settings.
# Types: deb deb-src
# URIs: http://archive.ubuntu.com/ubuntu
# Suites: noble noble-updates noble-backports noble-proposed
# Components: main universe restricted multiverse
# Signed-By: /usr/share/keyrings/ubuntu-archive-keyring.gpg
#
# ## Ubuntu security updates. Aside from URIs and Suites,
# ## this should mirror your choices in the previous section.
# Types: deb deb-src
# URIs: http://security.ubuntu.com/ubuntu
# Suites: noble-security
# Components: main universe restricted multiverse
# Signed-By: /usr/share/keyrings/ubuntu-archive-keyring.gpg
# ````

.PHONY: git-annex-build # Build git-annex stow package
git-annex-build: submodules system-dependencies rclone-build
	cabal update \
	&& $(MAKE) -C submodules/git-annex.branchable.com install PREFIX=$(top)/git-annex/.local

all:: git-annex-build

#. == Pyenv python installation manager

.PHONY: pyenv # Python installation manager
pyenv: submodules
	cd pyenv/.pyenv && ./src/configure && make -C src

#. == Install Python utilities

#. This rule is not included in `all` because we don't directly install Python.
# The user must do that using `pyenv` first. However, if they've done so, they
# can then run this target to install useful utilities.

.PHONY: python-utilities # Install useful python utilities
python-utilities:
	python3 -m pip install --upgrade pip
	python3 -m pip install -U pipx
	python3 -m pipx install rich-cli
	python3 -m pipx install rich-click

#. == Build wsl-notify-send utility, so we can send notifications.

.PHONY: notify-send # Build and install notify-send for windows.
notify-send: golang submodules
	cd submodules/wsl-notify-send && make build
	cp submodules/wsl-notify-send/wsl-notify-send.exe logger/.local/bin/wsl-notify-send
	cp submodules/wsl-notify-send/wsl-notify-send.exe logger/.local/bin/notify-send

#. == Install default stowage

.PHONY: install-default # Install the default stow packages
install-default: install-default.sh
	./install-default.sh

all:: install-default

#. == Appendices

#. === Help

#. This rule will print out a listing of non-hidden targets and their
# descriptions.

.PHONY: list-targets # List all targets in this Makefile
list-targets:
	@LC_ALL=C $(MAKE) -pRrq -f $(firstword $(MAKEFILE_LIST)) : 2>/dev/null \
		| awk -v RS= -F: '/(^|\n)# Files(\n|$$)/,/(^|\n)# Finished Make data base/ {if ($$1 !~ "^[#.]") {print $$1}}' \
		| sort \
		| grep -E -v -e '^[^[:alnum:]]' -e '^$@$$' \
		| sort -u

.PHONY: help # Generate list of phony targets with descriptions
help::
	@bash -c 'eval "$$(printf "%s\\n" "$$@" | sed "s,\\\\$$,,")"' _ '\
	cat <<-HELP \
	# Makefile for dotfiles \
	\
	Used to build stow packages. \
	\
	# Available targets: \
	\
	HELP\
	'
	@grep '^.PHONY: .* #' Makefile \
		| sed 's/\.PHONY: \(.*\) # \(.*\)/\1\t\2/' \
		| expand -t20

#. === Processing this file to produce documentation

.PHONY: weave # Render this Makefile as internal documentation
weave: Makefile.typst

Makefile.typst: Makefile
	cat Makefile | sed 's,^# ,,g' | awk -v RS= -v ORS="\n\n" '!/#\. /{print "``""`\n"$$0"\n`""``\n"}; /^#\./{gsub("#\. ", "", $$0); print $$0}' > $@

Makefile.pdf: Makefile.typst
	typst compile Makefile.typst Makefile.pdf
