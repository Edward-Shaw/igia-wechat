package com.cloume.shaw.igia.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@RequestMapping(value = "/foo")
public class FooController extends AbstractController {
	
	@RequestMapping(method = RequestMethod.GET)
	public String index(HttpServletRequest request){
		
		return "foo";
	}
}
