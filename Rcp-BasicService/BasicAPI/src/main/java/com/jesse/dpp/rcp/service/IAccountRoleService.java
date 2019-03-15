package com.jesse.dpp.rcp.service;

import java.util.List;

import com.jesse.dpp.rcp.po.AccountRole;

public interface IAccountRoleService {
    int deleteByPrimaryKey(Integer id);

    int insert(AccountRole accountRole);

    int insertSelective(AccountRole accountRole);

    AccountRole selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(AccountRole accountRole);

    int updateByPrimaryKeyWithBLOBs(AccountRole accountRole);

    int updateByPrimaryKey(AccountRole accountRole);

    List<AccountRole> selectRoleListByAccountId(Integer accountId);

    List<AccountRole> selectAccountListByRoleId(Integer roleId);
    
    /**
     * 根据用户 id 查找用户-角色关系
     * 
     * @param accountID
     * @return
     */
    List<AccountRole> selectByPrimaryAccountID(Integer accountID);
    
    /**
     * 根据AccountId删除关联
     * @param accountId
     * @return
     */
    int deleteBatchByAccountId(Integer accountId);
    
    /**
     * 根据RoleID删除关联
     * @param roleId
     * @return
     */
    int deleteBatchByRoleId(Integer roleId);
    
    /**
     * 查询所有 accountRole (权限控制用)
     * 
     * @return
     */
    List<AccountRole> selectAccountList();
}