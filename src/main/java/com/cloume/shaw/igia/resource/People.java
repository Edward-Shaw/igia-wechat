package com.cloume.shaw.igia.resource;

import org.springframework.data.mongodb.core.mapping.Field;

import com.fasterxml.jackson.annotation.JsonProperty;

/**
 * 人，比如用户、下挂学生
 * @author Gang
 *
 */
abstract class People {
	private String gender;
	private String name;
	private int age;
	private String province, city;
	
	@JsonProperty("created_time") @Field("created_time")
	private long createdTime = System.currentTimeMillis();
	
	/**
	 * 生日
	 */
	private long birthday;
	
	public long getCreatedTime() {
		return createdTime;
	}
	public void setCreatedTime(long value){
		createdTime = value;
	}
	
	public String getProvince() {
		return province;
	}
	public void setProvince(String province) {
		this.province = province;
	}
	public String getCity() {
		return city;
	}
	public void setCity(String city) {
		this.city = city;
	}
	public String getGender() {
		return gender;
	}
	public void setGender(String gender) {
		this.gender = gender;
	}
	public int getAge() {
		long diff = System.currentTimeMillis() - getCreatedTime();
		
		///FIXME: use birthday 

		return age + Math.floorDiv(new Long(diff).intValue(), 365 * 24 * 3600 * 1000);
	}
	public void setAge(int age) {
		this.age = age;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public long getBirthday() {
		return birthday;
	}
	public void setBirthday(long birthday) {
		this.birthday = birthday;
	}
}
