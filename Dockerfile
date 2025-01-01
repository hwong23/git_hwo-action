# Container image that runs your code
FROM debian:11

# Copies your code file from your action repository to the filesystem path `/` of the container
# Entrypoint and prepare settings overwrite
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Code file to execute when the docker container starts up (`entrypoint.sh`)
ENTRYPOINT ["/entrypoint.sh"]

