package com.cloume.shaw.igia.utils;

import java.lang.reflect.Field;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.util.Map.Entry;

public class Updater<T> {
	
	private T object;
	public Updater(T object){
		this.object = object;
	}
	
	/**
	 * 将form中的key理解为属性名，value理解为新的值，更新到当前对象中。
	 * 因此必须注意：如果某个key不是基本类型，是个复杂类型的话，必须使用 {@link com.cloume.hsep.beanutils2.Updater.update(Map<String, Object>, IConverter) }
	 * 通过converter进行转换。
	 * 如果仅仅是因为@JsonProperty这样的注解或者其他原因使key和属性名不一致，使用{@link com.cloume.hsep.beanutils2.Updater.mapping(String, String) }方法可以解决。
	 * @param from
	 * @return
	 */
	public T update(Map<String, Object> from){
		return update(from, null);
	}
	
	protected Field getField(T object, String fieldName){
		//return org.apache.commons.lang.reflect.FieldUtils.getDeclaredField(object.getClass(), fieldName, true);
		Field result = ClassFields.getField(fieldName, object.getClass());
		if(result != null) {
			result.setAccessible(true);
		}

		if(result == null) {
			System.err.println(String.format("can not found field %s on object %s", fieldName, object));
		}

		return result;
    }
	
	private Map<String, String> keyMapping;
	protected Map<String, String> getKeyMapping(){
		return keyMapping == null ? keyMapping = new HashMap<String, String>() : keyMapping;
	}
	
	/**
	 * @param from 有可能是注解别名，比如JsonProperty注解的名字
	 * @param to 类的field名
	 * @return
	 */
	public Updater<T> mapping(String from, String to){
		getKeyMapping().put(from, to);
		return this;
	}
	
	/**
	 * 
	 * @param from
	 * @param converter 如果某个key不是基本类型，是个复杂类型的话，通过converter进行转换。
	 * @return
	 */
	public T update(Map<String, Object> from, IConverter converter){
		///尝试body中的每一个key
		for(Iterator<String> iterator = from.keySet().iterator(); iterator.hasNext(); ){
			String key = iterator.next();
			Object value = from.get(key);
			
			Field field = getField(this.object, getKeyMapping().containsKey(key) ? getKeyMapping().get(key) : key);
			if(converter != null){ 
				Entry<String, Object> converted = converter.convert(key, value);
				if(converted != null) {
					value = converted.getValue();
					if(!key.equals(converted.getKey())) {
						key = converted.getKey();
						field = getField(this.object, getKeyMapping().containsKey(key) ? getKeyMapping().get(key) : key);
					}
				}
			}
			
			if(field == null) { continue; }
			
			try{
				field.set(object, value); 
			} catch(Exception e) { 
				System.err.println(String.format("failed set field %s to value %s", key, value));
			}
		}
		
		return object;
	}
}
