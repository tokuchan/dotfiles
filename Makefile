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
all:

#.. Clean Target
.PHONY: clean
clean::

foo: bar
	ls

#. == Appendix: Processing this file to produce documentation
#. This file is designed to be produced into documentation. To do so, run the
#. following PERL script on the file, then pipe the results to `asciidoctor-pdf`.
#. The target `doc` is provided, which will produce all documentation to the `doc`
#. directory.

foo: bar
	ls

#. === Weave Script
#. [,perl]
#. ----
#. perl -lpe 's,^,X,mg;s,^X#\.\.,N,mg;s,^X#\.,T,mg;s,^X,C ,mg;' Makefile
#. ----
