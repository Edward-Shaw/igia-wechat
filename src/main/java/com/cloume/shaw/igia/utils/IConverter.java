package com.cloume.shaw.igia.utils;

import java.util.Map.Entry;

/**
 * 将一个对象类型转换为另一个类型
 * @author Gang
 *
 */
public interface IConverter {
	/**
	 * @param name 待转换属性名
	 * @param value 待转换的属性值（实例）
	 * @return 转换之后的键和值（实例），键也可以修改
	 */
	Entry<String, Object> convert(String key, Object value);
	
	default Entry<String, Object> pair(String key, Object value) {
		return new SimpleEntry(key, value);
	}
	
	class SimpleEntry implements Entry<String, Object> {
		private String key;
		private Object value;
		
		SimpleEntry(String key, Object value) {
			this.key = key;
			this.value = value;
		}

		@Override
		public String getKey() {
			return key;
		}

		@Override
		public Object getValue() {
			return value;
		}

		@Override
		public Object setValue(Object value) {
			Object old = value;
			this.value = value;
			return old;
		}}
}
