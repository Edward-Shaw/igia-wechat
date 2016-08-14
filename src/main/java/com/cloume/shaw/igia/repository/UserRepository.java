package com.cloume.shaw.igia.repository;

import org.springframework.data.mongodb.repository.MongoRepository;

import com.cloume.shaw.igia.resource.IgiaUser;

public interface UserRepository extends MongoRepository<IgiaUser, String> {
}
