ARG BASE_IMAGE=python:3.13-slim-bookworm
ARG APP_FOLDER=/var/www/app

FROM ${BASE_IMAGE} AS base_builder
# ARG KNOWN_HOSTS

RUN : "---------- install OS libs ----------" \
    && apt-get update -y \
    && apt-get install -y --no-install-recommends \
        build-essential \
        git \
        openssh-client \
        build-essential \
        libssl-dev \
        libffi-dev \
        make \
        gcc \
        libpq-dev \
        zlib1g-dev \
    && apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false \
    && rm -rf /var/lib/apt/lists/*

FROM base_builder AS dependencies_builder

WORKDIR ${APP_FOLDER}

COPY requirements/dev.txt /tmp/requirements/

RUN : "---------- build project dependencies --------------" \
    && python -m pip install --upgrade pip  \
    && python -m pip wheel --wheel-dir=/root/wheels -r /tmp/requirements/dev.txt;

# Final app image
FROM ${BASE_IMAGE} AS app_final_image
ARG APP_FOLDER

WORKDIR ${APP_FOLDER}

COPY --from=dependencies_builder /root/wheels /root/wheels

RUN : "---------- install container extras ----------" \
    && apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y \
    procps \
    curl \
    netcat-traditional \
    openssl;

RUN : "---------- install project libs ----------" \
    && WHEELS=$(cd /root/wheels; ls -1 *.whl | awk -F - '{ gsub("_", "-", $1); print $1 }' | uniq) \
    && python -m pip install --no-index --find-links=/root/wheels $WHEELS;


# Django app
EXPOSE 8000

WORKDIR ${APP_FOLDER}
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]
