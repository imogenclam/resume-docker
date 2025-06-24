# Получаем систему из choose_system.py
FROM python:3.9-slim as system_chooser
COPY choose_system.py .
RUN python choose_system.py > /system.txt

# Основной образ
FROM $(cat /system.txt)  # Здесь будет подставлена выбранная система

FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && \
    apt-get install -y tzdata && \
    ln -fs /usr/share/zoneinfo/Europe/Moscow /etc/localtime && \
    dpkg-reconfigure --frontend noninteractive tzdata

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    texlive-full \
    dvipng \
    cm-super \
    && rm -rf /var/lib/apt/lists/*

# Копируем файлы резюме
COPY . /resume
WORKDIR /resume

# Скрипт для сборки
COPY build.sh /build.sh
RUN chmod +x /build.sh

# Запускаем сборку
ENTRYPOINT ["/build.sh"]
