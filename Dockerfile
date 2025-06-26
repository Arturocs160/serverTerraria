FROM ubuntu:20.04

# Configuración básica
ENV DEBIAN_FRONTEND=noninteractive
ENV TMODLOADER_VERSION=2025.04.3.0
ENV TMODLOADER_URL=https://github.com/tModLoader/tModLoader/releases/download/v${TMODLOADER_VERSION}/tModLoader.zip
# Cambiar por el nombre de tu mundo
ENV WORLD_NAME=ejemploCambiar

# Instalación de dependencias
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    wget \
    unzip \
    libicu66 \
    libgssapi-krb5-2 \
    libssl1.1 \
    ca-certificates \
    screen \
    && rm -rf /var/lib/apt/lists/*

# Configuración de usuario
RUN useradd -m tmodloader && \
    mkdir -p /home/tmodloader/tmodloader && \
    chown -R tmodloader:tmodloader /home/tmodloader

USER tmodloader
WORKDIR /home/tmodloader/tmodloader

# Descarga e instalación de tModLoader
RUN wget ${TMODLOADER_URL} -O tModLoader.zip && \
    unzip tModLoader.zip && \
    rm tModLoader.zip && \
    chmod +x start-tModLoaderServer.sh

# Creación de directorios
RUN mkdir -p Mods Worlds Logs ModConfigs

# Copia de archivos
COPY --chown=tmodloader:tmodloader Mods/ ./Mods/
COPY --chown=tmodloader:tmodloader Worlds/ ./Worlds/
COPY --chown=tmodloader:tmodloader ModConfigs/ ./ModConfigs/
COPY --chown=tmodloader:tmodloader entrypoint.sh .

# Asegura permisos del entrypoint
RUN chmod +x entrypoint.sh

EXPOSE 7777

ENTRYPOINT ["/bin/bash", "./entrypoint.sh"]
