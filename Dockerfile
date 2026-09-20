FROM nginx:alpine

# Clean default configs
RUN rm -rf /etc/nginx/conf.d/*

# Copy custom nginx configuration
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Copy pre-built static application
COPY dist /usr/share/nginx/html

EXPOSE 3000 80 8080

CMD ["nginx", "-g", "daemon off;"]
