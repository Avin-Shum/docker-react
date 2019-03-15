FROM node:11.10-alpine as builder

ARG HTTP_PROXY
ENV HTTP_PROXY=$HTTP_PROXY
ENV HTTPS_PROXY=$HTTP_PROXY

WORKDIR /app
COPY package.json .
RUN npm install
COPY . .
# RUN ["npm", "run", "build"]
RUN npm run build

FROM nginx
EXPOSE 80
COPY --from=builder /app/build /usr/share/nginx/html
