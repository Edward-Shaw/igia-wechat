package com.cloume.shaw.igia.controller;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.cloume.shaw.igia.resource.User;

@RequestMapping(value = "/subscribe")
public class SubscribeController extends AbstractController {
	
	@RequestMapping(method = RequestMethod.GET)
	public String getSubscribePage(HttpServletRequest request){

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
		
		return "subscribe";
	}
	
	/**
	 * 提交预约信息
	 * @param request
	 * @param body
	 * @return
	 */
	@RequestMapping(method = RequestMethod.POST)
	public String submitSubscribeInfo(HttpServletRequest request, 
			@RequestBody Map<String, Object> body){
		
		return "mySubscribe";
	}
}
