package com.jesse.dpp.rcp.util;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.net.URISyntaxException;
import java.util.ArrayList;
import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

/**
 * 读取配置信息
 * 
 * @author wzs-t178
 *
 */
public class ConfigUtils {

	private static Log log = LogFactory.getLog(ConfigUtils.class);
	
	public static List<Config> readText() throws URISyntaxException {
		List<Config> configs = new ArrayList<Config>();
		File file = new File(ConfigUtils.class.getClassLoader().getResource("config.txt").toURI().getPath());
		try {
			BufferedReader br = new BufferedReader(new FileReader(file));//构造一个BufferedReader类来读取文件
			String reads = null;
			while((reads = br.readLine())!=null){//使用readLine方法，一次读一行
                configs.add(analyConfig(reads));
            }
			br.close();  
			
			return configs;
		} catch (Exception e) {
			log.error("解析错误" + e);
		}
		
		return new ArrayList<Config>();
	}
	
	/**
	 * 解析逗号分隔的字符串
	 * @param reads
	 * @return
	 */
	public static Config analyConfig(String reads) {
		
		 String[] sa = reads.split(",");
	     Config config = new Config(sa[1], sa[0], sa[2]);
	     log.info(config);
	     return config;
	}
	
	public static void main(String[] args) {
		//readText();
	}
}
