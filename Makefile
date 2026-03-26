
VERSION=1.108.2

vscode-web:
	rm -rf ./dist && mkdir -p ./dist/vscode	
	docker build -t vscode-web . --build-arg VSCODE_VERSION=$(VERSION)
	docker run --rm -v ./dist/vscode:/dist vscode-web
	cp index.html ./dist
.PHONY: vscode-web

vscode-web-artifact: vscode-web
	zip -r vscode-web-$(VERSION).zip ./dist
.PHONY: vscode-web-artifact
