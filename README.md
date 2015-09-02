biblatex-sp-unified
===================

An opinionated BibLaTeX implementation of the Unified Stylesheet for Linguistics Journals

# Introduction #

`biblatex-sp-unified` is an opionated implementation in BibLaTeX of the [Unified Stylesheet for Linguistics Journal](http://celxj.org/downloads/UnifiedStyleSheet.pdf). The stylesheet was developed by [CELxJ, the Committee of Editors of Linguistics Journals](http://celxj.org/). There is a standard BibTeX implementation, called [`unified.bst`](http://celxj.org/downloads/unified.bst), which was developed by Bridget Samuels, based on work done for the house-style of the journal [*Semantics and Pragmatics (S&P)*](http://semprag.org).

The current project is a ground-up re-implementation in modern BibLaTeX. It is now being used by *S&P* for its articles.

# Installation and use

The `biblatex-sp-unified` style consists of two files: `biblatex-sp-unified.bbx` (which contains the bibliography formatting code) and, `sp-authoryear-comp.cbx` (which contains the code for formatting in-text citations in the style of *S&P*; since the Unified Stylesheet does not give any guidelines of in-text citations, this file is optional and users can choose other citation styles). These should be put somewhere where your TeX system can find them (perhaps, `~/Library/texmf/tex/latex/biblatex/{bbx,cbx}/`.

The style depends on a modern TeX installation that includes biblatex 2.0+. It is tested only with the biber backend.

To use the style in conjunction with sp.cls, you have to do two things:

1. include the class option 'biblatex' when calling sp.cls:

    `\documentclass[biblatex]{sp.cls}`
    
2. include a line in your preamble that loads your bib-file:

    `\addbibresource{your-bib-database.bib}`

   NB: the suffix `.bib` needs to be included (this is different from bibtex)

3. Finally, replace the `\bibliography` line in the backmatter with the following:

    `\printbibliography`

You can use the style with other document classes as well. In that case, replace step 1 above with the following lines in your preamble:

    \usepackage[backend=biber,
            bibstyle=biblatex-sp-unified,
            citestyle=sp-authoryear-comp,
            maxcitenames=3,
            maxbibnames=99]{biblatex}
            
Full documentation of the design choices can be found in doc/DOCUMENTATION.md.
