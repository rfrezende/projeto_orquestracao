# coding=utf-8
###############################################################################
#
# Módulo python para criar conexáo com o RabbitMQ.
# 
# Parte do projeto para o módulo Orquestração do treinamento Jornada Digital 
# ADA-Caixa
#
# Autor: Roberto Flavio Rezende
#
import pika
from time import sleep
from print_log import print_log


def new_connection(usuario, senha, host='rabbitmq-service', vhost='projeto'):
    """ Função para estabelecer a conexão com o RabbitMQ

    Args:
        usuario (str): Usuario de acesso ao RabbitMQ
        senha (str): Senha de acesso ao RabbitMQ
        host (str): Endereço do RabbitMQ
        vhost (str): RabbitMQ virtual host a ser utilizado.

    Returns:
        object: Objeto de conexão ao RabbitMQ
    """

    channel = None
    while not channel:
        try:
            conn_credentials = pika.PlainCredentials(username=usuario, password=senha)
            conn_parms = pika.ConnectionParameters(host=host, credentials=conn_credentials, virtual_host=vhost)
            connection = pika.BlockingConnection(conn_parms)
            channel = connection.channel()
        except:
            print_log('Aguardando RabbitMQ')
            sleep(5)
            pass
    
    print_log('Conectado ao RabbitMQ')
    return channel
    

def declare_queue(channel, queue_name='transacoes_solicitadas', exchange_name='transacoes', rkey='solicitar'):
    """ Função para facilitar a configuração do RabbitMQ

    Args:
        channel (str): Objeto de conexão ao RabbitMQ
        queue_name (str, optional): Nome da fila utilizada. Defaults to 'transacoes_solicitadas'.
        exchange_name (str, optional): Nome do exchange utilizado. Defaults to 'transacoes'.
        rkey (str, optional): Nome da chave de roteamento (Routing Key). Defaults to 'solicitar'.
    """
    existe_exchange = False
    while not existe_exchange:
        try: 
            channel.queue_declare(queue=queue_name, durable=True)
            channel.queue_bind(queue=queue_name, exchange=exchange_name, routing_key=rkey)
            existe_exchange = True
        except pika.exceptions.ChannelClosedByBroker:
            print_log('Aguardando a criacao do exchange no RabbitMQ')
            pass
        except pika.exceptions.ChannelWrongStateError:
            print_log('Aguardando a criacao do exchange no RabbitMQ')
            pass
