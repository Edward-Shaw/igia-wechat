package com.cloume.shaw.igia.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.cloume.shaw.igia.common.resource.Course;
import com.cloume.shaw.igia.common.rest.RestResponse;
import com.cloume.shaw.igia.common.utils.Const;
import com.cloume.shaw.igia.repository.CourseRepository;

@RestController
@RequestMapping(value = "/api/course")
public class CourseController extends AbstractController {
	
	@Autowired
	private CourseRepository courseRepository;
	
	@RequestMapping(method = RequestMethod.GET)
	public RestResponse<HashMap<String, List<Course>>> getCourseList(){
		
		List<Course> courses = courseRepository.findByState(Const.STATE_PUBLISHED);

		HashMap<String, List<Course>> classifiedCourses = new HashMap<>();
		for(Course course : courses){
			if(classifiedCourses.containsKey(course.getClassification())){
				classifiedCourses.get(course.getClassification()).add(course);
			}else{
				List<Course> tempList = new ArrayList<Course>();
				tempList.add(course);
				classifiedCourses.put(course.getClassification(), tempList);
			}
		}
		
		return RestResponse.good(classifiedCourses);
	}
}
