FROM python:3.9-alpine3.15

COPY . /app

WORKDIR /app

RUN apk update \
    && ls -a \
    && apk add vim libpq libpq-dev gcc musl-dev make expat-dev \
    && pip install -r requirements.txt \
    && apk del gcc musl-dev make libpq-dev expat-dev \
    && rm -rf /var/cache/*  /root/.cache/*