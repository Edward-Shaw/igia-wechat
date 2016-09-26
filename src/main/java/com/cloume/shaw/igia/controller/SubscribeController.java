package com.cloume.shaw.igia.controller;

import java.util.Calendar;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.data.mongodb.core.query.Query;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.cloume.shaw.igia.resource.Subscribe;
import com.cloume.shaw.igia.resource.Subscribe.Item;
import com.cloume.shaw.igia.resource.Subscribe.SimpleUser;
import com.cloume.shaw.igia.resource.User;
import com.cloume.shaw.igia.utils.Const;
import com.cloume.shaw.igia.utils.RestResponse;

@Controller
@RequestMapping(value = "/subscribe")
public class SubscribeController extends AbstractController {
	
	@RequestMapping(method = RequestMethod.GET)
	public String getSubscribePage(HttpServletRequest request,
			@RequestParam(value = "openid", required = false, defaultValue = "") String openId,
			@RequestParam(value = "v", required = false, defaultValue = "") String v,
			@RequestParam(value = "t", required = false, defaultValue = "") String t){
		User userSession = (User) request.getSession().getAttribute("$_USER");
		if(userSession == null){
			return "register";
		}
		
		//根据open_id查找用户的注册信息，如果没有则跳转到注册页面进行注册
		openId = userSession.getId();
		
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
			return "mySubscribe";
		}
		
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
	public RestResponse<Subscribe> submitSubscribeInfo(HttpServletRequest request, 
			@RequestBody Map<String, Object> body){
		
		User userSession = (User) request.getSession().getAttribute("$_USER");
		if(userSession == null){
			return RestResponse.bad(-1, "微信错误，请退出公众号后重新进入");
		}
		
		//根据open_id查找用户的注册信息，如果没有则跳转到注册页面进行注册
		String openId = userSession.getId();
		Subscribe subscribe = new Subscribe();
		SimpleUser user = subscribe.new SimpleUser(openId, userSession.getName(), userSession.getMobile(), userSession.getAddress());
		subscribe.setUser(user);
		for(Map.Entry<String, Object> tempItem : body.entrySet()){
			if(tempItem.getValue().toString().compareToIgnoreCase("default") != 0){
				Item item = subscribe.new Item(tempItem.getKey().toString(), tempItem.getValue().toString());
				subscribe.addItem(item);
			}
		}
		subscribe.setCreateTime(System.currentTimeMillis());
		subscribe.setState(Const.SUBSCRIBE_HANDLING);
		//TODO:预约的活动时间暂时为空，待后续增加
		subscribe.setSubscribeTime(System.currentTimeMillis());
		subscribe.setCode(generateSubscribeCode());
		
		getMongoTemplate().insert(subscribe, "subscribe");
		
		request.setAttribute("mySubscribe", subscribe);
		String details = subscribe.getItems().toString();
		request.setAttribute("details", details);
		
		return RestResponse.good(subscribe);
	}
	
	private String generateSubscribeCode(){
		Calendar now = Calendar.getInstance();
		String time = (now.get(Calendar.YEAR) + "").substring(2) + String.format("%02d", now.get(Calendar.MONTH) + 1);
		final String prefix = "IGIA-" + time;
		final String pattern = prefix + "-\\d{1,5}";
		
		String code = "";
		synchronized(this){
			long count = getMongoTemplate().count(Query.query(Criteria.where("code").regex(pattern).and("state").ne(Const.STATE_DELETED)), Subscribe.class, "subscribe") + 1;
			code = prefix + "-" + count;
		}
		
		return code;
	}
}
