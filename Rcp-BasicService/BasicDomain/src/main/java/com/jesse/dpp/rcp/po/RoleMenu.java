package com.jesse.dpp.rcp.po;

import java.io.Serializable;

public class RoleMenu implements Serializable {
    private static final long serialVersionUID = -1647762959504577078L;

    private Integer id;

    private Integer roleId;

    private Integer menuId;

    private String status;

    private Integer creatorId;

    private Integer updaterId;

    private String createDate;

    private String updateDate;

    public RoleMenu() {
		super();
		// TODO Auto-generated constructor stub
	}

	public RoleMenu(Integer id, Integer roleId, Integer menuId, String status, Integer creatorId, Integer updaterId,
			String createDate, String updateDate) {
		super();
		this.id = id;
		this.roleId = roleId;
		this.menuId = menuId;
		this.status = status;
		this.creatorId = creatorId;
		this.updaterId = updaterId;
		this.createDate = createDate;
		this.updateDate = updateDate;
	}

	public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getRoleId() {
        return roleId;
    }

    public void setRoleId(Integer roleId) {
        this.roleId = roleId;
    }

    public Integer getMenuId() {
        return menuId;
    }

    public void setMenuId(Integer menuId) {
        this.menuId = menuId;
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

    public Integer getUpdaterId() {
        return updaterId;
    }

    public void setUpdaterId(Integer updaterId) {
        this.updaterId = updaterId;
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

	@Override
	public String toString() {
		return "RoleMenu [id=" + id + ", roleId=" + roleId + ", menuId=" + menuId + ", status=" + status
				+ ", creatorId=" + creatorId + ", updaterId=" + updaterId + ", createDate=" + createDate
				+ ", updateDate=" + updateDate + "]";
	}
    
}