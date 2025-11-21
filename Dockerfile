FROM node:18-alpine AS build

WORKDIR /app

COPY package*.json ./

RUN npm install

COPY . .

RUN npm run build


FROM node:18-alpine

WORKDIR /app

COPY package*.json ./

RUN npm install --production

COPY --from=build /app/build ./build

COPY src ./src


ENV NODE_ENV=production

ENV PORT=8000

EXPOSE 8000

USER node

CMD ["node", "src/server.js"]


FROM nginx:alpine

WORKDIR /usr/share/nginx/html

COPY --from=build /app/build .

COPY env.sh .

RUN chmod +x env.sh

CMD ["sh", "-c", "./env.sh && nginx -g 'daemon off;'"]
