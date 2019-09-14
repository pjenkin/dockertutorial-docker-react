# 6-83 multi-step build using both node:alpine (in build phase) and nginx (in run phase)

# build phase
FROM node:alpine AS builder
WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

# run phase
FROM nginx
EXPOSE 80
COPY --from=builder /app/build /usr/share/nginx/html
#CMD service nginx start

# nginx started up by default by containers from this image
# cf https://hub.docker.com/_/nginx for nginx config (eg path to which to COPY content)