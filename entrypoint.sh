#!/bin/bash
# Cria diretórios necessários
mkdir -p /var/spool/slurm
mkdir -p /var/spool/slurmd
mkdir -p /var/log/slurm

# Define permissões apropriadas
chown -R slurm:slurm /var/spool/slurm /var/spool/slurmd /var/log/slurm

# Inicia o Munge
echo "Iniciando Munge..."
/etc/init.d/munge start

# Inicia o Slurm Controller e Node
echo "Iniciando Slurm..."
slurmctld -D &
slurmd -D &
sleep 5

# Mantém o container ativo
/bin/bash
