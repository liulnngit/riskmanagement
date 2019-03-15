/*package com.jesse.dpp.rcp.message.pushweb.impl;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.websocket.Session;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Service;

import com.jesse.dpp.rcp.message.pushweb.IMessagePushService;
import com.jesse.dpp.rcp.message.pushweb.SocketPushService;
import com.jesse.dpp.rcp.utils.ChannelID;
import com.jesse.dpp.rcp.utils.ParameterDataUtil;
import com.jesse.dpp.rcp.vo.PushWeb;

@Service
public class MessagePushServiceImpl implements IMessagePushService {

	private static final Log log = LogFactory.getLog(MessagePushServiceImpl.class);	
    
	@Override
	public void sendMessage(List<String> objs, String channel, Object data, int bit) {
		Map<String, Session> allOnlineAccount = getAllOnlineAccount();
		for (int i = 0; i < objs.size(); i++) {
			for(Map.Entry<String, Session> entry : allOnlineAccount.entrySet()){
				boolean isKey = isContainsByKey(entry.getKey(), objs.get(i), bit);
				if (isKey) {
					log.info("推送用户 ： " + entry.getKey());
					PushWeb pushWeb = new PushWeb();
					pushWeb.setChannel(channel);
					pushWeb.setData(data);
					try {
						entry.getValue().getBasicRemote().sendText(ParameterDataUtil.getJson(pushWeb));
					} catch (IOException e) {
						log.error("发送失败 ： " + e.getMessage(), e);
					}
				}
			}
		}
	}
	
	@Override
	public void sendMessage(Integer uid, String channel, Object data) {
		log.info("sendMessage invoke....");
		Map<String, Session> allOnlineAccount = getAllOnlineAccount();
		log.info("所有在线用户 ： " + allOnlineAccount.toString());
		for(Map.Entry<String, Session> entry : allOnlineAccount.entrySet()){
			boolean isKey = isContainsByKey(entry.getKey(), uid, 2);
			log.info("在线用户 ： " + entry.getKey() + "--key--" + isKey);
			if (isKey) {
				PushWeb pushWeb = new PushWeb();
				pushWeb.setChannel(channel);
				pushWeb.setData(data);
				try {
					entry.getValue().getBasicRemote().sendText(ParameterDataUtil.getJson(pushWeb));
				} catch (IOException e) {
					log.error("发送失败 ： " + e.getMessage(), e);
				}
			}
		}
	}
	
	@Override
	public void sendMessage(List<Integer> uid, String channel, Object data) {
		// TODO Auto-generated method stub
		for (int i = 0; i < uid.size(); i++) {
			log.info("在线用户 ： " + uid.get(i) + "-通道： " + channel + "-内容：" + data);
			log.info("1-----------------------------------------------------------");
			sendMessage(uid.get(i), channel, data);
			log.info("2-----------------------------------------------------------");
		}
	}

	@Override
	public void sendMessage(List<Integer> uid, String channel, List<Object> data) {
		// TODO Auto-generated method stub
		
		for (int i = 0; i < data.size(); i++) {
			sendMessage(uid, channel, data.get(i));
		}
		
	}

	@Override
	public void sendMessageAll(String channel, Object data) {
		for(Map.Entry<String, Session> entry : getAllOnlineAccount().entrySet()){
			log.info("向所有用户推 ： " + entry.getKey());
			PushWeb pushWeb = new PushWeb();
			pushWeb.setChannel(channel);
			pushWeb.setData(data);
			try {
				entry.getValue().getBasicRemote().sendText(ParameterDataUtil.getJson(pushWeb));
			} catch (IOException e) {
				log.error("发送失败 ： " + e.getMessage(), e);
			}
		}
	}

	@Override
	public void sendMessageAll(Object data) {
		// TODO Auto-generated method stub
		sendMessageAll(ChannelID.NEWS_ANNOUNCEMENT, data);
	}

	@Override
	public Map<String, Session> getAllOnlineAccount() {
		// TODO Auto-generated method stub
		Map<String, Session> sessionMap = SocketPushService.SessionMap;
		if (null == sessionMap) {
			sessionMap = new HashMap<String, Session>();
		}
		return sessionMap;
	}
	
	
	public static void main(String[] args) {
		String key = "sfa12_keyfdas_12";
//		String[] strings = key.split("_");
//		for (int i = 0; i < strings.length; i++) {
//			System.err.println(strings[i]);
//		}
		String[] keys = key.split("_");
		if (keys[2].equals("12")) {
			System.err.println(22);
		}
		
	}

	@Override
	public boolean isContainsByKey(String key, Object obj, int bit) {
		
		String[] keys = key.split("_");
		if (keys[bit].equals(String.valueOf(obj))) {
			return true;
		}
		return false;
	}

}
*/