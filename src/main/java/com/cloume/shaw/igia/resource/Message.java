package com.cloume.shaw.igia.resource;

import net.sf.json.JSONObject;

/**
 * 
 * 统一推送接口相关信息
 * @author CaoYue
 */
public class Message {
	
	//接收用户
	private String to;
	
	//消息主题
	private String subject = "";
	
	//消息内容
	private JSONObject content = null;
	
	//特殊渠道参数
	private String extra = "";

	public String getSubject() {
		return subject;
	}

	public void setSubject(String subject) {
		this.subject = subject;
	}

	public JSONObject getContent() {
		return content;
	}

	public void setContent(JSONObject content) {
		this.content = content;
	}

	public String getExtra() {
		return extra;
	}

	public void setExtra(String extra) {
		this.extra = extra;
	}

	public String getTo() {
		return to;
	}

	public void setTo(String to) {
		this.to = to;
	}
}
