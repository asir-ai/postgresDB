FROM postgres:16-alpine

# Install Nginx and the required TCP streaming module
RUN apk add --no-cache nginx nginx-mod-stream

# Set up your DB credentials
ENV POSTGRES_DB=nest_prod_db
ENV POSTGRES_USER=postgres_admin
ENV POSTGRES_PASSWORD=choose_a_very_secure_password_123!

# Expose ports (Render maps public traffic to port 80/443 by default)
EXPOSE 80
EXPOSE 5432

# Create a valid nginx.conf loading the stream module explicitly
RUN echo 'load_module /usr/lib/nginx/modules/ngx_stream_module.so; \
    events { worker_connections 1024; } \
    http { server { listen 80; location / { return 200 "OK"; } } } \
    stream { server { listen 8080; proxy_pass 127.0.0.1:5432; } }' > /etc/nginx/nginx.conf

# Start both Postgres and Nginx together
CMD ["sh", "-c", "nginx && docker-entrypoint.sh postgres"]
