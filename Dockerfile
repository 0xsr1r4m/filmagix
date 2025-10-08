FROM node:18-alpine AS build
////////////////////////
WORKDIR /src

COPY package*.json ./
RUN npm install

COPY . .
RUN npm run build

FROM node:18-alpine

WORKDIR /src

COPY package*.json ./
RUN npm install --production

COPY --from=build /src/build ./build

COPY src ./src

ENV NODE_ENV=production
ENV PORT=3000

RUN addgroup appgroup && adduser -S appuser -G appgroup
USER appuser

EXPOSE 3000

CMD ["node", "src/server.js"]