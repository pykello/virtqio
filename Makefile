CONTENT_METADATA_FILES := $(shell find content -name "metadata.yaml")
CONTENT_TARGETS := $(patsubst content/%/metadata.yaml,build/%.html,$(CONTENT_METADATA_FILES))
PAGE_FILES := $(shell \
        find content -type f -name '*.md' \
             \! -execdir test -e metadata.yaml \; -print)
PAGE_TARGETS := $(patsubst content/%.md,build/%.html,$(PAGE_FILES))
CONTENT_INDEX_FILES := $(shell find content -name "index.yaml")
CONTENT_INDEX_TARGETS := $(patsubst content/%/index.yaml,build/%/index.html,$(CONTENT_INDEX_FILES))

all: copy_static $(CONTENT_TARGETS) $(CONTENT_INDEX_TARGETS) $(PAGE_TARGETS) build/index.html

choose_config = $(if $(findstring content/fa/,$1),config.fa.yaml,config.en.yaml)

build/%.html: content/%/metadata.yaml
	@echo "Generating $@ from $(dir $<)"
	@ssg-content $(dir $<) --config $(call choose_config,$<)

build/%.html: content/%.md
	@echo "Generating $@ from $<"
	@ssg-content $< --config $(call choose_config,$<)

build/%/index.html: content/%/index.yaml
	@echo "Generating $@ from $< (index)"
	@ssg-list $< --config $(call choose_config,$<)

build/index.html: content/index.yaml
	@echo "Generating $@ from $< (index)"
	@ssg-list $< --config $(call choose_config,$<)

# Rule to copy everything in static to build/static
copy_static:
	@echo "Copying static files to build/static"
	@mkdir -p build/static
	@cp -r static/* build/static/

clean:
	@echo "Cleaning up"
	@rm -rf build

.PHONY: all clean copy_static

http:
	@echo "Starting HTTP server"
	@python3 -m http.server --directory build 8000
	@echo "Server started at http://localhost:8000"
