package com.cloume.shaw.igia.utils;

import com.fasterxml.jackson.annotation.JsonIgnore;

public class RestResponse<RT> {
	
	private int code;
	private String message;
	private RT result;
	
	public RestResponse() { }

	public RestResponse(int code, String message, RT result) {
		setCode(code);
		setMessage(message);
		setResult(result);
	}

	public void setCode(int code) {
		this.code = code;
	}
	public int getCode(){
		return code;
	}
	public void setMessage(String message){
		this.message = message;
	}
	public String getMessage(){
		return message;
	}
	public void setResult(RT result){
		this.result = result;
	}
	public RT getResult(){
		return result;
	}

	public static <T> RestResponse<T> good(T result){
		return result(0, "OK", result);
	}
	
	public static <T> RestResponse<T> result(int code, String message, T result){
		return new RestResponse<T>(code, message, result);
	}

	/**
	 * @param code 要求 <0, 否则请使用good
	 * @param message
	 * @param result
	 * @return
	 */
	public static <T> RestResponse<T> bad(int code, String message, T result) {
		return result(code, message, result);
	}
	
	public static <T> RestResponse<T> bad(int code, String message) {
		return result(code, message, null);
	}

	@JsonIgnore
	public boolean isBad() {
		return getCode() < 0;
	}
}
