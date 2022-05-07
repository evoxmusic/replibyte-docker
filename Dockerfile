FROM debian:buster as replibyte

RUN apt clean && apt update && apt install -y jq wget curl

WORKDIR replibyte

# Download RepliByte binary
RUN curl -s https://api.github.com/repos/Qovery/replibyte/releases/latest | jq -r '.assets[].browser_download_url' | grep -i 'tar.gz$' | wget -qi - && \
    tar zxf *.tar.gz && \
    mv `ls replibyte*-linux-musl` replibyte && \
    chmod +x replibyte

ENV PATH="/replibyte:${PATH}"

ARG S3_ACCESS_KEY_ID
ENV S3_ACCESS_KEY_ID $S3_ACCESS_KEY_ID

ARG S3_SECRET_ACCESS_KEY
ENV S3_SECRET_ACCESS_KEY $S3_SECRET_ACCESS_KEY

ARG S3_REGION
ENV S3_REGION $S3_REGION

ARG S3_BUCKET
ENV S3_BUCKET $S3_BUCKET

ARG SOURCE_CONNECTION_URI
ENV SOURCE_CONNECTION_URI $SOURCE_CONNECTION_URI

ARG DESTINATION_CONNECTION_URI
ENV DESTINATION_CONNECTION_URI $DESTINATION_CONNECTION_URI

ARG ENCRYPTION_SECRET
ENV ENCRYPTION_SECRET $ENCRYPTION_SECRET

COPY replibyte.yaml .
