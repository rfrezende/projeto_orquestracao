#!/usr/bin/env bash

# Troca o contexto para o namespace do projeto
minikube kubectl -- config set-context --current --namespace=projeto-orquestracao

for deployment in $(ls ./deployment/*.yaml | sort -r); do
    minikube kubectl -- delete -f $deployment
done