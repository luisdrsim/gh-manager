VERSION ?= $(shell git describe --tags --abbrev=0 2>/dev/null | sed 's/^v//' || echo "1.0.0")
REPO    := lcajigasm/gh-manager

.PHONY: install uninstall release update-formula lint

install:
	@echo "→ Instalando ghm localmente..."
	@chmod +x bin/ghm
	@cp bin/ghm /usr/local/bin/ghm
	@echo "✅ ghm instalado en /usr/local/bin/ghm"

uninstall:
	@rm -f /usr/local/bin/ghm
	@echo "✅ ghm eliminado"

lint:
	@shellcheck bin/ghm

release: lint
	@if [ -z "$(TAG)" ]; then echo "Uso: make release TAG=v1.0.0"; exit 1; fi
	@echo "→ Creando release $(TAG)..."
	@git tag -a "$(TAG)" -m "Release $(TAG)"
	@git push origin "$(TAG)"
	@gh release create "$(TAG)" \
		--title "ghm $(TAG)" \
		--generate-notes \
		--repo "$(REPO)"
	@echo "→ Calculando SHA256..."
	@sleep 3
	$(MAKE) update-formula TAG=$(TAG)

update-formula:
	@if [ -z "$(TAG)" ]; then echo "Uso: make update-formula TAG=v1.0.0"; exit 1; fi
	@URL="https://github.com/$(REPO)/archive/refs/tags/$(TAG).tar.gz"; \
	 SHA=$$(curl -sL "$$URL" | shasum -a 256 | awk '{print $$1}'); \
	 VERSION=$$(echo "$(TAG)" | sed 's/^v//'); \
	 sed -i '' \
	   -e "s|url \".*\"|url \"$$URL\"|" \
	   -e "s|sha256 \".*\"|sha256 \"$$SHA\"|" \
	   -e "s|version \".*\"|version \"$$VERSION\"|" \
	   Formula/ghm.rb; \
	 echo "✅ Formula/ghm.rb actualizada (SHA256: $$SHA)"
