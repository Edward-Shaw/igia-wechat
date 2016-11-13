package com.cloume.shaw.igia.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.cloume.shaw.igia.common.resource.User;

@Controller
@RequestMapping(value = "/register")
public class RegisterController extends AbstractController {

	@RequestMapping(method = RequestMethod.GET)
	public String registerPage(HttpServletRequest request){
		User userSession = (User) request.getSession().getAttribute("$_USER");
		if(userSession == null){
			return "register";
		}
		
		//根据open_id查找用户的注册信息，如果没有则跳转到注册页面进行注册
		String openId = userSession.getId();
		User userMongo = getMongoTemplate().findById(openId, User.class);
		if(userMongo == null || !userMongo.isBanned()){
			return "register";
		}
		
		request.setAttribute("user", userMongo);
		
		return "register";
	}
	
	@ResponseBody
	@RequestMapping(value = "/confirm", method = RequestMethod.GET)
	public String confirm(HttpServletRequest request){
		User userSession = (User) request.getSession().getAttribute("$_USER");
		if(userSession == null){
			return "weixin-error";
		}
		
		//根据open_id查找用户的注册信息，如果没有则跳转到注册页面进行注册
		String openId = userSession.getId();
		User userMongo = getMongoTemplate().findById(openId, User.class);
		if(userMongo == null || !userMongo.isBanned()){
			return "not-registered";
		}
		
		request.setAttribute("user", userMongo);
		
		return "registered";
	}
}
