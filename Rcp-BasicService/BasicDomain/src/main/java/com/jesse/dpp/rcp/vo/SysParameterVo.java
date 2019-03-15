package com.jesse.dpp.rcp.vo;

import java.io.Serializable;

import org.apache.commons.lang.StringUtils;

import com.jesse.dpp.rcp.constant.Constant;
import com.jesse.dpp.rcp.po.Account;
import com.jesse.dpp.rcp.po.SysParameter;
import com.jesse.dpp.rcp.utils.formatdate.FormatDateUtil;

public class SysParameterVo extends SysParameter implements Serializable {
    private static final long serialVersionUID = -1647762959504577078L;
    
    private Account account;
    
    private Account upAccount;
    
    public Account getAccount() {
        return account;
    }

    public void setAccount(Account account) {
        this.account = account;
    }

    public Account getUpAccount() {
        return upAccount;
    }

    public void setUpAccount(Account upAccount) {
        this.upAccount = upAccount;
    }

    public String getUpdateTime() {
	    return FormatDateUtil.formatDate(super.getUpdateDate());
	}
    
    public String getCreator() {
        if (null != account && StringUtils.isNotBlank(account.getLoginName())) {
            return account.getLoginName();
        } else {
            return "";
        }
    }
    
    public String getUpdater() {
        if (null != upAccount && StringUtils.isNotBlank(upAccount.getLoginName())) {
            return upAccount.getLoginName();
        } else {
            return "";
        }
    }

    @Override
    public String getStatus() {
        String sta = super.getStatus();
        if (StringUtils.isNotBlank(sta)) {
            if (Constant.RECORD_ACTIVE.equalsIgnoreCase(sta)) {
                return "正常";
            } else {
                return "禁用";
            }
        } else {
            return "";
        }
    }
}
