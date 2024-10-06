FROM postgres:17

ENV POSTGRES_DB=authorization_service-db
ENV POSTGRES_USER=authorization_service
ENV POSTGRES_PASSWORD=authorization_service

RUN apt-get update &&  \
    apt-get install -y postgresql-contrib

COPY build/database_up.sql /docker-entrypoint-initdb.d/
