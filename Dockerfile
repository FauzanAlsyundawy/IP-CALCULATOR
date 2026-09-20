FROM node:20-alpine AS build

WORKDIR /app/src
COPY src/package*.json /app/src/
RUN npm install

COPY . /app
RUN npm run build

FROM nginx:alpine

COPY nginx.conf /etc/nginx/conf.d/default.conf
COPY --from=build /app/dist /usr/share/nginx/html

EXPOSE 3000 80 8080

HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
  CMD ["sh", "-c", "wget --no-verbose --tries=1 --spider http://localhost:3000/ || exit 1"]

CMD ["nginx", "-g", "daemon off;"]
