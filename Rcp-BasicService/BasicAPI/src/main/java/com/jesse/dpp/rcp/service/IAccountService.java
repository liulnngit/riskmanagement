package com.jesse.dpp.rcp.service;

import java.util.Map;

import com.jesse.dpp.rcp.po.Account;
import com.jesse.dpp.rcp.vo.AccountVo;

public interface IAccountService {
    /**
     * 根据ID和systemId删除用户
     * @param id
     * @param systemId
     * @return
     */
    public int deleteByPrimaryKey(Integer id, String systemId);

    /**
     * 新增用户
     * @param account
     * @return
     */
    public int insert(Account account);

    /**
     * 新增用户
     * @param account
     * @return
     */
    public int insertSelective(Account account);

    /**
     * 根据ID查询用户
     * @param id
     * @return
     */
    public Account selectByPrimaryKey(Integer id);

    /**
     * 更新用户
     * @param account
     * @return
     */
    public int updateByPrimaryKeySelective(Account account);

    /**
     * 更新用户
     * @param account
     * @return
     */
    public int updateByPrimaryKey(Account account);

    /**
     * 根据登录名称查询用户
     * @param loginName
     * @return
     */
    public Account selectAccountByLoginName(String loginName);

    /**
     * 根据邮箱地址查询用户
     * @param email
     * @return
     */
    public Account selectAccountByEmail(String email);

    /**
     * 根据登录名称查询用户
     * @param loginName
     * @return
     */
    public AccountVo selectAccountVoByLoginName(String loginName);

    /**
     * 添加用户
     * @param record
     * @param roleIds
     * @param creatorId
     * @param basePath
     * @param ipAddress
     * @return
     */
    public int addAccount(Account account, String roleIds, Integer creatorId, String basePath, String ipAddress);

    /**
     * 删除用户
     * @param id
     * @param account
     * @param ipAddress
     * @return
     */
    public int deleteAccount(Integer id, Account account, String ipAddress);

    /**
     * 更新用户
     * @param account
     * @param roleIds
     * @param updaterId
     * @param ipAddress
     * @return
     */
    public int updateAccount(Account account, String roleIds, Integer updaterId, String ipAddress);

    /**
     * 分页列表展示
     * 
     * @param status
     * @param currentPage
     * @param limit
     * @return
     */
    public Map<String, Object> selectAccountListByPagination(int currentPage, Integer limit, String systemId, String jsonParam);

    /**
     * 检查登录名和邮箱地址
     * @param account
     * @param systemId
     * @return
     */
    public boolean checkLoginNameAndEmail(Account account, String systemId);

    /**
     * 检查邮箱地址
     * @param emailAddress
     * @param id
     * @return
     */
    public boolean checkEmailAddress(String emailAddress, String id);

    /**
     * 检查登录名
     * @param loginName
     * @param id
     * @return
     */
    public boolean checkLoginName(String loginName, String id);
    
    /**
     * 发送激活邮件
     * @param accountId
     * @param updaterId
     * @param basePath
     * @return
     */
    public int sendActiviEmail(Integer accountId, Integer updaterId, String basePath);
    
    /**
     * 查询系统Admin账户
     * @param systemId
     * @return
     */
    public Account selectSysAdmin(String systemId);
}