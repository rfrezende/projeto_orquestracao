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

echo -e '==== Instalando o Minikube ===='
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
sudo install minikube-linux-amd64 /usr/bin/minikube && rm minikube-linux-amd64

echo -e '\n==== Iniciando o Minikube ===='
minikube start

echo -e '\n==== Habilitando os addons necessários no Minikube ===='
minikube addons enable ingress

echo -e '\n==== Incluindo os endereços no arquivo de hosts ===='
sudo bash -c "echo -e '\n# Ambiente do Projeto ADA/Caixa' >> /etc/hosts"
sudo bash -c "echo '$(minikube ip) projeto.ada.minio' >> /etc/hosts"
sudo bash -c "echo '$(minikube ip) projeto.ada.rabbitmq' >> /etc/hosts"
sudo bash -c "echo '$(minikube ip) projeto.ada.redis' >> /etc/hosts"

echo -e '\n==== Instalação finalizada ===='
