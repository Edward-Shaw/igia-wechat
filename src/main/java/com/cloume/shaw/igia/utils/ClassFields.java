package com.cloume.shaw.igia.utils;

import java.lang.reflect.Field;
import java.util.Arrays;
import java.util.Iterator;
import java.util.List;

import org.apache.commons.lang.StringUtils;

public class ClassFields {
	
	static public Field deepGetField(String fieldName, Class<?> clazz) {  
        Field field = null ; 
        for(; clazz != Object.class ; clazz = clazz.getSuperclass()) {  
            try {  
                field = clazz.getDeclaredField(fieldName) ;  
                break;
            } catch (NoSuchFieldException e) {  
                //这里甚么都不要做！并且这里的异常必须这样写，不能抛出去。  
                //如果这里的异常打印或者往外抛，则就不会执行clazz = clazz.getSuperclass(),最后就不会进入到父类中了  
            }
        }
        return field;  
    }
	
	/**
	 * @param path 如"a.b.c"获取a属性的b属性的c属性值
	 * @param clazz
	 * @return
	 */
	static public Field getField(String path, Class<?> clazz) {
		List<String> levels = Arrays.asList(StringUtils.split(path, "."));
		Iterator<String> iterator = levels.iterator();
		
		Field field = null;
		Class<?> current = clazz;
		while(iterator.hasNext()) {
			String level = iterator.next();
			try {
				//field = current.getDeclaredField(level);
				field = deepGetField(level, current);
				current = field.getClass();
			} catch (SecurityException e) {
				field = null;
				break;
			}
		};
		
		return field;
	}
}
