FROM node:alpine as builder
WORKDIR '/app'
COPY package.json .
RUN npm install
RUN mkdir -p node_modules/.cache && chmod -R 777 node_modules/.cache
COPY . .
RUN npm run build

FROM nginx as production_server
EXPOSE 80
COPY --from=builder /app/build /usr/share/nginx/html
