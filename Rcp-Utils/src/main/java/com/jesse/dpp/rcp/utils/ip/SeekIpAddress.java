package com.jesse.dpp.rcp.utils.ip;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.concurrent.ConcurrentHashMap;

import org.apache.commons.io.FileUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;



public class SeekIpAddress {

	private static String dataPath;
	private static SeekIpAddress instance = null;
	// 用来做为cache，查询一个ip时首先查看cache，以减少不必要的重复查找
    private ConcurrentHashMap<String, DataBlock> ipCache = new ConcurrentHashMap<String,  DataBlock>();
	private static Log log = LogFactory.getLog(SeekIpAddress.class);
	
	/**
	 * 获取文件路径
	 */
	private void makeDataFile() {
    	try {
    		dataPath = System.getProperty("java.io.tmpdir") + File.separator+ "ip2region.db";
    		log.info("dataPath =="+dataPath);
            File dataFile = new File(dataPath);
            if(!dataFile.exists()) {            
                FileUtils.copyInputStreamToFile(getClass().getResourceAsStream("/ip2region.db"), dataFile);
            }
    	} catch(Exception ex) {
    		log.error("create data file exception.", ex);
    	}        
	}
    
	/**
	 * 单一实例
	 * @return
	 */
	public static SeekIpAddress getInstance() {
		if (null == instance) {
			synchronized (SeekIpAddress.class) {
				if (null == instance) {
					instance = new SeekIpAddress();
				}
			}
		}
		return instance;
	}
	
	
    /**
     * 构造私有化对象
     */
	private SeekIpAddress() {
		super();
		makeDataFile();
	}

    /**
     * 根据ip获取对应的地址
     * @param ip
     * @return
     */
	public DataBlock getAddressByIp(String ip) {
		DbConfig config;
		DataBlock dataBlock = null;
		
		//先从缓存中取数据
		dataBlock = ipCache.get(ip);
		
		try {
			if (null == dataBlock) {
				config = new DbConfig();
				DbSearcher searcher = new DbSearcher(config, dataPath);
				dataBlock = searcher.btreeSearch(ip);
				ipCache.put(ip, dataBlock);
			}

		} catch (DbMakerConfigException e) {
			e.printStackTrace();
			log.error(e.getMessage(), e);
		} catch (FileNotFoundException e) {
			e.printStackTrace();
			log.error(e.getMessage(), e);
		} catch (IOException e) {
			e.printStackTrace();
			log.error(e.getMessage(), e);
		}

		return dataBlock;
	}

}
