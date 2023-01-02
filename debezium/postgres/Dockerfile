FROM postgres:13.3
RUN apt-get update \
    && apt-get install -y vim nano
ENV POSTGRES_USER=celonis POSTGRES_PASSWORD=celonis
COPY schema/ /etc/postgresql/schema/
COPY postgresql.conf /etc/postgresql/
