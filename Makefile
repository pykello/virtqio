FIND_CONTENT = find content \( -path "*/.git" -o -path "*/.git/*" \) -prune -o

CONTENT_METADATA_FILES := $(shell $(FIND_CONTENT) -name "metadata.yaml" -print)
CONTENT_TARGETS := $(patsubst content/%/metadata.yaml,build/%.html,$(CONTENT_METADATA_FILES))
PAGE_FILES := $(shell \
        $(FIND_CONTENT) -type f -name '*.md' \
             \! -execdir test -e metadata.yaml \; -print)
PAGE_TARGETS := $(patsubst content/%.md,build/%.html,$(PAGE_FILES))
CONTENT_INDEX_FILES := $(shell $(FIND_CONTENT) -name "index.yaml" -print)
CONTENT_INDEX_TARGETS := $(patsubst content/%/index.yaml,build/%/index.html,$(CONTENT_INDEX_FILES))
TEMPLATE_FILES := $(shell find templates -type f)
CONFIG_FILES := config.en.yaml config.fa.yaml
BUILD_SUPPORT_FILES := $(TEMPLATE_FILES) $(CONFIG_FILES) Makefile
LEARNING_INDEX_FILES := $(shell $(FIND_CONTENT) -path "*/learning/*/index.md" -print)

all: copy_static $(CONTENT_TARGETS) $(CONTENT_INDEX_TARGETS) $(PAGE_TARGETS) build/index.html

choose_config = $(if $(findstring content/fa/,$1),config.fa.yaml,config.en.yaml)

define add_content_dir_deps
build/$(patsubst content/%/metadata.yaml,%,$1).html: $(shell find $(dir $1) \( -path "*/.git" -o -path "*/.git/*" \) -prune -o -type f -print)
endef

$(foreach metadata,$(CONTENT_METADATA_FILES),$(eval $(call add_content_dir_deps,$(metadata))))

define add_learning_index_deps
build/$(patsubst content/%.md,%,$1).html: $(shell if [ -d $(dir $1)sheets ]; then find $(dir $1)sheets \( -path "*/.git" -o -path "*/.git/*" \) -prune -o -type f -name '*.md' -print; fi)
endef

$(foreach index,$(LEARNING_INDEX_FILES),$(eval $(call add_learning_index_deps,$(index))))

build/%.html: content/%/metadata.yaml $(BUILD_SUPPORT_FILES)
	@echo "Generating $@ from $(dir $<)"
	@ssg-content $(dir $<) --config $(call choose_config,$<)

build/%.html: content/%.md $(BUILD_SUPPORT_FILES)
	@echo "Generating $@ from $<"
	@ssg-content $< --config $(call choose_config,$<)

build/%/index.html: content/%/index.yaml $(BUILD_SUPPORT_FILES)
	@echo "Generating $@ from $< (index)"
	@ssg-list $< --config $(call choose_config,$<)

build/index.html: content/index.yaml $(BUILD_SUPPORT_FILES)
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

.PHONY: all clean copy_static http live

http:
	@echo "Starting HTTP server"
	@python3 -m http.server --directory build 8000
	@echo "Server started at http://localhost:8000"

live:
	@python3 scripts/live_preview.py
