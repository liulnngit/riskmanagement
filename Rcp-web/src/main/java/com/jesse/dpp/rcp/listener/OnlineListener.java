package com.jesse.dpp.rcp.listener;

import java.util.Date;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

import com.jesse.dpp.rcp.po.Account;
import com.jesse.dpp.rcp.service.IAccountService;

public class OnlineListener implements HttpSessionListener {
    private static Log log = LogFactory.getLog(OnlineListener.class);

    public void sessionCreated(HttpSessionEvent event) {

    }

    public void sessionDestroyed(HttpSessionEvent event) {
        HttpSession session = event.getSession();
        Account account = (Account) session.getAttribute("account");

        if (null != account && null != account.getId()) {
            ServletContext application = session.getServletContext();
            WebApplicationContext appctx = WebApplicationContextUtils.getWebApplicationContext(application);
            
            IAccountService iAccountService = (IAccountService)appctx.getBean("iAccountService");
            //重新查一遍,Session中的Account密码为空
            account = iAccountService.selectByPrimaryKey(account.getId());
            
            log.info("ID : " + account.getId() + ", loginName : " + account.getLoginName());
            account.setLastLogin(new Date());
            iAccountService.updateByPrimaryKey(account);
        }
    }
}