biblatex-unified
================

`biblatex-unified` is an opinionated BibLaTeX implementation of the [Unified Stylesheet for Linguistics Journal](http://celxj.org/downloads/UnifiedStyleSheet.pdf).
The stylesheet was developed by [CELxJ, the Committee of Editors of Linguistics Journals](http://celxj.org/).
There is a standard BibTeX implementation, called [`unified.bst`](http://celxj.org/downloads/unified.bst), which was developed by Bridget Samuels, based on work done for the house-style of the journal [*Semantics and Pragmatics*](http://semprag.org) (*S&P*).

This project is a ground-up re-implementation in modern BibLaTeX. It is now being used by *S&P* in production.

Full documentation of the design choices can be found in [doc/DOCUMENTATION.md](doc/DOCUMENTATION.md).

Please [file an issue](https://github.com/semprag/biblatex-sp-unified/issues/new) to let us know of any problems you encounter and any recommendations for improvement.


## Sources

The `biblatex-unified` style consists of two files:

* [`unified.bbx`](unified.bbx) -- for formatting the bibliography.
* [`unified.cbx`](unified.cbx) -- for formatting in-text citations in the style of *S&P*.
  - Since the Unified Stylesheet does not give any guidelines for in-text citations, this file is optional and users can choose other citation styles.


## Requirements and backward compatibility

Compiling LaTeX documents with this style depends on a modern TeX installation that includes BibLaTeX 2.0+.
It is tested only with the `biber` backend.

This repository's tags correspond to supported BibLaTeX versions.
If you have BibLaTeX `3.8` (or `3.8a`), you should use `biblatex-sp-unified@3.8.x` where `x` is the latest value in the series.

You can check which version of BibLaTeX you have by running `tlmgr info biblatex --only-installed --data cat-version` at the command line.


### Installation

The commands in this section must be run at the command line,
e.g., `Terminal.app` on MacOS, or `Terminal` on many common Linux GUIs.

The two source files should be put somewhere where your TeX system can find them; for example, under the `TEXMF` "home" directory. Run this command to create the directory structure:

    mkdir -p $(kpsewhich -var-value TEXMFHOME)/tex/latex/biblatex

And then copy/download each file into that directory (replace `master` in the URLs with the appropriate tag if you have an older version of BibLaTeX):

    cd $(kpsewhich -var-value TEXMFHOME)/tex/latex/biblatex
    wget https://raw.githubusercontent.com/semprag/biblatex-sp-unified/master/bbx/biblatex-sp-unified.bbx
    wget https://raw.githubusercontent.com/semprag/biblatex-sp-unified/master/cbx/sp-authoryear-comp.cbx

If you are using the MacTeX distribution on macOS, you will end up with a file structure that looks like this:

    ~/Library/texmf/tex/latex/biblatex/biblatex-sp-unified.bbx
    ~/Library/texmf/tex/latex/biblatex/sp-authoryear-comp.cbx


### Configuring your `.tex` document to use the style

To use the style in conjunction with *S&P*'s [`sp.cls`](https://raw.githubusercontent.com/semprag/tex/master/sp.cls),
simply add the `biblatex` class option when importing `sp.cls`:

    \documentclass[biblatex]{sp}

If you are not using the `S&P` document class, you can still use this style by adding the following to your preamble (after `\documentclass{...}` but before `\begin{document}`):

    \usepackage[backend=biber,
                style=unified,
                maxcitenames=3,
                maxbibnames=99]{biblatex}

<!-- same as https://github.com/semprag/tex/blob/585f282/sp.cls#L126-L130 -->

If you were previously using `natbib`, remove `\usepackage{natbib}` and any accompanying `\bibliographystyle{...}` and `\bibpunct{...}` settings.
You might also find it helpful to add `natbib` to the list of options (`\usepackage[..., natbib]{biblatex}`), to load BibLaTeX's `natbib` compatibility module, which implements common `natbib` commands like `\citet`, `\citep`, `\citealt`, `\citealp`, etc.


### Configuring your document to use BibLaTeX instead of BibTeX

Whether you're using `sp.cls` or a different document class, you'll need to change the usual BibTeX commands to BibLaTeX, in two places:

1. Replace the `\bibliography{your-bibfile}` line in the backmatter with `\printbibliography`.
2. Add the following command to your preamble: `\addbibresource{your-bibfile.bib}`
   - NB: the `.bib` extension must be included (unlike BibTeX)


## Testing

Testing consists of rendering `unified-test.tex` (and `unified-test.bib`) into a PDF, converting to plain text, then comparing to a static file containing the expected output (`test/unified-test.expected.md`)[test/unified-test.expected.md].
The various steps are specified in the [`Makefile`](Makefile), which can be run by calling `make test`.
