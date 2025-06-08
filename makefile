# Makefile to convert resume.html to resume.pdf

# Variables
PDF_FILE := resume.pdf
HTML_FILE := resume.html
CSS_FILE := resume.css

# Default target - generate PDF from HTML
all: $(PDF_FILE)

# Rule to generate PDF from HTML
$(PDF_FILE): $(HTML_FILE) $(CSS_FILE)
	wkhtmltopdf --enable-local-file-access --print-media-type --disable-smart-shrinking $(HTML_FILE) $(PDF_FILE)

# Alternative rule using Chrome/Chromium for HTML to PDF conversion
html-to-pdf-chrome: $(HTML_FILE) $(CSS_FILE)
	powershell -Command "Start-Process chrome --headless --disable-gpu --print-to-pdf=$(PDF_FILE) --print-to-pdf-no-header file:///$(shell pwd | tr '/' '\\')/$(HTML_FILE)"

# Clean up generated files
clean:
	powershell -Command "if (Test-Path $(PDF_FILE)) { Remove-Item $(PDF_FILE) }"

.PHONY: all html-to-pdf-chrome clean
