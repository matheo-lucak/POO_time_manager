FROM node:lts-hydrogen

EXPOSE "${APP_PORT}"
WORKDIR /app

COPY package*.json ./

RUN npm install

CMD [ "npm", "run", "dev"]

