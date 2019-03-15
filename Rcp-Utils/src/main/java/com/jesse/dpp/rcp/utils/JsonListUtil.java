package com.jesse.dpp.rcp.utils;

/**
 * @author wzs-t178
 * 
 * List JSON 互换工具类
 * 
 */
import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;

public class JsonListUtil {

    private static Log log = LogFactory.getLog(JsonListUtil.class);

    /**
     * List<T> 转 json 保存到数据库
     * 
     * @param ts
     * @return
     */
    public static <T> String listToJson(List<T> ts) {

        String jsons = JSON.toJSONString(ts);
        log.info(jsons);

        return jsons;
    }

    /**
     * json 转 List<T>
     * 
     * @param jsonString
     * @return
     */
    public static <T> List<T> jsonToList(String jsonString, Class<T> clazz) {

        @SuppressWarnings("unchecked")
        List<T> ts = (List<T>) JSONArray.parseArray(jsonString, clazz);

        return ts;
    }

}
