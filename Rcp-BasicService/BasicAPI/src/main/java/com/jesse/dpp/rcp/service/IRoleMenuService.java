package com.jesse.dpp.rcp.service;

import java.util.List;

import com.jesse.dpp.rcp.po.RoleMenu;

public interface IRoleMenuService {
    int deleteByPrimaryKey(Integer id);

    int insert(RoleMenu roleMenu);

    int insertSelective(RoleMenu roleMenu);

    RoleMenu selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(RoleMenu roleMenu);

    int updateByPrimaryKeyWithBLOBs(RoleMenu roleMenu);

    int updateByPrimaryKey(RoleMenu roleMenu);

    public List<RoleMenu> selectRoleMenuListByRoleId(Integer roleId);
    
    /**
     * 查找所有 MtmRoleMenu
     * 
     * @return
     */
    public List<RoleMenu> selectRoleMenuList();
    
    /**
     * 
     * @param roleId
     * @return
     */
    public int deleteBatchByRoleId(Integer roleId);
}