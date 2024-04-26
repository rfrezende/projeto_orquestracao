#!/usr/bin/env bash
###################################################################################
#
# Script para criar o redirecionamento de portas no ambiente no minikube
#
# Parte do projeto do módulo Orquestração do treinamento Jornada Digital ADA-Caixa
#
# Autor: Roberto Flavio Rezende
#

set -e

echo -e '\n==== Criando os redirecionamentos de porta para o ambiente do projeto ====\n\n'
minikube kubectl -- port-forward service/rabbitmq-service 15672:15672 &
minikube kubectl -- port-forward service/minio-service 9000:9000 &
minikube kubectl -- port-forward service/minio-service 9001:9001 &
minikube kubectl -- port-forward service/redis-service 8001:8001 &
