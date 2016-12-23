package com.cloume.shaw.igia.repository;

import org.springframework.data.mongodb.repository.MongoRepository;

import com.cloume.shaw.igia.common.resource.Task;

public interface TaskRepository extends MongoRepository<Task, String> {

	/**
	 * 根据课程名查找相应的课程作业
	 * @param courseName
	 * @return
	 */
	public Task findTaskByCourseName(String courseName);
}
