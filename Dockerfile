FROM ubuntu:22.04

# Definição do usuário
ARG USERNAME=slurmuser
ARG PASSWORD=slurm123

# Instalação de dependências
RUN apt-get update && apt-get install -y \
    build-essential \
    python3.10 \
    python3.10-venv \
    python3-pip \
    slurm-wlm \
    munge \
    sudo \
    wget \
    git \
    && apt-get clean

# Configuração do usuário padrão
RUN useradd -m -s /bin/bash ${USERNAME} && echo "${USERNAME}:${PASSWORD}" | chpasswd \
    && usermod -aG sudo ${USERNAME}

# Copia arquivos de configuração
COPY slurm.conf /etc/slurm/slurm.conf
COPY munge.key /etc/munge/munge.key
COPY entrypoint.sh /entrypoint.sh

# Permissões necessárias
RUN chown -R munge:munge /etc/munge/munge.key && chmod 600 /etc/munge/munge.key
RUN chmod +x /entrypoint.sh

# Instalação do MMDetection (será usado no job)
RUN mkdir /workspace
WORKDIR /workspace
RUN git clone https://github.com/open-mmlab/mmdetection.git
COPY job/requirements.txt /workspace/mmdetection/
RUN cd mmdetection && python3.10 -m venv venv && ./venv/bin/pip install -r requirements.txt

# Definição do entrypoint
ENTRYPOINT ["/entrypoint.sh"]
