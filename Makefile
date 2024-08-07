
vscode-web: 
	rm -rf ./dist || true
	mkdir -p ./dist	
	docker build -t vscode-web .
	docker run --rm -v ./dist:/dst vscode-web