package com.jesse.dpp.rcp.session;

import javax.servlet.http.HttpSession;
/**
 * @author wzs-t178 
 * 
 * websocket 与 http 协议不同,走websocket 协议时需要获取 httpSession
 */
import javax.websocket.HandshakeResponse;
import javax.websocket.server.HandshakeRequest;
import javax.websocket.server.ServerEndpointConfig;
import javax.websocket.server.ServerEndpointConfig.Configurator;

import com.alibaba.druid.support.logging.Log;

public class GetHttpSessionConfigurator extends Configurator {

    @Override
    public void modifyHandshake(ServerEndpointConfig sec,
            HandshakeRequest request, HandshakeResponse response) {
        // TODO Auto-generated method stub
    	HttpSession httpSession=(HttpSession) request.getHttpSession();
        sec.getUserProperties().put(HttpSession.class.getName(),httpSession);
    }
    
}
