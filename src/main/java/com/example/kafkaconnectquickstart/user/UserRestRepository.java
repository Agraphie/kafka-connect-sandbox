package com.example.kafkaconnectquickstart.user;

import org.springframework.data.repository.CrudRepository;
import org.springframework.data.rest.core.annotation.RepositoryRestResource;

@RepositoryRestResource(collectionResourceRel = "users", path = "users")
public interface UserRestRepository extends CrudRepository<User, Integer> {
}
