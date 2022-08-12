# This Makefile is _not_ required! It is only intended for advanced users.
#
# Usage:
#
# make devtools - Install OCaml LSP

OCAMLVERSION=4.12.1
PACKAGENAME=your_example

all: create-switch
.PHONY: create-switch

## -----------------------------------------------------------
## BEGIN Opam and Dune basics

create-switch: _opam/.opam-switch/switch-config
devtools: _opam/bin/ocamllsp
.PHONY: create-switch devtools

# 	We don't have a good way of knowing whether you are in Opam Monorepo
#	or in Opam Regular. That means we can't tell if we should use dune-universe.
#	So we'll always use dune-universe.
_opam/.opam-switch/switch-config:
	opam switch create . $(OCAMLVERSION) \
	  --yes \
	  --deps-only \
	  --repo default=https://opam.ocaml.org,dune-universe=git+https://github.com/dune-universe/opam-overlays.git

_opam/bin/dune: _opam/.opam-switch/switch-config
	OPAMSWITCH="$$PWD" && if [ -x /usr/bin/cygpath ]; then OPAMSWITCH=$$(/usr/bin/cygpath -aw "$$OPAMSWITCH"); fi && \
	  opam install dune --yes

$(PACKAGENAME).opam: dune-project _opam/bin/dune
	OPAMSWITCH="$$PWD" && if [ -x /usr/bin/cygpath ]; then OPAMSWITCH=$$(/usr/bin/cygpath -aw "$$OPAMSWITCH"); fi && \
	  eval $$(opam env) && \
	  dune build $@ && \
	  touch $@

_opam/bin/ocamllsp: _opam/.opam-switch/switch-config
	OPAMSWITCH="$$PWD" && if [ -x /usr/bin/cygpath ]; then OPAMSWITCH=$$(/usr/bin/cygpath -aw "$$OPAMSWITCH"); fi && \
	  opam install ocaml-lsp-server ocamlformat-rpc --yes

## END Opam and Dune basics
## -----------------------------------------------------------

## -----------------------------------------------------------
## BEGIN Opam Regular

opam-regular-install: _opam/.opam-switch/switch-config
	OPAMSWITCH="$$PWD" && if [ -x /usr/bin/cygpath ]; then OPAMSWITCH=$$(/usr/bin/cygpath -aw "$$OPAMSWITCH"); fi && \
	  opam install . --yes

## END Opam Regular
## -----------------------------------------------------------

## -----------------------------------------------------------
## BEGIN Opam Monorepo

monorepo-available: _opam/bin/opam-monorepo
monorepo-lock: $(PACKAGENAME).opam.locked
monorepo-pull: duniverse/README.md
.PHONY: monorepo-available monorepo-lock monorepo-pull

# 	opam-monorepo needs https://github.com/ocamllabs/opam-monorepo/pull/321 which is in currently
#   unreleased version 0.3.4
_opam/bin/opam-monorepo: _opam/.opam-switch/switch-config
	OPAMSWITCH="$$PWD" && if [ -x /usr/bin/cygpath ]; then OPAMSWITCH=$$(/usr/bin/cygpath -aw "$$OPAMSWITCH"); fi && \
	  opam pin opam-monorepo https://github.com/ocamllabs/opam-monorepo.git#004c17b5de92682e4c326f6392ef254415a4bf28 --yes

$(PACKAGENAME).opam.locked: $(PACKAGENAME).opam _opam/bin/opam-monorepo
	OPAMSWITCH="$$PWD" && if [ -x /usr/bin/cygpath ]; then OPAMSWITCH=$$(/usr/bin/cygpath -aw "$$OPAMSWITCH"); fi && \
	  opam monorepo lock --ocaml-version=$(OCAMLVERSION)

duniverse/README.md: $(PACKAGENAME).opam.locked
	OPAMSWITCH="$$PWD" && if [ -x /usr/bin/cygpath ]; then OPAMSWITCH=$$(/usr/bin/cygpath -aw "$$OPAMSWITCH"); fi && \
	  opam monorepo pull --yes &&
	  touch "$@"

opam-monorepo-build: _opam/bin/opam-monorepo
	OPAMSWITCH="$$PWD" && if [ -x /usr/bin/cygpath ]; then OPAMSWITCH=$$(/usr/bin/cygpath -aw "$$OPAMSWITCH"); fi && \
	  opam install . --locked --yes

## END Opam Monorepo
## -----------------------------------------------------------
