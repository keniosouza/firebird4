FROM ubuntu:22.04

# Evita prompts durante a instalação
ENV DEBIAN_FRONTEND=noninteractive
ENV ISC_PASSWORD=@Sun147oi.

# Instala bibliotecas necessárias ao Firebird
RUN apt-get update && apt-get install -y \
    wget curl xz-utils libncurses6 libtommath1 net-tools \
    libicu70 \
 && rm -rf /var/lib/apt/lists/*

# Baixa e instala Firebird 4.0.5.3140 (modo silencioso)
RUN wget https://github.com/FirebirdSQL/firebird/releases/download/v4.0.5/Firebird-4.0.5.3140-0.amd64.tar.gz && \
    tar -xzf Firebird-4.0.5.3140-0.amd64.tar.gz && \
    cd Firebird-4.0.5.3140-0.amd64 && \
    ./install.sh -silent && \
    cd .. && rm -rf Firebird-4.0.5.3140-0*

# Define ponto de volume onde o banco de dados ficará montado
VOLUME ["/firebird/data"]

# Expõe a porta padrão
EXPOSE 3050

# Comando padrão para manter o servidor vivo
CMD ["/opt/firebird/bin/fbguard", "-forever"]
