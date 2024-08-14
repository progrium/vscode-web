.PHONY: vscode vscode-web vscode-web-patched

VERSION=1.92.1

vscode-web-patched: 
	rm -rf ./dist && mkdir -p ./dist/vscode	
	docker build -t vscode-web ./patched --build-arg VERSION=$(VERSION)
	docker run --rm -v ./dist/vscode:/dist vscode-web

vscode-web: 
	rm -rf ./dist && mkdir -p ./dist/vscode	
	docker build -t vscode-web . --build-arg VERSION=$(VERSION)
	docker run --rm -v ./dist/vscode:/dist vscode-web

vscode:
	git clone --depth 1 https://github.com/microsoft/vscode.git -b $(VERSION)