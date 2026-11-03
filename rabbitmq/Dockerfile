FROM rabbitmq:3.12.14-management
# 3.12.14 is the last 3.12 image; pull in Ubuntu security fixes published since.
RUN apt-get update && apt-get upgrade -y --no-install-recommends && rm -rf /var/lib/apt/lists/*
COPY rabbitmq_delayed_message_exchange-3.12.0.ez /opt/rabbitmq/plugins/
RUN rabbitmq-plugins enable --offline rabbitmq_management rabbitmq_delayed_message_exchange
HEALTHCHECK --interval=10s --timeout=5s --retries=10 CMD ["rabbitmq-diagnostics", "-q", "check_port_connectivity"]
