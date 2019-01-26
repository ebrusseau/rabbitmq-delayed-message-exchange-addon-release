#!/bin/bash -e

PLUGIN_PACKAGE_PATH=/var/vcap/packages/rabbitmq-delayed-message-exchange-plugin
RMQ_PACKAGE_PATH=/var/vcap/packages/rabbitmq-server
PATH=$PATH:/var/vcap/packages/erlang/bin

. /var/vcap/jobs/rabbitmq-server/lib/rabbitmq-config-vars.bash

unzip $PLUGIN_PACKAGE_PATH/rabbitmq-delayed-message-exchange-plugin-$RMQ_SERVER_VERSION.x.zip -d $RMQ_PACKAGE_PATH/plugins

$RMQ_PACKAGE_PATH/bin/rabbitmq-plugins enable rabbitmq_delayed_message_exchange
$RMQ_PACKAGE_PATH/bin/rabbitmq-plugins list
