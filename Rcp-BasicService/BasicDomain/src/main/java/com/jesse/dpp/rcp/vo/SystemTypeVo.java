package com.jesse.dpp.rcp.vo;

import java.io.Serializable;

import com.jesse.dpp.rcp.constant.Constant;
import com.jesse.dpp.rcp.po.SystemType;
import com.jesse.dpp.rcp.utils.formatdate.FormatDateUtil;

public class SystemTypeVo extends SystemType implements Serializable {
    /**
     * 
     */
    private static final long serialVersionUID = 9084020356025142253L;
    
    public String getCreateTime() {
        return FormatDateUtil.formatDate(super.getCreateDate());
    }
    
    @Override
    public String getStatus() {
        if(Constant.RECORD_ACTIVE.equals(super.getStatus())){
            return "启用";
        } else if(Constant.RECORD_INACTIVE.equals(super.getStatus())){
            return "禁用";
        }
        return null;
    }
}