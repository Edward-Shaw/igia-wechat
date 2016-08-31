package com.cloume.shaw.igia.resource;

import java.util.ArrayList;

/**
 * 预约记录，可能包含多条活动预约信息
 * @author yxiao_000
 *
 */
public class Subscribe {
	
	//预约用户的基本信息
	private SimpleUser user;
	
	//预约创建时间
	private long createTime;
	
	//预约的活动列表
	private ArrayList<Item> items;
	
	//预约的活动时间
	private long subscribeTime;
	
	public void addItem(Item item){
		this.items.add(item);
	}
	
	public ArrayList<Item> getItems(){
		return this.items;
	}

	public long getCreateTime() {
		return createTime;
	}

	public void setCreateTime(long createTime) {
		this.createTime = createTime;
	}
	
	public long getSubscribeTime() {
		return subscribeTime;
	}

	public void setSubscribeTime(long subscribeTime) {
		this.subscribeTime = subscribeTime;
	}

	public SimpleUser getUser() {
		return user;
	}

	public void setUser(SimpleUser user) {
		this.user = user;
	}

	public class SimpleUser{
		
		public SimpleUser(String openId, String username, String mobile, String address){
			this.openId = openId;
			this.username = username;
			this.mobile = mobile;
			this.address = address;
		}
		
		//预约用户的ID，微信环境下为OpenID
		private String openId;
		
		private String username;
		
		private String mobile;
		
		private String address;

		public String getOpenId() {
			return openId;
		}

		public void setOpenId(String openId) {
			this.openId = openId;
		}

		public String getUsername() {
			return username;
		}

		public void setUsername(String username) {
			this.username = username;
		}

		public String getMobile() {
			return mobile;
		}

		public void setMobile(String mobile) {
			this.mobile = mobile;
		}

		public String getAddress() {
			return address;
		}

		public void setAddress(String address) {
			this.address = address;
		}
		
	}
	
	public class Item{
		
		public Item(String category, String detail){
			this.category = category;
			this.detail = detail;
		}
		
		//预约的活动类别
		private String category;
		
		//预约的活动详情，大类别下的具体子类活动
		private String detail;

		public String getCategory() {
			return category;
		}

		public void setCategory(String category) {
			this.category = category;
		}

		public String getDetail() {
			return detail;
		}

		public void setDetail(String detail) {
			this.detail = detail;
		}
	}
}
