package com.cloume.shaw.igia.controller;

import java.util.Arrays;
import java.util.Date;
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

import com.cloume.shaw.igia.common.resource.Subscribe;
import com.cloume.shaw.igia.common.resource.Subscribe.Item;
import com.cloume.shaw.igia.common.resource.User;
import com.cloume.shaw.igia.common.utils.RestResponse;

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
		if(userMongo == null || !userMongo.isBanned()){
			return "register";
		}
		
		request.setAttribute("user", userMongo);
		
		Query query = new Query(Criteria.where("user.openId").is(openId));
		Subscribe subscribe = getMongoTemplate().findOne(query, Subscribe.class);
		if(subscribe != null){
			String details = "";
			for(Item item : subscribe.getItems()){
				switch(item.getCategory()){
				case "painting":
					details += "绘画 ";
					break;
				case "classic":
					details += "中国舞 ";
					break;
				case "latin":
					details += "拉丁  ";
					break;
				case "taekwondo":
					details += "跆拳道 ";
					break;
				case "yoga":
					details += "瑜伽 ";
					break;
				case "summer_camp":
					details += "夏令营 ";
					break;
				default:
					details += "";
				}
			}
			request.setAttribute("details", details);
			request.setAttribute("subscribe", subscribe);
		}
		
		return "user";
	}
	
	/**
	 * 提交用户注册信息
	 * @param body
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/register", method = RequestMethod.POST)
	public RestResponse<User> register(HttpServletRequest request,
			@RequestBody Map<String, Object> body
			){
		final String[] fields = {"name", "mobile", "password", "address"};
		if(!verify(body, Arrays.asList(fields))){
			return RestResponse.bad(404, String.format("properties %s can not missing", StringUtils.join(fields, ',')), null);
		}
		
		User userSession = (User) request.getSession().getAttribute("$_USER");
		if(userSession == null){
			return RestResponse.bad(-1, "not wechat client.");
		}
		
		//根据open_id查找用户的注册信息，如果没有则跳转到注册页面进行注册
		String openId = userSession.getId();
		
		Update update = new Update();
		update.set("updatedTime", new Date().getTime());
		update.set("banned", "true");
		update.set("mobile", body.get("mobile"));
		update.set("address", body.get("address"));
		int res = getMongoTemplate().updateMulti(new Query(Criteria.where("_id").is(openId)), update, User.class).getN();
		if(res != 1){
			return new RestResponse<User>(-3, "信息登记失败,此用户不存在,请退出公众号重新进入!", userSession);
		}
		
		/*
		long exists = getMongoTemplate().count(Query.query(Criteria.where("mobile").is(user.getMobile())), User.class);
		if(exists > 0) {
			return RestResponse.bad(-1, String.format("mobile %s re-bound", user.getMobile()), null);
		}
		*/

		User userMongo = getMongoTemplate().findById(openId, User.class);
		if(userMongo == null){
			RestResponse.bad(-2, "500 error");
		}
		
		return RestResponse.good(userMongo);
	}
	
}
