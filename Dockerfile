# Container image that runs your code
FROM debian:11

# Copies your code file from your action repository to the filesystem path `/` of the container
COPY entrypoint.sh .

# Code file to execute when the docker container starts up (`entrypoint.sh`)
ENTRYPOINT ["/usr/src/entrypoint.sh"]

