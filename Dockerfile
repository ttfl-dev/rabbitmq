# Use the latest RabbitMQ image with management enabled
FROM rabbitmq:3-management

# Copy custom RabbitMQ configuration
COPY rabbitmq.conf /etc/rabbitmq/

# Set environment variable for RabbitMQ node name
ENV RABBITMQ_NODENAME=rabbit@localhost

# Install the rabbitmq_delayed_message_exchange plugin
RUN rabbitmq-plugins enable --offline rabbitmq_delayed_message_exchange

# Ensure correct ownership of the configuration file
RUN chown rabbitmq:rabbitmq /etc/rabbitmq/rabbitmq.conf

# Switch to the RabbitMQ user for security
USER rabbitmq:rabbitmq