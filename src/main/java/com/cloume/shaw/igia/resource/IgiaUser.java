package com.cloume.shaw.igia.resource;

import me.chanjar.weixin.mp.bean.result.WxMpUser;

import com.fasterxml.jackson.annotation.JsonIgnore;

public class IgiaUser extends User {
	
	//微信用户信息
	@JsonIgnore
	private WxMpUser wxMpUser;
	
	public IgiaUser() {}
	 
	public IgiaUser(WxMpUser wxMpUser) {
		setWxMpUser(wxMpUser);
	}
	
	public IgiaUser(String id) {
		super(id);
	}

	/**
	 * @return 获取微信用户信息
	 */
	public WxMpUser getWxMpUser(){
		return wxMpUser;
	}
	public void setWxMpUser(WxMpUser wxMpUser){
		this.wxMpUser = wxMpUser;
		this.setId(wxMpUser.getOpenId());
	}
}
