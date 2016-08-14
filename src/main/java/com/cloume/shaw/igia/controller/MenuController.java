package com.cloume.shaw.igia.controller;

import java.io.InputStream;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import me.chanjar.weixin.common.bean.WxMenu;
import me.chanjar.weixin.common.exception.WxErrorException;
import me.chanjar.weixin.mp.api.WxMpService;

@Controller
@RequestMapping("/menu")
public class MenuController extends AbstractController{

	@Autowired private WxMpService wxMpService;
	
	@ResponseBody @RequestMapping(method = RequestMethod.GET)
	public WxMenu get() throws WxErrorException{
		return wxMpService.menuGet();
	}
	
	@RequestMapping(value = "/{type}", method = RequestMethod.POST)
	@ResponseBody public String create(@PathVariable("type") String type) throws WxErrorException{
		
		InputStream is = getClass().getResourceAsStream(type + ".json");
		if(is == null){
			return "bad menu configuration: " + type;
		}
		
		WxMenu wxMenu = WxMenu.fromJson(is);
		
		wxMpService.menuCreate(wxMenu);
		
		return "success";
	}
	
	@RequestMapping(method = RequestMethod.DELETE)
	@ResponseBody public String delete() throws WxErrorException{
		wxMpService.menuDelete();
		
		return "success";
	}
}
