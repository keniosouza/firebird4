FROM ubuntu:22.04

# Evita prompts interativos durante a instalação
ENV DEBIAN_FRONTEND=noninteractive

# Define senha padrão do SYSDBA
ENV ISC_PASSWORD='@Sun147oi.'

# Instala bibliotecas necessárias
RUN apt-get update && apt-get install -y \
    wget curl xz-utils libncurses6 libtommath1 net-tools \
    libicu70 && \
    rm -rf /var/lib/apt/lists/*

# Baixa e instala Firebird 4.0.5 silenciosamente
RUN wget https://github.com/FirebirdSQL/firebird/releases/download/v4.0.5/Firebird-4.0.5.3140-0.amd64.tar.gz && \
    tar -xzf Firebird-4.0.5.3140-0.amd64.tar.gz && \
    cd Firebird-4.0.5.3140-0.amd64 && \
    ./install.sh -silent && \
    cd .. && rm -rf Firebird-4.0.5.3140-0*

# Cria o diretório do banco e dá permissão
RUN mkdir -p /opt/firebird/database && chown firebird:firebird /opt/firebird/database

# Define o volume persistente (onde está o .FDB)
VOLUME ["/opt/firebird/database"]

# Expõe a porta padrão
EXPOSE 3050

# Comando que inicia o Firebird
CMD ["/opt/firebird/bin/fbguard", "-forever"]
