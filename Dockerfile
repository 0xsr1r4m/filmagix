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

ENV REACT_APP_TMDB_KEY=d765e99bf4e07fda8dffabd8ea8a1f36

EXPOSE 8000

USER node

CMD ["node", "src/server.js"]


# FROM nginx:alpine

# WORKDIR /usr/share/nginx/html

# COPY --from=build /app/build .

# COPY scripts/env.sh .

# RUN chmod +x env.sh

# CMD ["sh", "-c", "./env.sh && nginx -g 'daemon off;'"]
