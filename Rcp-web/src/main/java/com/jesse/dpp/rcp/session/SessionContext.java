package com.jesse.dpp.rcp.session;

import javax.servlet.http.HttpSession;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.session.Session;

import com.jesse.dpp.rcp.po.Account;

/**
 * session全局工具类
 * @author dyq-t176
 *
 */
public class SessionContext {

	public static Account getAccount() {
		Session shiroSession = SecurityUtils.getSubject().getSession();
		Account account = (Account) shiroSession.getAttribute("account");
		if (null != account) {
			return account;
		}
		return null;
	}
	
	/**
	 * 消息推送用
	 * @param httpSession
	 * @return
	 */
	public static Account getAccountBySession(Session session) {
		Account account = (Account) session.getAttribute("account");
		if (null != account) {
			return account;
		}
		return null;
	}
	
}
