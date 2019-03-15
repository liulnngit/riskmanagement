package com.jesse.dpp.rcp.po;

import java.io.Serializable;

public class StateCode implements Serializable {
    private static final long serialVersionUID = -1647762959504577078L;

    private String stateCode;

    private String countryCode;

    private String name;

    public String getStateCode() {
        return stateCode;
    }

    public void setStateCode(String stateCode) {
        this.stateCode = stateCode == null ? null : stateCode.trim();
    }

    public String getCountryCode() {
        return countryCode;
    }

    public void setCountryCode(String countryCode) {
        this.countryCode = countryCode == null ? null : countryCode.trim();
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name == null ? null : name.trim();
    }
}