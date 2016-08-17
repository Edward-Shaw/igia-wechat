package com.cloume.shaw.igia.controller;

import java.io.IOException;
import java.util.Arrays;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.data.mongodb.core.query.Query;
import org.springframework.data.mongodb.core.query.Update;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.cloume.shaw.igia.resource.User;
import com.cloume.shaw.igia.utils.RestResponse;

import me.chanjar.weixin.mp.api.WxMpConfigStorage;
import me.chanjar.weixin.mp.api.WxMpService;

@Controller
@RequestMapping("/user")
public class UserController extends AbstractController {
	@Autowired private WxMpConfigStorage wxMpConfigStorage;
	@Autowired private WxMpService wxMpService;
	
	@RequestMapping(method = RequestMethod.GET)
	public String userPage(HttpServletRequest request){
		
		User userSession = (User) request.getSession().getAttribute("$_USER");
		if(userSession == null){
			return "register";
		}
		
		//根据open_id查找用户的注册信息，如果没有则跳转到注册页面进行注册
		String openId = userSession.getId();
		User userMongo = getMongoTemplate().findById(openId, User.class);
		if(userMongo == null){
			return "register";
		}
		
		request.setAttribute("user", userMongo);
		
		return "user";
	}
	
	/**
	 * 挑战机构的认证系统
	 * @param organization 目前只能=ecnu
	 * @param user 用户Id
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/{id}", params = {"organization=ecnu", "user"}, method = RequestMethod.GET)
	public RestResponse<Object> challenge(HttpServletRequest request, String organization, String user){
		User found = getMongoTemplate().findById(user, User.class, "user");
		if(found == null){
			return RestResponse.bad(404, String.format("User %s not exists", user), null);
		}
		
		return RestResponse.good("succeed");
	}
	
	/**
	 * 提交用户注册信息
	 * @param body
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/register", method = RequestMethod.POST)
	public RestResponse<Object> register(
			@RequestBody Map<String, Object> body
			){
		final String[] fields = {"name", "mobile", "password", "address"};
		if(!verify(body, Arrays.asList(fields))){
			return RestResponse.bad(404, String.format("properties %s can not missing", StringUtils.join(fields, ',')), null);
		}
		
		return RestResponse.good("succeed");
	}
	
}
