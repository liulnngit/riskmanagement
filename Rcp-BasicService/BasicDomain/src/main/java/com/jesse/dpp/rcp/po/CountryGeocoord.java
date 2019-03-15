package com.jesse.dpp.rcp.po;

import java.io.Serializable;

/**
 * 国家坐标
 * @author dyq-t176
 *
 */
public class CountryGeocoord implements Serializable {
    /**
     * 
     */
    private static final long serialVersionUID = 4786090371870094411L;

    private Integer id;

    private Integer creatorId;

    private Integer updaterId;

    private String name;

    private String nameEn;

    private String geoCoord;

    private String code;

    private String threeCode;
	
	private String createDate;

    private String updateDate;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getCreatorId() {
        return creatorId;
    }

    public void setCreatorId(Integer creatorId) {
        this.creatorId = creatorId;
    }

    public Integer getUpdaterId() {
        return updaterId;
    }

    public void setUpdaterId(Integer updaterId) {
        this.updaterId = updaterId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name == null ? null : name.trim();
    }

    public String getNameEn() {
        return nameEn;
    }

    public void setNameEn(String nameEn) {
        this.nameEn = nameEn == null ? null : nameEn.trim();
    }

    public String getGeoCoord() {
        return geoCoord;
    }

    public void setGeoCoord(String geoCoord) {
        this.geoCoord = geoCoord == null ? null : geoCoord.trim();
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code == null ? null : code.trim();
    }

    public String getThreeCode() {
        return threeCode;
    }

    public void setThreeCode(String threeCode) {
        this.threeCode = threeCode == null ? null : threeCode.trim();
    }
	
	public String getCreateDate() {
        return createDate;
    }

    public void setCreateDate(String createDate) {
        this.createDate = createDate == null ? null : createDate.trim();
    }

    public String getUpdateDate() {
        return updateDate;
    }

    public void setUpdateDate(String updateDate) {
        this.updateDate = updateDate == null ? null : updateDate.trim();
    }
}