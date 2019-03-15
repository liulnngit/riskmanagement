package com.jesse.dpp.rcp.service;

import java.util.List;

import com.jesse.dpp.rcp.po.Permission;

public interface IPermissionService {
    int deleteByPrimaryKey(Integer id);

    int insert(Permission permission);

    int insertSelective(Permission permission);

    Permission selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(Permission permission);

    int updateByPrimaryKeyWithBLOBs(Permission permission);

    int updateByPrimaryKey(Permission permission);

    public List<Permission> selectPermissionList(String status);
}