package com.example.kafkaconnectquickstart;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.data.jpa.repository.config.EnableJpaAuditing;

@SpringBootApplication
@EnableJpaAuditing
public class KafkaConnectQuickstartApplication {

    public static void main(String[] args) {
        SpringApplication.run(KafkaConnectQuickstartApplication.class, args);
    }

}
