package com.cloume.shaw.igia.controller;

import java.text.SimpleDateFormat;
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

import com.cloume.shaw.igia.resource.Subscribe;
import com.cloume.shaw.igia.resource.User;
import com.cloume.shaw.igia.resource.Subscribe.Item;
import com.cloume.shaw.igia.utils.Const;
import com.cloume.shaw.igia.utils.RestResponse;
import com.cloume.shaw.igia.utils.Updater;

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
					details += "舞蹈 ";
					break;
				case "tech":
					details += "语言与科技  ";
					break;
				case "taekwondo":
					details += "跆拳道 ";
					break;
				case "yoga":
					details += "瑜伽 ";
					break;
				case "camp":
					details += "寒暑假集训 ";
					break;
				default:
					details += "";
				}
			}
			
			switch(subscribe.getSubscribeClass()){
			case "one":
				details += " 一班";
				break;
			case "two":
				details += " 二班";
				break;
			case "three":
				details += " 三班";
				break;
			case "four":
				details += " 四班";
				break;
			default:
				details += " 未分班";
				break;
			}
			
			request.setAttribute("subscribe_details", details);
			String state = "正在处理";
			switch(subscribe.getState()){
			case Const.SUBSCRIBE_ACCEPTED:
				state = "已接受";
				break;
			case Const.SUBSCRIBE_CLOSED:
				state = "已关闭";
				break;
			case Const.SUBSCRIBE_DECLINED:
				state = "已拒绝";
				break;
			case Const.SUBSCRIBE_HANDLING:
				state = "正在处理";
				break;
			default:
				state = "正在处理";
			}
			request.setAttribute("subscribe_state", state);
			Date date = new Date(subscribe.getCreateTime());
			SimpleDateFormat dateFormatter = new SimpleDateFormat("yyyy-MM-dd HH:mm");
			request.setAttribute("subscribe_time", dateFormatter.format(date));
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
		final String[] fields = {"name", "mobile", "password", "address", "email"};
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
		update.set("email", body.get("email"));
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
