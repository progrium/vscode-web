FROM node:20-alpine as vscode-web
RUN apk add -u krb5-dev libx11-dev libxkbfile-dev git build-base python3
RUN git clone --depth 1 https://github.com/microsoft/vscode.git -b 1.90.1
WORKDIR /vscode
RUN yarn
COPY ./workbench.ts ./src/vs/code/browser/workbench/workbench.ts
COPY ./extensionHostWorker.ts ./src/vs/workbench/api/worker/extensionHostWorker.ts
COPY ./webWorkerExtensionHostIframe.html ./src/vs/workbench/services/extensions/worker/webWorkerExtensionHostIframe.html
RUN yarn gulp vscode-web-min
RUN mv /vscode-web/node_modules /vscode-web/modules

CMD cp -r /vscode-web/* /dst 