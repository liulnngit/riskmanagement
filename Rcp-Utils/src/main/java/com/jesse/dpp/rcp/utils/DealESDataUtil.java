package com.jesse.dpp.rcp.utils;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;

public class DealESDataUtil {

	// 处理只获取需要的数据
	public static String dealData(String data) {
		String response = "";
		JSONObject jsonObject = JSONObject.parseObject(data);
		boolean haserror = jsonObject.getBoolean("haserror");
		if (haserror) {
			System.out.println(jsonObject.getString("errmsg"));
			return "";
		} else {
			String datasource = jsonObject.getString("result");
			JSONObject dataobj = JSON.parseObject(datasource);
			String dataResult = dataobj.getString("data");
			if (dataobj.getBoolean("iscompress")) {
				try {
					response = GzipUtils.unCompress(dataResult);
				} catch (Exception e) {
					e.printStackTrace();
				}
			} else {
				response = dataResult;
			}
		}
		return response;
	}
}
