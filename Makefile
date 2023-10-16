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
	cd submodules/autojump && ./install.py -p $(top)/unidev/.local/

all:: autojump
clean::
	rm -f $(top)/unidev/.local/bin/autojump
	rm -f $(top)/unidev/.local/bin/autojump_argparse.py
	rm -f $(top)/unidev/.local/bin/autojump_data.py
	rm -f $(top)/unidev/.local/bin/autojump_match.py
	rm -f $(top)/unidev/.local/bin/autojump_utils.py
	rm -rf $(top)/unidev/.local/share/autojump/
	rm -rf $(top)/unidev/.local/share/man/

#. == Build Rust Package
#. This package requires I configure and run a special installer, which
#. downloads and installs Rust from the official project pages. As usual, I will
#. install it to a stowage directory.
.PHONY: rust
rust: export CARGO_HOME := $(shell readlink -f ./rust/.local/share/rust/cargo)
rust: export RUSTUP_HOME := $(shell readlink -f ./rust/.local/share/rust/rustup)
rust: rust/.local/share/rust/rustup.sh
	./rust/.local/share/rust/rustup.sh --no-modify-path -q -y --default-toolchain stable

all:: rust
clean::
	rm -rf rust/.local/share/rust/rustup
	rm -rf rust/.local/share/rust/cargo

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
