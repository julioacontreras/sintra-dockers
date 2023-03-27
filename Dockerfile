FROM node:18-alpine

RUN apk update && apk add bash

RUN npm i -g typescript
RUN npm install pm2 -g

# MEDIA SERVICE
WORKDIR /var/html/media-service
COPY vip-media-service/package*.json ./
RUN npm install
COPY vip-media-service .
RUN npm run build
COPY pm2-media-service.json ./pm2.json
EXPOSE 4000

# AUTH SERVICE
WORKDIR /var/html/auth-service
COPY vip-auth-service/package*.json ./
RUN npm install
COPY vip-auth-service .
RUN npm run build
COPY pm2-auth-service.json ./pm2.json
EXPOSE 4010

WORKDIR /var/html
COPY startup.sh .
RUN chmod +x startup.sh
CMD ["/bin/bash","-c","./startup.sh"]
