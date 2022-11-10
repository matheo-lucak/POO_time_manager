FROM node:lts-alpine as app_prod

EXPOSE "${APP_PORT}"

RUN npm install -g http-server

WORKDIR /app

COPY package*.json ./

RUN npm install

COPY . .

RUN npm run build

CMD [ "http-server", "dist", "-p", "5173"]

FROM node:lts-hydrogen as app_dev

EXPOSE "${APP_PORT}"
WORKDIR /app

COPY package*.json ./

RUN npm install

CMD [ "npm", "run", "dev"]

