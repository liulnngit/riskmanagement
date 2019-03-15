package com.jesse.dpp.rcp.vo;

import java.io.Serializable;
import java.text.SimpleDateFormat;
import java.util.List;

import org.apache.commons.lang.StringUtils;

import com.jesse.dpp.rcp.po.Account;
import com.jesse.dpp.rcp.po.Role;
import com.jesse.dpp.rcp.po.SystemType;
import com.jesse.dpp.rcp.utils.formatdate.FormatDateUtil;

public class AccountVo extends Account  implements Serializable {
    private static final long serialVersionUID = -1647762959504577078L;
    
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

	private List<Role> roleList;

	public List<Role> getRoleList() {
		return roleList;
	}

	public void setRoleList(List<Role> roleList) {
		this.roleList = roleList;
	}
	
	public String getAccountStatus() {
		if ("A".equals(this.getStatus()) || "S".equals(this.getStatus())) {
			return "正常";
		} else {
			return "未激活";
		}
	}
	
	public String getCreateTime() {
	    return FormatDateUtil.formatDate(super.getCreateDate());
	}
	
	public String getUpdateTime() {
	    return FormatDateUtil.formatDate(super.getUpdateDate());
	}
	
	public String getLastLoginTime() {
		if (null != this.getLastLogin()){
			SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			return format.format(this.getLastLogin());
		} else {
			return null;
		}
	}
	
	public String getRoleName() {
		StringBuilder sb = new StringBuilder();
		if (null != roleList && roleList.size() > 0) {
			for (int i = 0; i < roleList.size(); i++) {
				if (i == 0) {
					sb.append(roleList.get(i).getRoleName());
				} else if (i == roleList.size() - 1) {
					sb.append(",").append(roleList.get(i).getRoleName());
				} else {
					sb.append(",").append(roleList.get(i).getRoleName());
				}
			}
			return sb.toString();
		}
		return "";
	}
	
	public String getSystemName() {
		if (null != systemType) {
			return systemType.getSystemName();
		} else {
			return "";
		}
	}
	
	public String getCreator() {
        if (null != account && StringUtils.isNotBlank(account.getLoginName())) {
            return account.getLoginName();
        } else {
            return "";
        }
    }
}
