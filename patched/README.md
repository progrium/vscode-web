
### extensionHostWorker.ts
* remove blocking of `postMessage` and `addEventListener`
    * lets extension send MessageChannel port up to host page

### webWorkerExtensionHostIframe.html
* add support for a `_port` message
    * lets extension send MessageChannel port up to host page
* remove hostname validation
    * not sure how it would run on a hostname with the validation marker

    
* possibly need to re-remove from `function start() {` to `worker.postMessage('vs/workbench/api/worker/extensionHostWorker');`:
```

		// Before we can load the worker, we need to get the current set of NLS
		// configuration into this iframe. We ask the parent window to send it
		// together with the necessary information to load the worker via Blob.

		const bootstrapNlsType = 'vscode.bootstrap.nls';

		self.onmessage = (event) => {
			if (event.origin !== parentOrigin || event.data.type !== bootstrapNlsType) {
				return;
			}
			const { data } = event.data;
			createWorker(data.baseUrl, data.workerUrl, data.nls.messages, data.nls.language);
		};

		window.parent.postMessage({
			vscodeWebWorkerExtHostId,
			type: bootstrapNlsType
		}, '*');
	}

	function createWorker(baseUrl, workerUrl, nlsMessages, nlsLanguage) {
		try {
			if (globalThis.crossOriginIsolated) {
				workerUrl += '?vscode-coi=2'; // COEP
			}

			const blob = new Blob([[
				`/*extensionHostWorker*/`,
				`globalThis.MonacoEnvironment = { baseUrl: '${baseUrl}' };`,
				// VSCODE_GLOBALS: NLS
				`globalThis._VSCODE_NLS_MESSAGES = ${JSON.stringify(nlsMessages)};`,
				`globalThis._VSCODE_NLS_LANGUAGE = ${JSON.stringify(nlsLanguage)};`,
				`importScripts('${workerUrl}');`,
				`/*extensionHostWorker*/`
			].join('')], { type: 'application/javascript' });

			const worker = new Worker(URL.createObjectURL(blob), { name });
```