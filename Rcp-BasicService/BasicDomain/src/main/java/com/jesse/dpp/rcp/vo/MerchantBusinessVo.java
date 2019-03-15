package com.jesse.dpp.rcp.vo;

import java.io.Serializable;

import org.apache.commons.lang.StringUtils;

import com.jesse.dpp.rcp.constant.Constant;
import com.jesse.dpp.rcp.po.MerchantBusiness;
import com.jesse.dpp.rcp.utils.formatdate.FormatDateUtil;

public class MerchantBusinessVo extends MerchantBusiness implements Serializable {

    private static final long serialVersionUID = -6074786873729765993L;
    
    private String businessName;
    
    private String merchantName;
    
    private String creator;
    
    private String updater;

    public String getCreator() {
		return creator;
	}

	public void setCreator(String creator) {
		this.creator = creator;
	}

	public String getUpdater() {
		return updater;
	}

	public void setUpdater(String updater) {
		this.updater = updater;
	}

	public String getBusinessName() {
		return businessName;
	}

	public void setBusinessName(String businessName) {
		this.businessName = businessName;
	}

	public String getMerchantName() {
		return merchantName;
	}

	public void setMerchantName(String merchantName) {
		this.merchantName = merchantName;
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

    @Override
    public String getCreateDate() {
        return FormatDateUtil.formatDate(super.getCreateDate());
    }

    @Override
    public String getUpdateDate() {
        return FormatDateUtil.formatDate(super.getUpdateDate());
    }

}