# dkml-workflows-example

Examples for GitHub Action workflows used by and with Diskuv OCaml (DKML) tooling. DKML helps you
distribute native OCaml applications on the most common operating systems.

These examples are useful for more than DKML though! If you want to test your
code with the Microsoft Visual Studio compiler and MSYS2, or if you want to produce Linux binaries
that don't need to be statically linked, this is the right place.

These workflows are **not quick** and won't improve unless you are willing to contribute PRs!
Expect to wait approximately:

| Build Step                                               | First Time | Subsequent Times |
| -------------------------------------------------------- | ---------- | ---------------- |
| setup-dkml / win32-windows_x86                           | `29m`      | sdf              |
| setup-dkml / win32-windows_x86_64                        | `29m`      | sdf              |
| setup-dkml / macos-darwin_all [1]                        | `29m`      | sdf              |
| setup-dkml / manylinux2014-linux_x86 (CentOS 7, etc.)    | `16m`      | sdf              |
| setup-dkml / manylinux2014-linux_x86_64 (CentOS 7, etc.) | `13m`      | sdf              |
| build / win32-windows_x86                                | `23m`      | sdf              |
| build / win32-windows_x86_64                             | `19m`      | sdf              |
| build / macos-darwin_all                                 | `27m`      | sdf              |
| build / manylinux2014-linux_x86 (CentOS 7, etc.)         | `09m`      | sdf              |
| build / manylinux2014-linux_x86_64 (CentOS 7, etc.)      | `09m`      | sdf              |
| release                                                  | `01m`      | sdf              |
| **TOTAL** *(not cumulative since steps run in parallel)* | `57m`      | sdf              |

You can see an example workflow at https://github.com/diskuv/dkml-workflows-example/actions/workflows/package.yml

[1] `setup-dkml/macos-darwin_all` is doing double-duty: it is compiling x86_64 and arm64 systems.

## Making your own workflow

This GitHub repository includes examples for multiple build configurations:
* Opam and Dune. We call this build workflow `Opam Regular`.
* Opam Monorepo and Dune. [Opam Monorepo](https://github.com/ocamllabs/opam-monorepo) is a re-packaging of Opam that makes it easy to support cross-compiling. **It is not for beginners.** We call this build workflow `Opam Monorepo`

You can consult the table below to see which files you should copy into your own workflow. If you use [Opam Monorepo](https://github.com/ocamllabs/opam-monorepo) then you only need to look at files that have `Opam Monorepo` in **Build Workflow**. If you use `Opam Regular` then look at `Opam Regular` in **Build Workflow**.

| Build Workflow                  | File or Directory                        |
| ------------------------------- | ---------------------------------------- |
| `Opam Regular`, `Opam Monorepo` | .gitattributes                           |
| `Opam Regular`, `Opam Monorepo` | .github/workflows/build.yml              |
| `Opam Regular`, `Opam Monorepo` | .github/workflows/static.yml             |
| `Opam Regular`, `Opam Monorepo` | .github/workflows/static/mlc_config.json |
| `Opam Regular`, `Opam Monorepo` | .gitignore                               |
| `Opam Regular`, `Opam Monorepo` | .ocamlformat                             |
| `Opam Regular`, `Opam Monorepo` | LICENSE                                  |
| `Opam Regular`, `Opam Monorepo` | Makefile                                 |
| `Opam Regular`, `Opam Monorepo` | README.md                                |
| `Opam Regular`, `Opam Monorepo` | bin/dune                                 |
| `Opam Regular`, `Opam Monorepo` | bin/main.ml                              |
| `Opam Regular`, `Opam Monorepo` | dune-project                             |
| `Opam Monorepo`                 | duniverse/                               |
| `Opam Regular`, `Opam Monorepo` | lib/dune                                 |
| `Opam Regular`, `Opam Monorepo` | test/dune                                |
| `Opam Regular`, `Opam Monorepo` | test/your_example.ml                     |
| `Opam Regular`, `Opam Monorepo` | your_example.opam                        |
| `Opam Monorepo`                 | your_example.opam.locked                 |

## Status

| What             | Branch/Tag | Status                                                                                                                                                                                        |
| ---------------- | ---------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Builds and tests |            | [![Builds and tests](https://github.com/diskuv/dkml-workflows-example/actions/workflows/package.yml/badge.svg)](https://github.com/diskuv/dkml-workflows-example/actions/workflows/build.yml) |
| Static checks    |            | [![Static checks](https://github.com/diskuv/dkml-workflows-example/actions/workflows/syntax.yml/badge.svg)](https://github.com/diskuv/dkml-workflows-example/actions/workflows/static.yml)    |
