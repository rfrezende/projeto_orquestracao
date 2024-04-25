#!/usr/bin/env bash
###################################################################################
#
# Script para deployment do ambiente no minikube
#
# Parte do projeto do módulo Orquestração do treinamento Jornada Digital ADA-Caixa
#
# Autor: Roberto Flavio Rezende
#

set -e

# Troca o contexto para o namespace do projeto
minikube kubectl -- config set-context --current --namespace=projeto-orquestracao

echo -e '\n==== Aplicando o deployment do ambiente do projeto ====\n\n'

for deployment in ./deployment/*.yaml; do
    minikube kubectl -- apply -f $deployment
done

echo -e '\n\n==== Esperando 20 segundos para os serviços subirem ====\n'

# Só porque fica bonitinho
BAR='####################'
echo -e '\t┌────────────────────┐'
for i in {1..20}; do
    echo -ne "\r\t ${BAR:0:$i}"
    sleep 1
done

echo -e '\n\n==== Exibindo o log do consumer (pressione "Control + c" para sair) ===='
echo -e '\n==== Pode demorar para começar a aparecer os relatórios ====\n\n'
consumer=$(minikube kubectl -- get pods | grep consumer | cut -d' ' -f 1)
minikube kubectl -- logs --follow $consumer
