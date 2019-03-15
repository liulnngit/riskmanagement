package com.jesse.dpp.rcp.vo;

import org.apache.commons.lang.StringUtils;

import com.jesse.dpp.rcp.po.Account;
import com.jesse.dpp.rcp.po.PolicyFile;
import com.jesse.dpp.rcp.po.SystemType;
import com.jesse.dpp.rcp.utils.formatdate.FormatDateUtil;

public class PolicyFileVo extends PolicyFile {

	/**
	 * 
	 */
	private static final long serialVersionUID = -1902216663988699126L;

	private Account account;
	
	private SystemType systemType;

	public Account getAccount() {
		return account;
	}

	public void setAccount(Account account) {
		this.account = account;
	}

	public SystemType getSystemType() {
		return systemType;
	}

	public void setSystemType(SystemType systemType) {
		this.systemType = systemType;
	}
	
	public String getCreator() {
		if (null != account) {
			return account.getLoginName();
		} else {
			return "";
		}
	}
	
	public String getSystemName() {
		if (null != systemType) {
			return systemType.getSystemName();
		} else {
			return "";
		}
	}

	@Override
	public String getCreateDate() {
		String date = super.getCreateDate();
		if (StringUtils.isNotBlank(date)) {
			return FormatDateUtil.formatDate(date);
		} else {
			return "";
		}
	}
	
}
