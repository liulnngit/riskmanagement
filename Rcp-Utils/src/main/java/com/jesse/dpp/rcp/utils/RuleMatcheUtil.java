package com.jesse.dpp.rcp.utils;

import java.lang.reflect.Field;
import java.util.ArrayList;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

public class RuleMatcheUtil {

    private static Log log = LogFactory.getLog(RuleMatcheUtil.class);
    
    /**
     * 规则流中提取变量集合
     * 
     * @param ruleText
     *            规则流
     * @return 变量集合
     */
    public static List<String> lookForString(String ruleText) {

        List<String> strings = new ArrayList<String>();
        String pattern = "@.*?}";
        Pattern r = Pattern.compile(pattern);
        Matcher m = r.matcher(ruleText);

        while (m.find()) {

            String string = m.group();
            strings.add(string);
        }

        return strings;
    }
    
    /**
     * 黑白名单去高亮(最外层)
     * @param bwString
     * @return
     */
    public static String matcherWH(String bwString) {
	   	 String pattern = ">\\{(.*)\\}<";
	     Pattern r = Pattern.compile(pattern);
	     Matcher m = r.matcher(bwString);
	     String string = bwString;
	     while (m.find()) {
	    	 string = m.group();
	    	 string = "{" + string + "}";
	     }
	     
	     return string;        
    }
    
    /**
     * 黑白名单去高亮(全部)
     * @param bwString
     * @return
     */
    public static String matcherWHall(String bwString) {
	   	 
    	 bwString = bwString.replaceAll("<[^>]*>", "");
	     
	     return bwString;        
    }
    
    public static void main(String[] args) {
    	System.err.println(matcherWHall("{\"id\":\"<font color='red'>1fbe361eb94845f7a04fb9e68319a56b</font>\",\"idCardNo<font color='red'>\":\"<font color='red'>444\"}"));
	}
    
    /**
     * 提取变量各参数
     * @param <T>
     * 
     * @param str
     *            变量
     * @return 
     * @return 变量参数类
     */
    public static <T> T matches(String str, Class<T> clazz) {

        String string1 = str.trim().substring(str.indexOf("@") + 1, str.indexOf("{#"));
        String string2 = str.trim().substring(str.indexOf("#") + 1, str.indexOf(":") - 1);
        String string3 = str.trim().substring(str.indexOf(":") + 2, str.indexOf("}") - 1);

        StringBuilder stringBuilder = new StringBuilder();
        stringBuilder.append(string1).append(string3);
        
        Object obj = null;
		try {
			obj = clazz.newInstance();
		} catch (Exception e) {
			e.printStackTrace();
		}
        setFieldValue("typeStr", string1, obj, clazz);
        setFieldValue("name", string2, obj, clazz);
        setFieldValue("matches", string3, obj, clazz);
        setFieldValue("resource", str, obj, clazz);
        setFieldValue("drlStr", stringBuilder.toString(), obj, clazz);

        return (T) obj;
    }
    
	/**
	 * 获取反射类型字段并赋值
	 * @param fieldName
	 * @param value
	 * @param obj
	 * @param clazz
	 */
	public static <T> void setFieldValue(String fieldName, String value, Object obj, Class<T> clazz) {
		try {
			Field field = clazz.getDeclaredField(fieldName);
			field.setAccessible(true);
			field.set(obj, value);
		} catch (Exception e) {
			log.error(e);
		}
		
	}
	
	
	/**
	 * 分析模型规则匹配
	 * @param <T>
	 * @param paramJson 
	 * @param drlContext
	 * @return
	 */
	public static <T> List<T> getAnalyzeModelBos(String paramJson, String drlContext, Class<T> clazz) {
	
		List<T> analyzeModels = JsonListUtil.jsonToList(paramJson, clazz);
		if (analyzeModels == null || analyzeModels.size() == 0) {
			return new ArrayList<T>();
		}
		return analyzeModels;
	}
}
