biblatex-sp-unified
===================

`biblatex-sp-unified` is an opinionated BibLaTeX implementation of the [Unified Stylesheet for Linguistics Journal](http://celxj.org/downloads/UnifiedStyleSheet.pdf). The stylesheet was developed by [CELxJ, the Committee of Editors of Linguistics Journals](http://celxj.org/). There is a standard BibTeX implementation, called [`unified.bst`](http://celxj.org/downloads/unified.bst), which was developed by Bridget Samuels, based on work done for the house-style of the journal [*Semantics and Pragmatics*](http://semprag.org) (*S&P*).

This project is a ground-up re-implementation in modern BibLaTeX. It is now being used by *S&P* for its articles.


## Installation

The `biblatex-sp-unified` style consists of two files:

* `biblatex-sp-unified.bbx` -- for formatting the bibliography.
* `sp-authoryear-comp.cbx` -- for formatting in-text citations in the style of *S&P*.
  - Since the Unified Stylesheet does not give any guidelines for in-text citations, this file is optional and users can choose other citation styles.

These two files should be put somewhere where your TeX system can find them; for example, under the `TEXMF` "home" directory. You may have to create the directory structure:

    mkdir -p $(kpsewhich -var-value TEXMFHOME)/tex/latex/biblatex

And then copy/download each file into that directory:

    cd $_
    wget https://raw.githubusercontent.com/semprag/biblatex-sp-unified/master/bbx/biblatex-sp-unified.bbx
    wget https://raw.githubusercontent.com/semprag/biblatex-sp-unified/master/cbx/sp-authoryear-comp.cbx

If you are using the MacTeX distribution on macOS, you will end up with a file structure that looks like this:

    ~/Library/texmf/tex/latex/biblatex/biblatex-sp-unified.bbx
    ~/Library/texmf/tex/latex/biblatex/sp-authoryear-comp.cbx


## Backward compatibility

This repository's tags correspond to supported BibLaTeX versions.
If you have BibLaTeX `3.8` (or `3.8a`), you should use `biblatex-sp-unified@3.8.x` where `x` is the latest value in the series.

You can check which version of BibLaTeX you have by running `tlmgr info biblatex --only-installed --data cat-version` at the command line.


## Requirements

Compiling LaTeX documents with this style depends on a modern TeX installation that includes BibLaTeX 2.0+.
It is tested only with the `biber` backend.

To use the style in conjunction with *S&P*'s [`sp.cls`](https://raw.githubusercontent.com/semprag/tex/master/sp.cls), you have to do three things:

1. Include the class option 'biblatex' when importing `sp.cls`:

    `\documentclass[biblatex]{sp}`

2. Include a line in your preamble that loads your bib-file:

    `\addbibresource{your-bib-database.bib}`

   NB: the suffix `.bib` needs to be included (this is different from BibTeX)

3. Finally, replace the `\bibliography` line in the backmatter with the following:

    `\printbibliography`

You can use the style with other document classes as well. In that case, replace step 1 above with the following lines in your preamble:

    \usepackage[backend=biber,
                bibstyle=biblatex-sp-unified,
                citestyle=sp-authoryear-comp,
                maxcitenames=3,
                maxbibnames=99]{biblatex}

Full documentation of the design choices can be found in [doc/DOCUMENTATION.md](doc/DOCUMENTATION.md).
