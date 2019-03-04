FROM node:alpine as builder


ENV HTTP_PROXY="http://172.5.2.110:8080/"
ENV HTTPS_PROXY="http://172.5.2.110:8080/"

WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

FROM nginx
COPY --from=builder /app/build /usr/share/nginx/html
