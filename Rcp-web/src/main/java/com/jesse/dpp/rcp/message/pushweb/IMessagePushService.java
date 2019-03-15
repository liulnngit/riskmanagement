package com.jesse.dpp.rcp.message.pushweb;

import java.util.List;
import java.util.Map;

import javax.websocket.Session;

/**
 * 
 * @author wzs-t178
 * 
 * 消息推送 API
 *
 */
public interface IMessagePushService {	
	
	/**
	 * 指定用户推送
	 * @param uid 用户 ID
	 * @param channel 应用通道标识
	 * @param data 传输的内容
	 */
	void sendMessage(Integer uid, String channel, Object data);

	/**
	 * 给批量用户推送批量数据
	 * @param uid 用户 ID 集合
	 * @param channel 应用通道标识
	 * @param data 传输的内容
	 */
	void sendMessage(List<Integer> uid, String channel, List<Object> data);
	
	/**
	 * 向多个用户推送数据
	 * @param uid 对应用户 ID 集合
	 * @param channel 应用通道标识
	 * @param data 传输的内容
	 */
	void sendMessage(List<Integer> uid, String channel, Object data);

	/**
	 * 向所有在线推送发送
	 * rt : 公告
	 * @param channel 应用通道标识
	 * @param data 传输的内容
	 */
	void  sendMessageAll(String channel, Object data);
	
	/**
	 * 向所有在线用户推送 “公告”
	 * @param data 传输的内容
	 */
	void  sendMessageAll(Object data);
	
	/**
	 * 获取所有在线用户
	 * @return
	 */
	Map<String, Session> getAllOnlineAccount();
	
	/**
	 * 
	 * @param key   在线 key
	 * @param obj	systemId or roleId or accountId
	 * @param bit   0 systemId | 1 roleId | 2 accountId
	 * @return 
	 */
	boolean isContainsByKey(String key, Object obj, int bit);

	void sendMessage(List<String> objs, String channel, Object data, int bit);
}
