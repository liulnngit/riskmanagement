package com.jesse.dpp.rcp.po;

import java.io.Serializable;

/**
 * Menu 实体类
 * 
 * @author tsx-t171
 *
 */
public class Menu implements Serializable {
    private static final long serialVersionUID = -1647762959504577078L;

    /**
     * 菜单表ID主键
     */
    private Integer id;

    /**
     * 菜单名称
     */
    private String menuName;
    
    /**
     * 菜单类型
     */
    private String menuType;

    /**
     * 父菜单ID(一级菜单父菜单ID为0)
     */
    private Integer parentId;

    /**
     * 菜单优先级
     */
    private Integer priority;

    /**
     * 菜单URL链接
     */
    private String linkUrl;

    /**
     * 状态(A=Active, I=Inactive)
     */
    private String status;

    /**
     * 创建人ID
     */
    private Integer creatorId;

    /**
     * 创建时间
     */
    private String createDate;

    /**
     * 更新人ID
     */
    private Integer updaterId;

    /**
     * 更新时间
     */
    private String updateDate;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getMenuName() {
        return menuName;
    }

    public void setMenuName(String menuName) {
        this.menuName = menuName == null ? null : menuName.trim();
    }
    
    public String getMenuType() {
        return menuType;
    }

    public void setMenuType(String menuType) {
        this.menuType = menuType == null ? null : menuType.trim();
    }

    public Integer getParentId() {
        return parentId;
    }

    public void setParentId(Integer parentId) {
        this.parentId = parentId;
    }

    public Integer getPriority() {
        return priority;
    }

    public void setPriority(Integer priority) {
        this.priority = priority;
    }

    public String getLinkUrl() {
        return linkUrl;
    }

    public void setLinkUrl(String linkUrl) {
        this.linkUrl = linkUrl == null ? null : linkUrl.trim();
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status == null ? null : status.trim();
    }

    public Integer getCreatorId() {
        return creatorId;
    }

    public void setCreatorId(Integer creatorId) {
        this.creatorId = creatorId;
    }

    public String getCreateDate() {
        return createDate;
    }

    public void setCreateDate(String createDate) {
        this.createDate = createDate == null ? null : createDate.trim();
    }

    public Integer getUpdaterId() {
        return updaterId;
    }

    public void setUpdaterId(Integer updaterId) {
        this.updaterId = updaterId;
    }

    public String getUpdateDate() {
        return updateDate;
    }

    public void setUpdateDate(String updateDate) {
        this.updateDate = updateDate == null ? null : updateDate.trim();
    }

    @Override
    public String toString() {
        return "Menu [id=" + id + ", menuName=" + menuName + ", parentId=" + parentId + ", priority=" + priority + ", linkUrl=" + linkUrl + ", status=" + status + ", creatorId=" + creatorId + ", createDate=" + createDate + ", updaterId=" + updaterId + ", updateDate=" + updateDate + "]";
    }

}