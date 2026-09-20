FROM nginx:alpine

# Clean default configs
RUN rm -rf /etc/nginx/conf.d/*

# Copy custom nginx configuration
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Copy pre-built static application
COPY dist /usr/share/nginx/html

EXPOSE 3000 80 8080

HEALTHCHECK --interval=15s --timeout=3s --start-period=3s --retries=3 \
  CMD ["sh", "-c", "wget --no-verbose --tries=1 --spider http://localhost:3000/ || exit 1"]

CMD ["nginx", "-g", "daemon off;"]
