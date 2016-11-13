package com.cloume.shaw.igia.wx.resoure;

import org.springframework.data.annotation.Id;

import com.cloume.shaw.igia.common.utils.Cloner;

import me.chanjar.weixin.mp.bean.result.WxMpOAuth2AccessToken;

public class OAuth2AccessToken extends WxMpOAuth2AccessToken {

	private static final long serialVersionUID = 3192678856446142417L;

	@Id
	private String openId;
	
	public OAuth2AccessToken(WxMpOAuth2AccessToken wxObject) {
		new Cloner<WxMpOAuth2AccessToken>(this).clone(wxObject);
	}
}
