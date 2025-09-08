FROM node:22-alpine
RUN apk add -u krb5-dev libx11-dev libxkbfile-dev libsecret-dev git build-base python3
ARG VSCODE_VERSION=1.103.2
RUN git clone --depth 1 https://github.com/microsoft/vscode.git -b $VSCODE_VERSION
WORKDIR /vscode
RUN npm i
RUN npm run gulp vscode-web-min

# For use with `docker run -v ./dist:/dist ...`
CMD cp -r /vscode-web/* /dist