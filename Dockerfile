FROM nginx:alpine

# Remove old configs
RUN rm -rf /etc/nginx/conf.d/*

# Create custom config listening on ALL ports (3000, 80, 8080) directly
RUN printf 'server {\n\
    listen 3000 default_server;\n\
    listen 80;\n\
    listen 8080;\n\
    server_name _;\n\
    root /usr/share/nginx/html;\n\
    index index.html index.htm;\n\
    location / {\n\
        try_files $uri $uri/ /index.html;\n\
    }\n\
    error_page 404 /404.html;\n\
    location = /404.html {\n\
        internal;\n\
    }\n\
}\n' > /etc/nginx/conf.d/default.conf

# Copy pre-built static application
COPY dist /usr/share/nginx/html

EXPOSE 3000 80 8080

CMD ["nginx", "-g", "daemon off;"]
