#!/usr/bin/env make

DOCNAME = My-COA-Tips

FROM    = markdown_github
TO      = latex

INPUT   = $(DOCNAME).md
OUTPUT  = $(DOCNAME).pdf

TARGETS = $(OUTPUT)

all: $(TARGETS)

spell aspell:
	aspell check $(INPUT)

clean:
	$(RM) $(TARGETS)

$(OUTPUT): $(INPUT)
	pandoc --from $(FROM) --to $(TO) --output $(OUTPUT) $(INPUT)
