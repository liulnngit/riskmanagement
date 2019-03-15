package com.jesse.dpp.rcp.dao;

import java.util.Map;

import com.jesse.dpp.rcp.po.ActiveAccount;

public interface ActiveAccountDao {
    int deleteByPrimaryKey(Integer id);

    int insert(ActiveAccount activeAccount);

    int insertSelective(ActiveAccount activeAccount);

    ActiveAccount selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(ActiveAccount activeAccount);

    int updateByPrimaryKeyWithBLOBs(ActiveAccount activeAccount);

    int updateByPrimaryKey(ActiveAccount activeAccount);
    
    public ActiveAccount selectActiveAccountBySid(String sid);
    
    public ActiveAccount selectActiveAccountByEmail(String sid);
    
    /**
     * 根据需激活的用户id查询
     * @param map
     * @return
     */
    public ActiveAccount selectActiveAccountByAccountId(Map<String, Object> map);
}