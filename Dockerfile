# Use the correct Kind node image
FROM kindest/node:v1.33.1

# The COPY command copies the file from your local Windows path
# to the Linux path inside the container.
COPY ghcr-ca.crt /usr/local/share/ca-certificates/ghcr-ca.crt

# Update the trusted certificates inside the container.
RUN update-ca-certificates
