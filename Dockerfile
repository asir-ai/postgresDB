FROM postgres:16-alpine

# Install Nginx to intercept Render's HTTP health checks
RUN apk add --no-cache nginx envsubst

# Set up your DB credentials
ENV POSTGRES_DB=nest_prod_db
ENV POSTGRES_USER=postgres_admin
ENV POSTGRES_PASSWORD=choose_a_very_secure_password_123!

# Expose standard Web Service port (Render pings 80 by default)
EXPOSE 80
EXPOSE 5432

# Configure Nginx to answer HTTP pings on port 80 and stream TCP to 5432
RUN echo 'events {} \
    http { server { listen 80; location / { return 200 "OK"; } } } \
    stream { server { listen 8080; proxy_pass 127.0.0.1:5432; } }' > /etc/nginx/nginx.conf

# Start both Postgres and Nginx together
CMD ["sh", "-c", "nginx && docker-entrypoint.sh postgres"]
