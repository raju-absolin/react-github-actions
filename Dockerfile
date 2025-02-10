ARG NODE_VERSION=21.5.0
FROM node:${NODE_VERSION}-alpine AS builder

WORKDIR /app
COPY . .
RUN yarn install

RUN npm run build

FROM nginx:stable-alpine
WORKDIR /usr/share/nginx/html
RUN rm -rf ./*

COPY --from=builder /app/default.conf /etc/nginx/conf.d
COPY --from=builder /app/build /usr/share/nginx/html

ENTRYPOINT ["nginx", "-g", "daemon off;"]


