FROM postgres:16-alpine

# Set default configuration variables
ENV POSTGRES_DB=nest_prod_db
ENV POSTGRES_USER=postgres_admin
ENV POSTGRES_PASSWORD=choose_a_very_secure_password_123!

# Expose the standard Postgres port
EXPOSE 5432

# Override the default command to force PostgreSQL to listen on port 5432
CMD ["postgres", "-p", "5432"]
