FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive
ENV ISC_PASSWORD=@Sun147oi.

# Instala dependências necessárias para Firebird
RUN apt-get update && apt-get install -y \
    wget curl xz-utils libncurses6 libtommath1 net-tools && \
    rm -rf /var/lib/apt/lists/*

# Baixa e instala o Firebird 4.0
RUN wget https://github.com/FirebirdSQL/firebird/releases/download/R4_0_5/Firebird-4.0.5.2937-0.amd64.tar.gz && \
    tar -xzf Firebird-4.0.5.2937-0.amd64.tar.gz && \
    cd Firebird-4.0.5.2937-0.amd64 && \
    ./install.sh -silent && \
    cd .. && rm -rf Firebird-4.0.5.2937-0.amd64*

# Cria diretório de dados (volume externo)
VOLUME ["/firebird/data"]

# Porta padrão do Firebird
EXPOSE 3050

# Script de inicialização
CMD ["/opt/firebird/bin/fbguard", "-forever"]
