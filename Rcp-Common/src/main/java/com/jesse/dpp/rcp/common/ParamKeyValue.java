package com.jesse.dpp.rcp.common;

import java.io.Serializable;

public class ParamKeyValue implements Serializable {
    private static final long serialVersionUID = -1647762959504577078L;

    private String name;

    private String key;

    private String value;

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getKey() {
        return key;
    }

    public void setKey(String key) {
        this.key = key;
    }

    public String getValue() {
        return value;
    }

    public void setValue(String value) {
        this.value = value;
    }
}
