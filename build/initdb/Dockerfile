FROM mysql:8

COPY . /usr/src/initdb/
RUN chmod +x /usr/src/initdb/entry.sh
ENTRYPOINT /usr/src/initdb/entry.sh

# https://github.com/docker-library/healthcheck/blob/master/mysql/Dockerfile
COPY docker-healthcheck /usr/local/bin/
RUN chmod +x /usr/local/bin/docker-healthcheck
HEALTHCHECK --interval=5s --timeout=5s --retries=3 CMD ["docker-healthcheck"]
