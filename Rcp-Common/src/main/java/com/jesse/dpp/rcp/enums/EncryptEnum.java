package com.jesse.dpp.rcp.enums;

public enum EncryptEnum {
    Encrypt_Type_MD5("MD5", "MD5加密"), 
    Encrypt_Type_SHA1("SHA-1", "SHA-1加密"), 
    Encrypt_Type_SHA256("SHA-256", "SHA-256加密"),
    Encrypt_Type_SHA384("SHA-384", "SHA-384加密"),
    Encrypt_Type_SHA512("SHA-512", "SHA-512加密")
    ;

    private String encryptType;
    
    private String desc;

    private EncryptEnum(String encryptType, String desc) {
        this.encryptType = encryptType;
        this.desc = desc;
    }

    public String getEncryptType() {
        return encryptType;
    }

    public void setEncryptType(String encryptType) {
        this.encryptType = encryptType;
    }

    public String getDesc() {
        return desc;
    }

    public void setDesc(String desc) {
        this.desc = desc;
    }
}
