#!/usr/bin/env bash
###############################################################################
#
# Script para deployment do ambiente de no minikube
#
# Parte do projeto do módulo Orquestração do treinamento Jornada Digital 
# ADA-Caixa
#
# Autor: Roberto Flavio Rezende
#

# -- Obs.:
# Eu sei que não é boa prática colocar sudo dentro de scripts, mas o minikube reclama 
# se usar o sudo para executar seus comandos. É a vida.

set -e

function verificar_minikube() {
    echo $(minikube status --output=json 2>&1 | tail -1)
}

if [[ $(verificar_minikube) =~ "command not found" ]]; then
  echo -e '==== Instalando o Minikube\n'
  curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
  sudo install minikube-linux-amd64 /usr/bin/minikube && rm minikube-linux-amd64
fi

if [[ $(verificar_minikube) =~ "To start a cluster" ]]; then
  echo -e '==== Iniciando o Minikube\n'
  minikube start
fi

echo -e '\n==== Habilitando os addons necessários no Minikube'
minikube addons enable ingress
minikube addons enable metrics-server

echo -e '\n==== Incluindo os endereços no arquivo de hosts'
sudo bash -c "echo -e '\n# Ambiente do Projeto ADA/Caixa' >> /etc/hosts"
sudo bash -c "echo '$(minikube ip) minio.projeto.ada' >> /etc/hosts"
sudo bash -c "echo '$(minikube ip) rabbitmq.projeto.ada' >> /etc/hosts"
sudo bash -c "echo '$(minikube ip) redis.projeto.ada' >> /etc/hosts"

echo -e '\n==== Instalação finalizada'
