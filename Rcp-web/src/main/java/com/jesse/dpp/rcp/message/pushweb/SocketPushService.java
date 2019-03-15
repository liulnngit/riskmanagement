package com.jesse.dpp.rcp.message.pushweb;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;
import javax.websocket.EndpointConfig;
import javax.websocket.OnClose;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.server.ServerEndpoint;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.jesse.dpp.rcp.po.Account;
import com.jesse.dpp.rcp.session.GetHttpSessionConfigurator;
import com.jesse.dpp.rcp.session.SessionContext;

@ServerEndpoint(value = "/websocket", configurator = GetHttpSessionConfigurator.class)
public class SocketPushService {

    private static final Log log = LogFactory.getLog(SocketPushService.class);

    /**
     * 用于存放当前在线用户(key sysId_roleId_accountId)
     */
    public static Map<String, Session> SessionMap = new HashMap<String, Session>();

    /**
     * 连接建立成功调用的方法
     * 
     * @param session 可选的参数。session为与某个客户端的连接会话，需要通过它来给客户端发送数据
     * @throws InterruptedException
     */
    @OnOpen
    public void onOpen(Session session, EndpointConfig config) throws InterruptedException {

        Thread.sleep(2000L);
        String key = getAccountKey(config);
        if (null != key) {
            SessionMap.put(key, session);
            log.info("新增用户： " + key);
            log.info("当前在线用户数： " + SessionMap.size());
        } else {
            log.info("新增 session 中当前用户为 null");
        }
    }

    /**
     * 连接关闭调用的方法
     */
    @OnClose
    public void onClose(Session session) {
        try {
            String key = null;
            for (Map.Entry<String, Session> entry : SessionMap.entrySet()) {
                String keyId = entry.getValue().getId();
                if (session.getId().equals(keyId)) {
                    key = entry.getKey();
                    break;
                }
            }

            if (null != key) {
                SessionMap.remove(key); // 从在线列表已出
                log.info("有一连接关闭！当前在线人数为" + SessionMap.size());
            } else {
                log.info("移除 session 中用户为 null");
            }
        } catch (Exception e) {
            log.error(e.getMessage(), e);
        }

    }

    /**
     * 收到客户端消息后调用的方法(目前没需求暂时弃用)
     * 
     * @param message 客户端发送过来的消息
     * @param session 可选的参数
     */
    
    @OnMessage
    public void onMessage(String message, Session session) {
    	if ("Heartbeat".equals(message)) {
        	try {
				session.getBasicRemote().sendText("Server HeartBeat");
			} catch (IOException e) {
				// TODO Auto-generated catch block
				log.error(e.getMessage(), e);
			}
		}
    }

    /**
     * 新增 根据 session 发送消息
     * 
     * @param session
     * @param message
     * @throws IOException
     */
    public void sendMessage(Session session, String message) throws IOException {
        session.getBasicRemote().sendText(message);
    }

    /**
     * 根据 session 找到 account
     * 
     * @param config
     * @return
     * @throws IOException
     */
    public String getAccountKey(EndpointConfig config) {
        // org.apache.shiro.session.Session shiroSession= (org.apache.shiro.session.Session)
        // config.getUserProperties().get(org.apache.shiro.session.Session.class.getName());
        HttpSession httpSession = (HttpSession) config.getUserProperties().get(HttpSession.class.getName());
        Account account = (Account) httpSession.getAttribute("account");
        // Account account = SessionContext.getAccount();
        if (null != account) {
            log.info("当前用户 ： " + account);
        }
        String key = null;
        if (null != account) {
            key = account.getSystemId() + "_" + account.getRoleId() + "_" + account.getId();
        }
        return key;
    }

    /**
     * 退出 根据 session 找到 account
     * 
     * @param config
     * @return
     * @throws IOException
     */
    public String getAccountKey() {

        Account account = SessionContext.getAccount();
        if (null != account) {
            log.info("当前用户 ： " + account);
        }
        String key = null;
        if (null != account) {
            key = account.getSystemId() + "_" + account.getRoleId() + "_" + account.getId();
        }
        return key;
    }
}
