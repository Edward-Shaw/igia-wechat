package com.cloume.shaw.igia.repository;

import org.springframework.data.mongodb.repository.MongoRepository;

import com.cloume.shaw.igia.common.resource.User;

public interface UserRepository extends MongoRepository<User, String> {
	
	public User findById(String id);
}
