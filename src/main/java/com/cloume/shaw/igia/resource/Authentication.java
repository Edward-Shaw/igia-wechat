package com.cloume.shaw.igia.resource;

/**
 * 账号认证
 * @author Gang
 *
 */
public class Authentication extends SimpleOperation {

	private static final long serialVersionUID = 2812160733767075617L;
	
	/**
	 * 到期时间（毫秒数）
	 */
	private long expiration;
	
	public Authentication(){
	}
	
	public Authentication(String method, String operator) {
		this(method, operator, 0);
	}
	
	public Authentication(String method, String operator, long expiration) {
		super(method, operator);
		this.expiration = expiration;
	}

	public long getExpiration() {
		return expiration;
	}
	public void setExpiration(long expiration) {
		this.expiration = expiration;
	}
}

