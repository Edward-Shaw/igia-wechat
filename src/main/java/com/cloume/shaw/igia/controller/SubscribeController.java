package com.cloume.shaw.igia.controller;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
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
import org.springframework.web.bind.annotation.ResponseBody;

import com.cloume.shaw.igia.common.resource.Subscribe;
import com.cloume.shaw.igia.common.resource.Subscribe.Item;
import com.cloume.shaw.igia.common.resource.Subscribe.SimpleUser;
import com.cloume.shaw.igia.common.resource.User;
import com.cloume.shaw.igia.common.utils.Const;
import com.cloume.shaw.igia.common.utils.RestResponse;

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
			request.setAttribute("subscribe", subscribe);
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
			case "monday":
				details += " 周一";
				break;
			case "tuesday":
				details += " 周二";
				break;
			case "wednesday":
				details += " 周三";
				break;
			case "thursday":
				details += " 周四";
				break;
			case "friday":
				details += " 周五";
				break;
			case "saturday":
				details += " 周六";
				break;
			case "sunday":
				details += " 周日";
				break;
			default:
				details += " 未选择时间";
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
			User userMongo = getMongoTemplate().findById(openId, User.class);
			if(userMongo == null || !userMongo.isBanned()){
				return "register";
			}
			
			request.setAttribute("user", userMongo);
			return "mySubscribe";
		}
		
		return "subscribe";
	}
	
	/**
	 * 提交预约信息
	 * @param request
	 * @param body
	 * @return
	 */
	@RequestMapping(method = RequestMethod.POST)
	@ResponseBody
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
		subscribe.setSubscribeClass(body.get("activity_class").toString());
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
