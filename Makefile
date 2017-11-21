.PHONY: test
test: test/unified-test.md
	diff $< test/unified-test.expected.md

.INTERMEDIATE: test/unified-test.md

%.md: %.html
	pandoc --wrap=none -f html $< -t commonmark -o $@

%.html: %.pdf
	@# perl replaces NO-BREAK SPACE with normal SPACE, removes <hr/> and <a>...</a> tags, and fixes <i> tags
	pdftohtml -nomerge -wbt 20 -stdout $< | sed \
	  -e 's/&#160;/ /g' \
	  -e 's:<hr/>::g' \
	  -e 's:<a[^>]*>::g' -e 's:</a>::g' \
	  -e 's: </i>:</i> :g' > $@

%.pdf: %.tex %.bib
	latexmk -cd -pvc- $*
