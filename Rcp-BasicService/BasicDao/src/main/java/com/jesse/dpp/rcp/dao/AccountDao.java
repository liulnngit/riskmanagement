package com.jesse.dpp.rcp.dao;

import java.util.List;
import java.util.Map;

import com.jesse.dpp.rcp.po.Account;
import com.jesse.dpp.rcp.vo.AccountVo;

public interface AccountDao {
    int deleteByPrimaryKey(Map<String, Object> params);

    int insert(Account account);

    int insertSelective(Account account);

    Account selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(Account account);

    int updateByPrimaryKeyWithBLOBs(Account account);

    int updateByPrimaryKey(Account account);
    
    public Account selectAccountByLoginName(String loginName);
    
    public Account selectAccountByEmail(String email);
    
    public List<Account> selectAccountList(String status);

    /**
     * 分页查询
     * @param status
     * @return
     */
    public List<AccountVo> selectAccountListByPagination(Account account);
    
    public AccountVo selectAccountVoByLoginName(String loginName);
    
    public List<Account> checkLoginNameAndEmail(Map<String, Object> map);
    
    public List<Account> checkLoginName(Map<String, Object> map);
    
    public List<Account> checkEmailAddress(Map<String, Object> map);
    
    /**
     * 查询系统Admin账户
     * @param systemId
     * @return
     */
    public Account selectSysAdmin(Map<String, Object> map);
}