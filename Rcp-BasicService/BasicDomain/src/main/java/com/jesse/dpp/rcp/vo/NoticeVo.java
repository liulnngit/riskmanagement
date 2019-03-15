package com.jesse.dpp.rcp.vo;

import java.io.Serializable;
import java.text.SimpleDateFormat;

import org.apache.commons.lang.StringUtils;

import com.jesse.dpp.rcp.po.Account;
import com.jesse.dpp.rcp.po.Notice;
import com.jesse.dpp.rcp.utils.formatdate.FormatDateUtil;

public class NoticeVo extends Notice implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = -4164086528818197350L;
	
	private Account account;
	
	private Account upAccount;
	
	public Account getUpAccount() {
		return upAccount;
	}

	public void setUpAccount(Account upAccount) {
		this.upAccount = upAccount;
	}

	public Account getAccount() {
		return account;
	}

	public void setAccount(Account account) {
		this.account = account;
	}
	
	public String getCreateTime() {
		if (StringUtils.isNotBlank(super.getCreateDate())) {
			return FormatDateUtil.formatDate(super.getCreateDate());
		}else {
			return "";
		}
	}
	
	public String getCreator() {
		if (null != account && (StringUtils.isNotBlank(account.getLoginName()))) {
			return account.getLoginName();
		} else {
			return "";
		}
	}
	
	public String getStatus() {
		String sta = super.getStatus();
		if (StringUtils.isNotBlank(sta)) {
			if ("A".equals(sta)) {
				return "已发布";
			}else {
				return "未发布";
			}
		} else {
			return "";
		}
	}

	public String getUpdateTime() {
		String date = super.getUpdateDate();
		if (StringUtils.isNotBlank(date)) {
			return FormatDateUtil.formatDate(date);
		} else {
			return "";
		}
	}
	
	public String getUpdater() {
		if (null != upAccount) {
			return upAccount.getLoginName();
		} else {
			return "";
		}
	}

}
