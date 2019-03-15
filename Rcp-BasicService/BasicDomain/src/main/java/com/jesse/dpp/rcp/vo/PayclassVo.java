package com.jesse.dpp.rcp.vo;

import org.apache.commons.lang.StringUtils;

import com.jesse.dpp.rcp.po.Account;
import com.jesse.dpp.rcp.po.Payclass;
import com.jesse.dpp.rcp.po.SystemType;
import com.jesse.dpp.rcp.utils.formatdate.FormatDateUtil;

public class PayclassVo extends Payclass {

	/**
	 * 
	 */
	private static final long serialVersionUID = 6348305172217200795L;
	
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
	
	@Override
	public String getAccessType() {
		String at = super.getAccessType();
		if (StringUtils.isNotBlank(at)) {
			if ("1".equals(at)) {
				return "WEB";
			} else if ("2".equals(at)) {
				return "WAP";
			} else if ("3".equals(at)) {
				return "手机";
			} else {
				return "短信";
			}
		} else {
			return "";
		}
	}

	public String getCreator() {
		if (null != account) {
			return account.getLoginName();
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

	@Override
	public String getUpdateDate() {
		String date = super.getUpdateDate();
		if (StringUtils.isNotBlank(date)) {
			return FormatDateUtil.formatDate(date);
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

}
