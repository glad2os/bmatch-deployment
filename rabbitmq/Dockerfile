FROM rabbitmq:3.12.14-management
COPY rabbitmq_delayed_message_exchange-3.12.0.ez /opt/rabbitmq/plugins/
RUN rabbitmq-plugins enable --offline rabbitmq_management rabbitmq_delayed_message_exchange
