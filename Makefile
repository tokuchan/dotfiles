#. = Makefile
#. Sean@Spillane.us
#.
#. Setup support tooling and prepare for stowage.

#. == Introduction
#. This makefile governs the set up and installation of tooling. A principle of
#. this makefile is that _all_ dependendant packages that are available as GIT
#. repositories are handled as _submodules_, and all submodules are stored in the
#. `submodules` directory, which should _never_ be installed via `stow`. When a
#. package is to be installed, it _must_ be installed into a stowage directory at
#. the top level. This makefile will so arrange the dependent packages to manage
#. this.

#. NOTE: I assume that the `stow` tool is _already_ installed and available on
#. the target system. Most of the time, I can convince the system owner to go
#. along. In case I _can't_, I can make do with a docker image in this repo, but
#. that's a last resort and quite a pain to use.

#. == Change Default Shell
#. I need to be able to source shell setup. Therefore, I must change the
#. default shell.
SHELL := /bin/bash

#. == Primary Targets
#.. Default Target
.PHONY: all
all::

#.. Clean Target
.PHONY: clean
clean::

#. == Utilty Macros
#.. Project Root
top := $(shell git rev-parse --show-toplevel)

#. == Submodules
#. All submodules are installed in the `submodules` directory. Therefore, I
#. just need to initialize and check them out.
.PHONY: submodules
submodules:
	git submodule sync
	git submodule init
	git submodule update

#. == Build Autojump Package
#. This package is in a submodule, so I will need submodules to work with it.
#. Otherwise, I just need to install it to the stowage directory. I will put it in
#. unidev.
.PHONY: autojump
autojump: submodules
	cd submodules/autojump && ./install.py -p $(top)/autojump/.local/

.PHONY: autojump-clean
autojump-clean:
	rm -rf $(top)/autojump/

all:: autojump
clean:: autojump-clean

#. == Install go if needed
.PHONY: golang
golang: go1.22.2.linux-amd64.tar.gz .golang.installed

.golang.installed:
	mkdir -p $(HOME)/.local/go
	rm -rf $(HOME)/.local/go && tar -C $(HOME)/.local -xf go1.22.2.linux-amd64.tar.gz
	touch .golang.installed

go1.22.2.linux-amd64.tar.gz:
	wget https://go.dev/dl/go1.22.2.linux-amd64.tar.gz

golang-clean:
	rm -rf $(HOME)/.local/go
	rm -f go1.22.2.linux-amd64
	rm -f .golang.installed

all:: golang
clean:: golang-clean

#. == Install lazygit (go package)
.PHONY: lazygit
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

#. == Build lastpass-cli package for stow
.PHONY: lastpass-cli
lastpass-cli: submodules
	mkdir -p lastpass-cli/.local
	cd submodules/lastpass-cli \
		&& cmake -DCMAKE_INSTALL_PREFIX:PATH=$(top)/lastpass-cli/.local/ -S . -B build \
		&& cmake --build build \
		&& cmake --build build -t install

.PHONY: lastpass-cli-clean
	cd submodules/lastpass-cli && make clean

all:: lastpass-cli
clean:: lastpass-cli-clean

#. == Build Rust Package
#. This package requires I configure and run a special installer, which
#. downloads and installs Rust from the official project pages. As usual, I will
#. install it to a stowage directory.
.PHONY: rust
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
	fi
	stow rust

.PHONY: rust-clean
rust-clean:
	rm -rf rust/.local/share/rust/rustup
	rm -rf rust/.local/share/rust/cargo

all:: rust
clean:: rust-clean

#. == Install jujitsu VCS program
#. This package requires rust to complete, and offers a VCS interface on top of
#. git.
.PHONY: jujitsu
jujitsu: rust
	cargo install --locked --bin jj jj-cli

#. == Install typest text processor
.PHONY: typest
typest: rust
	cargo install --git https://github.com/typst/typst typst-cli

all:: typest

#. == Install just command runner
.PHONY: just
just: rust
	cargo install just

all:: just

#. == Build and prepare the neovide package.
.PHONY: neovide
neovide: submodules/neovide/target/release/neovide
	mkdir -p neovide/.local/bin
	cp submodules/neovide/target/release/neovide neovide/.local/bin/neovide

.PHONY: neovide-clean
neovide-clean:
	rm -rf neovide

submodules/neovide/target/release/neovide: rust
	cd submodules/neovide && cargo build --release 

all:: neovide
clean:: neovide-clean

.PHONY: evcxr
evcxr: rust
	cargo install evcxr_repl

all:: evcxr

.PHONY: bacon
bacon: rust
	cargo install bacon

all:: bacon

.PHONY: zoxide
zoxide: rust
	cargo install zoxide
	mkdir -p zoxide/.config/fish/conf.d
	mkdir -p zoxide/.bashrc.d
	zoxide init --cmd=cd fish > zoxide/.config/fish/conf.d/zoxide.fish
	zoxide init --cmd=cd bash > zoxide/.bashrc.d/zoxide.bash

all:: zoxide

.PHONY: diffr
diffr: rust
	cargo install diffr
all:: diffr

.PHONY: lsd
lsd: rust
	cargo install --git https://github.com/lsd-rs/lsd.git --branch master

all:: lsd

#. == Build the neovim package
.PHONY: neovim
neovim: neovim/.local/bin/nvim

neovim/.local/bin/nvim:
	mkdir -p neovim/.local/bin
	cd submodules/neovim \
		&& make CMAKE_BUILD_TYPE=RelWithDebInfo CMAKE_INSTALL_PREFIX=$(top)/neovim/.local/ install

neovim-clean:
	rm -rf $(top)/neovim
	cd submodules/neovim && make clean

all:: neovim
clean:: neovim-clean

#. == Build emacs 29+
.PHONY: emacs
emacs: submodules/emacs/Makefile
	make -C submodules/emacs -j 20 install

submodules/emacs/Makefile: submodules/emacs/configure
	cd submodules/emacs && ./configure --with-pgtk --prefix=$(top)/emacs/.local/

submodules/emacs/configure: submodules/emacs/configure.ac submodules/emacs/autogen.sh
	cd submodules/emacs && ./autogen.sh

.PHONY: emacs-clean
emacs-clean:
	cd submodules/emacs && git reset --hard HEAD

all:: emacs
clean:: emacs-clean

#. Set up git-repo symlink for install
repo:
	mkdir -p repo/.local/bin
	ln -s $$(readlink -f ./submodules/git-repo/repo) repo/.local/bin/repo

repo-clean:
	rm -rf repo

all:: repo
clean:: repo-clean

#. == Appendix: Processing this file to produce documentation
#. This file is designed to be produced into documentation. To do so, run the
#. following PERL script on the file, then pipe the results to `asciidoctor-pdf`.
#. The target `doc` is provided, which will produce all documentation to the `doc`
#. directory.

#. === Weave Script
#. [,perl]
#. ----
#. perl -lpe 's,^,X,mg;s,^X#\.\.,N,mg;s,^X#\.,T,mg;s,^X,C ,mg;' Makefile
#. ----
