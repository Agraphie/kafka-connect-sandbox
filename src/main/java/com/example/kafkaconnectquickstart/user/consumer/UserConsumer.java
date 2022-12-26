package com.example.kafkaconnectquickstart.user.consumer;

import lombok.extern.log4j.Log4j2;
import org.springframework.kafka.annotation.KafkaListener;
import org.springframework.stereotype.Service;

@Service
@Log4j2
public class UserConsumer {
    @KafkaListener(topics = "postgres_demo_user", groupId = "1")
    public void listenGroupFoo(String message) {
        log.info("Received Message in group foo: " + message);
    }
}
