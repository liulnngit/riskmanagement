package com.jesse.dpp.rcp.utils;

import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;

/**
 * 
 * POJO JSON 互相转换
 * 
 * @author wzs-t178
 *
 */
public class ParameterDataUtil {
	
	private static Log log = LogFactory.getLog(ParameterDataUtil.class);
	
	/**
	 * JSON 转 POJO
	 * @param pojo
	 * @param tclass
	 * @return
	 */
	 public static <T> T getObject(String pojo, Class<T> tclass) {
		 
	        try {
	            return JSONObject.parseObject(pojo, tclass);
	        } catch (Exception e) {
	        	log.error(tclass + "转 JSON 失败");
	        }
	        
	        return null;
	 }
	 
	 /**
	  * 
	  * POJO 转 JSON	
	  * @param riskControlServiceResponse
	  * @return
	  */
	 public static <T> String getJson(T tResponse){
		 
		 String pojo = JSONObject.toJSONString(tResponse);
		 
		 return pojo;
	 }
	 
	 /**
	  * JSON 转 Map
	  * @param json
	  * @return
	  */
	 @SuppressWarnings("unchecked")
	 public static Map<String,Object> json2Map(String json){
			 
		 return JSON.parseObject(json, Map.class);
	 }
	 
	/**
	 * 对象转 Map
	 * 
	 * @param t
	 * @return
	 */
    public static <T> Map<String, Object> getMap(T t) {
    	
    	String json = ParameterDataUtil.getJson(t);
    	Map<String, Object> map =ParameterDataUtil.json2Map(json);
    	
    	return map;
    }
	 
}
