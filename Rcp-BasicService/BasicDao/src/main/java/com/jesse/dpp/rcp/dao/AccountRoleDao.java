package com.jesse.dpp.rcp.dao;

import java.util.List;
import java.util.Map;

import com.jesse.dpp.rcp.po.AccountRole;

public interface AccountRoleDao {
    int deleteByPrimaryKey(Integer id);

    int insert(AccountRole accountRole);

    int insertSelective(AccountRole accountRole);

    AccountRole selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(AccountRole accountRole);

    int updateByPrimaryKeyWithBLOBs(AccountRole accountRole);

    int updateByPrimaryKey(AccountRole accountRole);
    
    List<AccountRole> selectRoleListByAccountId(Integer accountId);

    List<AccountRole> selectAccountListByRoleId(Integer roleId);

    int deleteBatchByRoleId(Map<String, Object> map);

    int deleteBatchByAccountId(Map<String, Object> map);

    /**
     * 根据用户 id 查找用户-角色关系
     * 
     * @param accountID
     * @return
     */
    List<AccountRole> selectByPrimaryAccountID(Integer accountID);
    
    
    List<AccountRole> selectAccountList();
}