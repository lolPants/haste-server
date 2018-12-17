FROM node:10-alpine
WORKDIR /usr/app

COPY package.json package-lock.json ./
RUN apk add --no-cache tini bash git openssh && \
  npm ci && \
  apk del bash git openssh

COPY . .
RUN chmod 755 app.sh

EXPOSE 7777
ENV STORAGE_TYPE file
ENTRYPOINT ["/sbin/tini", "--"]
CMD ["./app.sh"]
