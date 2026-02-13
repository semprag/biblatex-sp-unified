# CLAUDE.md

## Project Overview

**biblatex-unified** is a BibLaTeX implementation of the Unified Stylesheet for Linguistics Journals, developed by CELxJ (Committee of Editors of Linguistics Journals). This is the house style for the journal *Semantics and Pragmatics* (S&P).

Repository: https://github.com/semprag/biblatex-unified
Maintainer: Kai von Fintel (fintel@mit.edu)
License: LaTeX Project Public License v1.3c

## Core Files

- **`unified.bbx`** - Bibliography formatting style (main file, ~860 lines)
- **`unified.cbx`** - Citation style for in-text citations (~135 lines)
- **`unified-test.tex`** / **`unified-test.bib`** - Test files
- **`biblatex-unified.md`** - Main documentation source

## Architecture

The style inherits from standard biblatex styles:
- `unified.bbx` inherits from `authoryear.bbx`
- `unified.cbx` inherits from `authoryear-comp.cbx`

### Key Style Characteristics

- **No Oxford comma**; uses ampersand (&) before last author
- Article/chapter titles in **roman** (not italicized)
- Book/journal/dissertation titles in **italics**
- **No quotation marks** around any titles
- **Sentence case** for non-recurring titles (articles, books, chapters)
- **Title case** for recurring titles (journals, series)
- Edition abbreviated as "edn." (not "edition")
- Periods between major components (Author. Year. Title.)
- "von" particles displayed naturally but sorted by capitalized part

### Citation Commands

Standard biblatex natbib-compatible commands available (via `natbib` option):
- `\citet{key}` - Textual citation
- `\citep{key}` - Parenthetical citation
- `\citealt{key}`, `\citealp{key}` - Alternative forms

The `.cbx` file removes "p./pp." prefixes from postnotes for minimalist style.

## Building/Testing

```bash
# Compile test document
xelatex unified-test.tex
biber unified-test
xelatex unified-test.tex

# Regenerate documentation
pandoc -f markdown -t latex biblatex-unified.md -s -o biblatex-unified.tex --highlight-style=kate
xelatex biblatex-unified.tex
```

## Requirements

- biblatex 2.0+
- biber backend
- hyperref package
- TeX Live 2019 or later recommended

## Key Implementation Details

### Entry Type Handling

- **`@article`** - Journal articles
- **`@book`** - Books
- **`@incollection`** - Chapters in edited volumes
- **`@inproceedings`** - Conference papers
  - With ISSN: formatted as journal article
  - Without ISSN: formatted as book chapter
- **`@thesis`** - Dissertations/theses
- **`@unpublished`** - Online/unpublished materials

### Link Handling Options

- Default: Show DOI if present, else eprint, else URL
- `compactlinks`: Compact format (e.g., "DOI: 10.3765/sp.10.1")
- `alllinks`: Show all available links

### Legacy Citation Commands

The `legacycitecommands` option enables legacy S&P citation commands:

```latex
\usepackage[backend=biber, style=unified, legacycitecommands]{biblatex}
```

Commands provided:
- `\pgcitep{key}{page}` → (Author Year: page)
- `\pgcitealt{key}{page}` → Author Year: page
- `\pgcitet{key}{page}` → Author (Year: page)
- `\pgposscitet{key}{page}` → Author's (Year: page)
- `\seccitep{key}{sec}` → (Author Year: §sec)
- `\seccitealt{key}{sec}` → Author Year: §sec
- `\seccitet{key}{sec}` → Author (Year: §sec)
- `\secposscitet{key}{sec}` → Author's (Year: §sec)
- `\posscitet{key}` → Author's (Year)
- `\posscitealt{key}` → Author's Year
- `\possciteauthor{key}` → Author's

### Pubstate / Forthcoming Handling

Entries without a year but with `pubstate = {forthcoming}` use biblatex's `\DeclareLabeldate` to fall back to `pubstate` as the date label. The `addendum+pubstate` bibmacro is redefined to suppress duplicate "forthcoming" in the bibliography when it's already used as the label.

When multiple entries share the same pubstate label, biblatex adds an `extradate` disambiguator (a, b, ...). A custom `\DeclareFieldFormat{extradate}` ensures these are consistently rendered in square brackets (`forthcoming[a]`) across all citation commands and the bibliography. For year-based labels, the bare letter is used as usual (`2020b`).

### Custom Eprint Types

Beyond standard biblatex eprint types (arxiv, jstor, pubmed, hdl, googlebooks), this style adds:
- `lingbuzz` - LingBuzz repository
- `roa` - Rutgers Optimality Archive

## Common Tasks

### Adding/Modifying Entry Type Drivers

Entry type drivers are defined in `unified.bbx` using `\DeclareBibliographyDriver{entrytype}{...}`.

### Modifying Citation Format

Citation formatting is in `unified.cbx`. Key macros:
- `\nameyeardelim` - Delimiter between name and year
- `\postnotedelim` - Delimiter before postnote (page numbers)
- `\multicitedelim` - Delimiter between multiple citations

### Modifying Bibliography Macros

Bibliography formatting uses bibmacros defined via `\newbibmacro{name}{...}` or `\renewbibmacro{name}{...}` in `unified.bbx`.
