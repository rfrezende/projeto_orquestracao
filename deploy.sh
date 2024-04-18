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

set -e

echo -e '\n==== Aplicando o deployment do ambiente do projeto ====\n\n'
minikube kubectl -- apply -f deployment.yaml

echo -e '\n\n==== Esperando 20 segundos para os serviços subirem ====\n'

BAR='####################'

echo -e '\t┌────────────────────┐'

for i in {1..20}; do
    echo -ne "\r\t ${BAR:0:$i}"
    sleep 1
done

minikube kubectl -- config set-context --current --namespace=projeto-orquestracao

consumer=$(minikube kubectl -- get pods | grep consumer | cut -d' ' -f 1)

echo -e '\n\n==== Exibindo o log do consumer (pressione "Control + c" para sair) ====\n'
minikube kubectl -- logs --follow $consumer
