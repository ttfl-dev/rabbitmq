# Use the latest RabbitMQ image with management enabled
FROM rabbitmq:3-management

# Install the rabbitmq_delayed_message_exchange plugin
RUN apt-get update && \
    apt-get install -y curl && \
    curl -L -o /opt/rabbitmq/plugins/rabbitmq_delayed_message_exchange.ez \
    https://github.com/rabbitmq/rabbitmq-delayed-message-exchange/releases/download/v3.11.4/rabbitmq_delayed_message_exchange-3.11.4.ez && \
    rabbitmq-plugins enable --offline rabbitmq_delayed_message_exchange && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Copy custom RabbitMQ configuration
COPY rabbitmq.conf /etc/rabbitmq/

# Set environment variable for RabbitMQ node name
ENV RABBITMQ_NODENAME=rabbit@localhost

# Ensure correct ownership of the configuration file
RUN chown rabbitmq:rabbitmq /etc/rabbitmq/rabbitmq.conf

# Switch to the RabbitMQ user for security
USER rabbitmq:rabbitmq
