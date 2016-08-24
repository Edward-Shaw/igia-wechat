package com.cloume.shaw.igia.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * 管理后台相关方法
 * @author shaw
 *
 */

@Controller
@RequestMapping("/management")
public class ManagementController extends AbstractController {
	
	/**
	 * 返回后台主页
	 * @param request
	 * @return
	 */
	public String index(HttpServletRequest request){
		return "management";
	}
}
