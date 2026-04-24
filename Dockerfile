FROM node:24 AS build

WORKDIR /usr/src/app
COPY package*.json ./
RUN npm ci
COPY . .
RUN npx expo export --platform web

FROM node:24-alpine

WORKDIR /usr/src/app
RUN npm install -g serve
COPY --from=build /usr/src/app/dist ./dist

EXPOSE 3000
CMD ["serve", "-s", "dist", "-l", "3000"]
