FROM ubuntu:22.04

# Evita prompts interativos
ENV DEBIAN_FRONTEND=noninteractive

# Define a senha do SYSDBA
ENV ISC_PASSWORD=@Sun147oi.

# Instala dependências essenciais
RUN apt-get update && apt-get install -y \
    wget curl xz-utils libncurses6 libtommath1 net-tools && \
    rm -rf /var/lib/apt/lists/*

# Baixa e instala o Firebird 4.0.5.3140 (SuperServer)
RUN wget https://github.com/FirebirdSQL/firebird/releases/download/v4.0.5/Firebird-4.0.5.3140-0.amd64.tar.gz && \
    tar -xzf Firebird-4.0.5.3140-0.amd64.tar.gz && \
    cd Firebird-4.0.5.3140-0.amd64 && \
    ./install.sh -silent && \
    cd .. && rm -rf Firebird-4.0.5.3140-0*

# Cria diretório de dados para ser usado como volume
VOLUME ["/firebird/data"]

# Expõe a porta padrão do Firebird
EXPOSE 3050

# Comando para iniciar o Firebird em modo contínuo
CMD ["/opt/firebird/bin/fbguard", "-forever"]
