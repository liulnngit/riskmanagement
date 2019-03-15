package com.jesse.dpp.rcp.service;

import java.util.List;

import com.jesse.dpp.rcp.po.Menu;

public interface IMenuService {
    int deleteByPrimaryKey(Integer id);

    int insert(Menu menu);

    int insertSelective(Menu menu);

    Menu selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(Menu menu);

    int updateByPrimaryKeyWithBLOBs(Menu menu);

    int updateByPrimaryKey(Menu menu);

    public List<Menu> selectMenuList(String status);
    
    public List<Menu> selectMenuListByType(String type);

    public List<Menu> selectMenuListByIds(List<Integer> menuIds);
}