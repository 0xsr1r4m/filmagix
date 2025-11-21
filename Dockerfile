FROM node:18-alpine AS build

WORKDIR /app

COPY package*.json ./

RUN npm install

ARG REACT_APP_TMDB_KEY

ENV REACT_APP_TMDB_KEY=d765e99bf4e07fda8dffabd8ea8a1f36

COPY . .

RUN npm run build


FROM node:18-alpine

WORKDIR /app

COPY package*.json ./

RUN npm install --production

COPY --from=build /app/build ./build

COPY src ./src


ENV REACT_APP_ENV=production

ENV REACT_APP_PORT=8000

EXPOSE 8000

USER node

CMD ["node", "src/server.js"]
