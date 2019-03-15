package com.jesse.dpp.rcp.service;

import com.jesse.dpp.rcp.po.ActiveAccount;

public interface IActiveAccountService {
    int deleteByPrimaryKey(Integer id);

    int insert(ActiveAccount activeAccount);

    int insertSelective(ActiveAccount activeAccount);

    ActiveAccount selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(ActiveAccount activeAccount);

    int updateByPrimaryKeyWithBLOBs(ActiveAccount activeAccount);

    int updateByPrimaryKey(ActiveAccount activeAccount);
    
    public ActiveAccount selectActiveAccountBySid(String sid);
    
    public ActiveAccount selectActiveAccountByEmail(String email);
    
    public ActiveAccount selectActiveAccountByAccountId(Integer accountId);
}
