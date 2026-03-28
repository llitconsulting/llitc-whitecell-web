TAILWIND_VERSION := v3.4.17
TAILWIND_BIN     := ./bin/tailwindcss

# Detect OS and arch for correct binary
OS   := $(shell uname -s | tr '[:upper:]' '[:lower:]')
ARCH := $(shell uname -m)
ifeq ($(ARCH),x86_64)
  ARCH := x64
else ifeq ($(ARCH),aarch64)
  ARCH := arm64
endif
ifeq ($(OS),darwin)
  PLATFORM := macos-$(ARCH)
else
  PLATFORM := linux-$(ARCH)
endif

.PHONY: setup build-css watch-css dev build clean

## setup: Download the Tailwind CSS standalone CLI (run once)
setup:
	@echo "Downloading Tailwind CSS CLI $(TAILWIND_VERSION) for $(PLATFORM)..."
	@mkdir -p bin
	@curl -sL "https://github.com/tailwindlabs/tailwindcss/releases/download/$(TAILWIND_VERSION)/tailwindcss-$(PLATFORM)" \
		-o $(TAILWIND_BIN)
	@chmod +x $(TAILWIND_BIN)
	@echo "Done. Tailwind CLI installed at $(TAILWIND_BIN)"

## build-css: Compile and minify Tailwind CSS
build-css: $(TAILWIND_BIN)
	$(TAILWIND_BIN) -i ./assets/css/input.css -o ./static/css/style.css --minify

## watch-css: Watch for changes and rebuild CSS
watch-css: $(TAILWIND_BIN)
	$(TAILWIND_BIN) -i ./assets/css/input.css -o ./static/css/style.css --watch

## dev: Run Tailwind watcher + Hugo dev server (Ctrl+C to stop)
dev: $(TAILWIND_BIN)
	@$(TAILWIND_BIN) -i ./assets/css/input.css -o ./static/css/style.css --watch &
	hugo server --disableFastRender

## build: Build CSS then generate production Hugo site
build: build-css
	hugo --minify

## clean: Remove generated files
clean:
	@rm -rf public/ resources/

$(TAILWIND_BIN):
	@echo "Tailwind CLI not found. Run 'make setup' first."
	@exit 1
