package com.jesse.dpp.rcp.vo;

import org.apache.commons.lang.StringUtils;

import com.jesse.dpp.rcp.constant.Constant;
import com.jesse.dpp.rcp.po.Account;
import com.jesse.dpp.rcp.po.BusinessType;
import com.jesse.dpp.rcp.utils.formatdate.FormatDateUtil;

public class BusinessTypeVo extends BusinessType {

    private static final long serialVersionUID = -6074786873729765993L;

    private Account account;

    private Account upAccount;

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

    public String getUpdater() {
        if (null != upAccount && StringUtils.isNotBlank(upAccount.getLoginName())) {
            return upAccount.getLoginName();
        } else {
            return "";
        }
    }

    public String getFormatStatus() {
        String sta = super.getStatus();
        if (StringUtils.isNotBlank(sta)) {
            if (Constant.RECORD_INACTIVE.equalsIgnoreCase(sta)) {
                return "禁用";
            } else {
                return "正常";
            }
        } else {
            return "";
        }
    }

    @Override
    public String getCreateDate() {
        return FormatDateUtil.formatDate(super.getCreateDate());
    }

    @Override
    public String getUpdateDate() {
        return FormatDateUtil.formatDate(super.getUpdateDate());
    }

    public Account getUpAccount() {
        return upAccount;
    }

    public void setUpAccount(Account upAccount) {
        this.upAccount = upAccount;
    }

}
