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

#. == Install lazygit (go package)
.PHONY: lazygit
lazygit: GOBIN := $(top)/lazygit/.local/bin/
lazygit:
	if command -v go; \
	then \
		cd submodules/lazygit && GOBIN=$(GOBIN) go install; \
	else \
		echo 'Go not installed.'; \
	fi

all:: lazygit

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
