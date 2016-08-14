package com.cloume.shaw.igia.controller;

import java.lang.reflect.Field;
import java.lang.reflect.Modifier;
import java.security.Principal;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collection;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.util.function.Function;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.data.mongodb.core.query.Query;
import org.springframework.data.mongodb.core.query.Update;

import com.fasterxml.jackson.annotation.JsonProperty;

public abstract class AbstractController {
	
	protected String getOperator(Principal principal) {
		return principal == null ? "Unknown" : principal.getName();
	}
	
	@Deprecated @Autowired private MongoTemplate mongoTemplate;

	/**
	 * @deprecated 为了规范结构, 20160721后的新代码不要再直接从controller中操作数据库，增加service进行操作
	 * @return 数据库操作对象
	 */
	protected MongoTemplate getMongoTemplate() {
		return mongoTemplate;
	}
	
	/**
	 * @deprecated 操作数据库代码移入service
	 * 将object中指定属性的值更新到数据库中
	 * @param id object在数据库中的主键
	 * @param object
	 * @param keys 指定属性集合（可以是JsonProperty注解的名称）
	 */
	protected void update(String id, Object object, Collection<String> keys){
		update(id, object, keys, null);
	}
	
	/**
	 * @deprecated 操作数据库代码移入service
	 * @param id
	 * @param object
	 * @param keys
	 * @param collection
	 */
	protected void update(String id, Object object, Collection<String> keys, String collection){
		List<Field> fields = new ArrayList<Field>();
        Class<?> clazz = object.getClass();
        for(; clazz != Object.class; clazz = clazz.getSuperclass()) {  
            fields.addAll(Arrays.asList(clazz.getDeclaredFields()));
        }
      
        Map<String, Field> mapping = new HashMap<String, Field>();
        fields.forEach(f -> { 
        	if(Modifier.isStatic(f.getModifiers())) return;
        	JsonProperty annotation = f.getAnnotation(JsonProperty.class);
        	if(annotation == null && !keys.contains(f.getName())) return;
        	if(annotation != null && !keys.contains(annotation.value())) return;
        	
        	mapping.put(f.getName(), f);
        });
		
        Update doUpdate = new Update();
        for(Entry<String, Field> entry : mapping.entrySet()){
        	try {
        		Field field = entry.getValue();
    			field.setAccessible(true);
    			Object value = field.get(object);
    			if(value == null) {		///可以unset某些属性, 比如authentication
    				doUpdate.unset(entry.getKey());
    			}else{
    				doUpdate.set(entry.getKey(), value);
    			}
			} catch (IllegalArgumentException | IllegalAccessException e) { 
				System.out.println("BAD");
			}
        }
        if(doUpdate.getUpdateObject().keySet().isEmpty()){
        	return;		///do not set {} to any document
        }
        if(collection != null){
        	getMongoTemplate().updateFirst(Query.query(Criteria.where("id").is(id)), doUpdate, object.getClass(), collection);
        }else{
        	getMongoTemplate().updateFirst(Query.query(Criteria.where("id").is(id)), doUpdate, object.getClass());
        }
	}
	
	/**
	 * @deprecated 不要用了
	 * 校验request body
	 * @param body
	 * @param each
	 * @return
	 */
	public boolean verify(Map<String, Object> body, Function<Map.Entry<String, Object>, Boolean> each){
		for(Iterator<Map.Entry<String, Object>> iterator = body.entrySet().iterator(); iterator.hasNext(); ){
			if(!each.apply(iterator.next())){
				return false;
			}
		}
		
		return true;
	}
	
	/**
	 * @deprecated 用 {@link com.cloume.hsep.web.verify.Verifier} 代替
	 * body中是否包含所有的必有属性
	 * @param body request-body
	 * @param keys 必须有的属性名称集合
	 * @return 是否全部包含
	 */
	public boolean verify(Map<String, Object> body, Collection<String> keys){
		return body.keySet().containsAll(keys);
	}
	
	/**
	 * @deprecated 不用這麼麻煩
	 * @param limitation
	 * @return
	 */
	public int[] limit(String limitation){
		int[] result = new int[]{0, getDefaultPageSize()};
		if(limitation.matches("\\d+{1,},\\+?[1-9][0-9]*")){
			String[] array = limitation.split(",");
			result[0] = Integer.parseInt(array[0]);
			result[1] = Integer.parseInt(array[1]);
		}
		return result;
	}
	
	/**
	 * @deprecated 不要用
	 * @return
	 */
	protected int getDefaultPageSize(){
		return 50;
	}
}
