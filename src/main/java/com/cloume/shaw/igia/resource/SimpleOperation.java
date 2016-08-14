package com.cloume.shaw.igia.resource;

import java.io.Serializable;

/**
 * 具有3个属性：method / operator / time
 * @author Gang
 *
 */
public class SimpleOperation implements Serializable {
	
	private static final long serialVersionUID = -4680174165428646781L;
	
	final static public String RESULT_SUCCESS = "SUCCESS";
	final static public String RESULT_FAIL = "FAIL";
	
	final static public String METHOD_MANUAL = "MANUAL";
	
	/**
	 * 比较开放的记录操作的特性
	 */
	private String method;
	
	/**
	 * 后台操作员ID
	 */
	private String operator;
	private long time;
	
	public SimpleOperation(){
		this(null, null);
	}
	
	public SimpleOperation(String method, String operator) {
		this(method, operator, System.currentTimeMillis());
	}

	public SimpleOperation(String method, String operator, long time) {
		this.method = method;
		this.operator = operator;
		this.time = time;
	}
	
	public String getMethod() {
		return method;
	}
	public void setMethod(String method) {
		this.method = method;
	}
	public String getOperator() {
		return operator;
	}
	public void setOperator(String operator) {
		this.operator = operator;
	}
	public long getTime() {
		return time;
	}
	public void setTime(long time) {
		this.time = time;
	}
}
