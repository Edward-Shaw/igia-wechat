package com.cloume.shaw.igia.resource;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

import org.springframework.data.annotation.Id;

public class User extends People implements Serializable {
	
	private static final long serialVersionUID = 6428260202258747911L;

	@Id
	private String id;
	
	/**
	 * 是否被禁用
	 */
	private boolean banned;
	
	/**
	 * 被认证情况
	 */
	private Authentication authentication;
	
	/**
	 * 移动电话号码
	 */
	private String mobile;
	
	/**
	 * 座机号码
	 */
	private String telephone;
	
	/**
	 * 住址（登记地址）
	 */
	private String address;
	
	/**
	 * 头像
	 */
	private String avatar;
	
	/**
	 * 身份证号
	 */
	private String idcard;

	/**
	 * 用户类型未知
	 */
	final static public int USER_UNKNOWN = 0;
	/**
	 * 教员
	 */
	final static public int USER_TEACHER = 1;
	/**
	 * 学员
	 */
	final static public int USER_TRAINEE = 2;
	
	private int type;

	public User() {}
	
	public User(String id) {
		this.id = id;
	}

	public String getId(){
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	
	/**
	 * @return 用户类型
	 */
	public int getType() {
		return type;
	}
	public void setType(int type) {
		this.type = type;
	}

	/**
	 * @return 认证情况
	 */
	public Authentication getAuthentication() {
		return authentication;
	}

	/**
	 * @param approved 认证情况
	 */
	public void setAuthentication(Authentication certification) {
		this.authentication = certification;
	}

	public boolean isBanned() {
		return banned;
	}
	public void setBanned(boolean banned) {
		this.banned = banned;
	}

	public String getMobile() {
		return mobile;
	}

	public void setMobile(String mobile) {
		this.mobile = mobile;
	}

	public String getTelephone() {
		return telephone;
	}

	public void setTelephone(String telephone) {
		this.telephone = telephone;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getAvatar() {
		return avatar;
	}

	public void setAvatar(String avatar) {
		this.avatar = avatar;
	}

	public String getIdcard() {
		return idcard;
	}

	public void setIdcard(String idcard) {
		this.idcard = idcard;
	}

}
