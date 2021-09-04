FROM node:12.7-alpine AS build

WORKDIR /usr/src/app

COPY package.json package-lock.json ./

RUN npm cache clean --force

RUN npm i

COPY . .
RUN npm run build

### STAGE 2: Run ###
FROM nginx:1.17.1-alpine

COPY --from=build /usr/src/app/dist/FEApp /usr/share/nginx/html

EXPOSE 8081