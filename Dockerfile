FROM python:3.10-bookworm AS build-env

ENV DEBIAN_FRONTEND noninteractive
ENV LS_COLORS di=01;36

COPY app/ /app
WORKDIR /app
RUN --mount=type=cache,target=/var/lib/apt/lists --mount=type=cache,target=/var/cache/apt/archives \
    apt update \
 && apt -y install zip \
 && mkdir python \
 && cd python \
 && pip install --no-cache-dir  -r ../requirements.txt -t ./ \
 && find ./ -type d -name __pycache__ | xargs rm -frv \
 #&& curl -LO https://github.com/adieuadieu/serverless-chrome/releases/download/v1.0.0-57/stable-headless-chromium-amazonlinux-2.zip \
 #&& unzip stable-headless-chromium-amazonlinux-2.zip -d ./bin/ \
 #&& rm stable-headless-chromium-amazonlinux-2.zip \
 && curl -LO https://github.com/adieuadieu/serverless-chrome/releases/download/v1.0.0-37/stable-headless-chromium-amazonlinux-2017-03.zip \
 && unzip stable-headless-chromium-amazonlinux-2017-03.zip -d ./bin/ \
 && rm stable-headless-chromium-amazonlinux-2017-03.zip \
 #&& curl -LO https://chromedriver.storage.googleapis.com/86.0.4240.22/chromedriver_linux64.zip \
 && curl -LO https://chromedriver.storage.googleapis.com/2.37/chromedriver_linux64.zip \
 && unzip chromedriver_linux64.zip -d ./bin/ \
 && rm chromedriver_linux64.zip \
 && cd ../ 

CMD [ "/bin/bash" ]
