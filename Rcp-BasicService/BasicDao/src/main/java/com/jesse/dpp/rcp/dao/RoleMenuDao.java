package com.jesse.dpp.rcp.dao;

import java.util.List;
import java.util.Map;

import com.jesse.dpp.rcp.po.RoleMenu;

public interface RoleMenuDao {
    int deleteByPrimaryKey(Integer id);

    int insert(RoleMenu roleMenu);

    int insertSelective(RoleMenu roleMenu);

    RoleMenu selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(RoleMenu roleMenu);

    int updateByPrimaryKeyWithBLOBs(RoleMenu roleMenu);

    int updateByPrimaryKey(RoleMenu roleMenu);
    
    public List<RoleMenu> selectRoleMenuListByRoleId(Integer roleId);

    public int deleteBatchByRoleId(Map<String, Object> map);

    /**
     * 查找所有 RoleMenu
     * 
     * @return
     */
    public List<RoleMenu> selectRoleMenuList();
}