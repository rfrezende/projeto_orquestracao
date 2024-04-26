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

echo -e '\n\n==== Comando para exibir o log do consumer (pressione "Control + c" para sair) ===='
echo -e '\n==== Pode demorar alguns minutos para subir tudo e começar a gerar os relatórios  ====\n\n'
consumer=$(minikube kubectl -- get pods | grep consumer | cut -d' ' -f 1)
echo minikube kubectl -- logs --follow $consumer --namespace=projeto-orquestracao
