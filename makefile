# Makefile to convert README.md to resume.pdf using Pandoc

# Variables
MD_FILE := README.md
PDF_FILE := resume.pdf
HTML_FILE := resume.html
CSS_FILE := resume.css
PANDOC := pandoc
PDF_ENGINE := wkhtmltopdf  # Options: pdflatex, xelatex, lualatex, wkhtmltopdf, weasyprint

# Default target
all: $(PDF_FILE)

# Rule to generate PDF
$(PDF_FILE): $(MD_FILE) $(CSS_FILE)
ifeq ($(PDF_ENGINE),wkhtmltopdf)
	$(PANDOC) $(MD_FILE) -s -o $(HTML_FILE) -c $(CSS_FILE)
	wkhtmltopdf --enable-local-file-access $(HTML_FILE) $(PDF_FILE)
	rm $(HTML_FILE)
else
	$(PANDOC) $(MD_FILE) -s --pdf-engine=$(PDF_ENGINE) -c $(CSS_FILE) -o $(PDF_FILE)
endif

# Clean up generated files
clean:
	rm -f $(PDF_FILE) $(HTML_FILE)

.PHONY: all clean
