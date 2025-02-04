
# Create new topic
docker exec -it kafka-broker-01 kafka-topics --bootstrap-server kafka-broker-01:9091,kafka-broker-02:9092,kafka-broker-03:9093  --topic topic1 --create --partitions 3 --replication-factor 1

# List created topics
docker exec -it kafka-broker-01 kafka-topics --bootstrap-server kafka-broker-01:9091,kafka-broker-02:9092,kafka-broker-03:9093  --list

# Describe existing topic
docker exec -it kafka-broker-01 kafka-topics --bootstrap-server kafka-broker-01:9091,kafka-broker-02:9092,kafka-broker-03:9093  --describe --topic topic1

# Delete existing topic
docker exec -it kafka-broker-01 kafka-topics --bootstrap-server kafka-broker-01:9091,kafka-broker-02:9092,kafka-broker-03:9093 --delete --topic topic1 

# Produce Message to Kafka topic
docker exec -it kafka-broker-01  kafka-console-producer --bootstrap-server kafka-broker-01:9091,kafka-broker-02:9092,kafka-broker-03:9093 --topic topic1

# Consume Message from Kafka Topic (messages pushed after consumer command executed)
docker exec -it kafka-broker-01  kafka-console-consumer --bootstrap-server kafka-broker-01:9091,kafka-broker-02:9092,kafka-broker-03:9093 --topic topic1

# Example JSON: {"name":"Semetey", "title":"Solution Architect"}

# Consume Message from Kafka Topic (all messages which are note retentioned)
docker exec -it kafka-broker-01  kafka-console-consumer --bootstrap-server kafka-broker-01:9091,kafka-broker-02:9092,kafka-broker-03:9093 --topic topic1 --from-beginning

