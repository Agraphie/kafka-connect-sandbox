package com.example.kafkaconnectquickstart.user;

import jakarta.persistence.Entity;
import jakarta.persistence.EntityListeners;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.Id;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import lombok.Data;
import org.springframework.data.annotation.CreatedDate;
import org.springframework.data.annotation.LastModifiedDate;
import org.springframework.data.jpa.domain.support.AuditingEntityListener;

import java.time.Instant;

@EntityListeners(AuditingEntityListener.class)
@Entity(name = "demo_user")
@Data
public class User {
    @Id
    @GeneratedValue
    private int id;
    @CreatedDate
    @NotNull
    private Instant createdAt;

    @LastModifiedDate
    @NotNull
    private Instant updatedAt;

    @NotBlank
    private String name;

}
