/*package com.jesse.dpp.rcp.message.metaq;

import java.util.List;
import java.util.Map;

import javax.websocket.Session;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.rocketmq.client.consumer.DefaultMQPushConsumer;
import org.apache.rocketmq.client.consumer.listener.ConsumeConcurrentlyContext;
import org.apache.rocketmq.client.consumer.listener.ConsumeConcurrentlyStatus;
import org.apache.rocketmq.client.consumer.listener.MessageListenerConcurrently;
import org.apache.rocketmq.common.message.MessageExt;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.jesse.dpp.rcp.message.pushweb.IMessagePushService;
import com.jesse.dpp.rcp.service.IAccountService;
import com.jesse.dpp.rcp.utils.ParameterDataUtil;
import com.jesse.dpp.rcp.vo.PushDetails;

@Service
public class RocketMQMessageListener implements MessageListenerConcurrently {

	private static final Log log = LogFactory.getLog(RocketMQMessageListener.class);
	
	@Autowired
	IMessagePushService iMessagePushService;
	
	@Autowired
	IAccountService iAccountService;
	
	@Override
	public ConsumeConcurrentlyStatus consumeMessage(List<MessageExt> msgs, ConsumeConcurrentlyContext context) {
		
		if (null != msgs && msgs.size() > 0) {
			for (MessageExt messageExt : msgs) {
				String body = new String(messageExt.getBody());
				try {
					// 接受消息体，解析推送到前端
					PushDetails pushDetails = ParameterDataUtil.getObject(body, PushDetails.class);
					log.info("消息来了！==" + pushDetails);
					if (null != pushDetails) {
						pushObject(pushDetails);
					}
				} catch (Exception e) {
					log.error("pushDetails exception : " + e.getMessage() , e);
				}
			}
		}
		return ConsumeConcurrentlyStatus.CONSUME_SUCCESS;
	}

	public void pushObject(PushDetails pushDetails) {
		//获取所有在线用户
		Map<String, Session> allLine = iMessagePushService.getAllOnlineAccount();
		log.info("当前在线用户人数  ： " + allLine.size());
		if (allLine.size() > 0) {
			if (null != pushDetails.getIds() && pushDetails.getIds().size() > 0) {  //用户 ID 不为空
				iMessagePushService.sendMessage(pushDetails.getIds(), pushDetails.getType(), pushDetails.getDetails());
			}else if (null != pushDetails.getRoleIds() && pushDetails.getRoleIds().size() > 0) {  //角色不为空
				iMessagePushService.sendMessage(pushDetails.getRoleIds(), pushDetails.getType(), pushDetails.getDetails(), 1);
			}else if (null != pushDetails.getSysIds() && pushDetails.getSysIds().size() > 0) {  //系统不为空
				iMessagePushService.sendMessage(pushDetails.getSysIds(), pushDetails.getType(), pushDetails.getDetails(), 0);
			}else{ //id roleId sysId 都为null,推送全网在线用户
				iMessagePushService.sendMessageAll(pushDetails.getType(), pushDetails.getDetails());
			}
		}
	}

}
*/