package com.jesse.dpp.rcp.vo;

import org.apache.commons.lang.StringUtils;

import com.jesse.dpp.rcp.po.Account;
import com.jesse.dpp.rcp.po.Role;
import com.jesse.dpp.rcp.po.SystemType;
import com.jesse.dpp.rcp.utils.formatdate.FormatDateUtil;

/**
 * 角色扩展类
 * @author dyq-t176
 *
 */
public class RoleVo extends Role {

	/**
	 * 
	 */
	private static final long serialVersionUID = 3592597695934640865L;
	
	private Account account;
	
	private SystemType systemType;
	
	private Account updateAccount;
	
	public Account getUpdateAccount() {
		return updateAccount;
	}

	public void setUpdateAccount(Account updateAccount) {
		this.updateAccount = updateAccount;
	}

	public SystemType getSystemType() {
		return systemType;
	}

	public void setSystemType(SystemType systemType) {
		this.systemType = systemType;
	}

	public Account getAccount() {
		return account;
	}

	public void setAccount(Account account) {
		this.account = account;
	}
	
	public String getCreator() {
		if (null != account && StringUtils.isNotBlank(account.getLoginName())) {
			return account.getLoginName();
		} else {
			return "";
		}
	}

	public String getCreateTime() {
	    return FormatDateUtil.formatDate(super.getCreateDate());
	}
	
	public String getRoleStatus() {
		if (StringUtils.isNotBlank(this.getStatus())) {
			if ("A".equals(this.getStatus()) || "S".equals(this.getStatus())) {
				return "正常";
			} else {
				return "禁用";
			}
		} else {
			return "";
		}
	}
	
	public String getSystemName() {
		if (null != systemType && StringUtils.isNotBlank(systemType.getSystemName())) {
			return systemType.getSystemName();
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
	
	public String getUpdater() {
		if (null != updateAccount && StringUtils.isNotBlank(updateAccount.getLoginName())) {
			return updateAccount.getLoginName();
		} else {
			return "";
		}
	}

}
