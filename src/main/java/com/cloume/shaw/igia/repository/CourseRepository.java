package com.cloume.shaw.igia.repository;

import java.util.List;

import org.springframework.data.mongodb.repository.MongoRepository;

import com.cloume.shaw.igia.common.resource.Course;

public interface CourseRepository extends MongoRepository<Course, String> {
	
	List<Course> findByState(String state);
}
