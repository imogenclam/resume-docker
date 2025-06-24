FROM ubuntu:20.04

# Устанавливаем tzdata без диалогов
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && \
    apt-get install -y tzdata && \
    ln -fs /usr/share/zoneinfo/Europe/Moscow /etc/localtime && \
    dpkg-reconfigure --frontend noninteractive tzdata

# Ставим TexLive и зависимости
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