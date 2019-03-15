package com.jesse.dpp.rcp.po;

import java.io.Serializable;
import java.util.Date;

/**
 * Account 实体类
 * 
 * @author tsx-t171
 *
 */
public class Account implements Serializable {
    private static final long serialVersionUID = -1647762959504577078L;

    /**
     * 用户表ID主键
     */
    private Integer id;
    
    /**
     * 系统ID
     */
    private String systemId;

    /**
     * 用户登录名
     */
    private String loginName;

    /**
     * 登录密码
     */
    private String loginPwd;
    
    /**
     * 用户类型
     */
    private String accountType;

    /**
     * 注册邮箱
     */
    private String emailAddress;

    /**
     * 最后登录时间
     */
    private Date lastLogin;

    /**
     * 关联角色ID(多个角色ID使用逗号隔开)
     */
    private String roleId;

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
    
    public String getSystemId() {
        return systemId;
    }

    public void setSystemId(String systemId) {
        this.systemId = systemId == null ? null : systemId.trim();
    }

    public String getLoginName() {
        return loginName;
    }

    public void setLoginName(String loginName) {
        this.loginName = loginName == null ? null : loginName.trim();
    }

    public String getLoginPwd() {
        return loginPwd;
    }

    public void setLoginPwd(String loginPwd) {
        this.loginPwd = loginPwd == null ? null : loginPwd.trim();
    }
    
    public String getAccountType() {
        return accountType;
    }

    public void setAccountType(String accountType) {
        this.accountType = accountType == null ? null : accountType.trim();
    }

    public String getEmailAddress() {
        return emailAddress;
    }

    public void setEmailAddress(String emailAddress) {
        this.emailAddress = emailAddress == null ? null : emailAddress.trim();
    }

    public Date getLastLogin() {
        return lastLogin;
    }

    public void setLastLogin(Date lastLogin) {
        this.lastLogin = lastLogin;
    }

    public String getRoleId() {
        return roleId;
    }

    public void setRoleId(String roleId) {
        this.roleId = roleId == null ? null : roleId.trim();
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
		return "Account [id=" + id + ", systemId=" + systemId + ", loginName=" + loginName + ", loginPwd=" + loginPwd
				+ ", accountType=" + accountType + ", emailAddress=" + emailAddress + ", lastLogin=" + lastLogin
				+ ", roleId=" + roleId + ", status=" + status + ", creatorId=" + creatorId + ", createDate="
				+ createDate + ", updaterId=" + updaterId + ", updateDate=" + updateDate + "]";
	}
    
}