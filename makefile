# Makefile to convert README.md or resume.html to resume.pdf

# Variables
MD_FILE := README.md
PDF_FILE := resume.pdf
HTML_FILE := resume.html
CSS_FILE := resume.css
PANDOC := pandoc
PDF_ENGINE := wkhtmltopdf  # Options: pdflatex, xelatex, lualatex, wkhtmltopdf, weasyprint

# Default target
all: $(PDF_FILE)

# Rule to generate PDF from Markdown
$(PDF_FILE): $(MD_FILE) $(CSS_FILE)
ifeq ($(PDF_ENGINE),wkhtmltopdf)
	$(PANDOC) $(MD_FILE) -s -o temp_$(HTML_FILE) -c $(CSS_FILE)
	wkhtmltopdf --enable-local-file-access temp_$(HTML_FILE) $(PDF_FILE)
	rm temp_$(HTML_FILE)
else
	$(PANDOC) $(MD_FILE) -s --pdf-engine=$(PDF_ENGINE) -c $(CSS_FILE) -o $(PDF_FILE)
endif

# Rule to generate PDF from HTML
html-to-pdf: $(HTML_FILE) $(CSS_FILE)
	wkhtmltopdf --enable-local-file-access $(HTML_FILE) $(PDF_FILE)

# Alternative rule using Chrome/Chromium for HTML to PDF conversion
html-to-pdf-chrome: $(HTML_FILE) $(CSS_FILE)
	powershell -Command "Start-Process chrome --headless --disable-gpu --print-to-pdf=$(PDF_FILE) --print-to-pdf-no-header file:///$(shell pwd | tr '/' '\\')/$(HTML_FILE)"

# Clean up generated files
clean:
	rm -f $(PDF_FILE) temp_$(HTML_FILE)

.PHONY: all html-to-pdf html-to-pdf-chrome clean
