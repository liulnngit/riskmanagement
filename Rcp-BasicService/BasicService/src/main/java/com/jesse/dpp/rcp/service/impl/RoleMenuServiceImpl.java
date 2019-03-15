package com.jesse.dpp.rcp.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;

import com.jesse.dpp.rcp.dao.RoleMenuDao;
import com.jesse.dpp.rcp.po.RoleMenu;
import com.jesse.dpp.rcp.service.IRoleMenuService;
import com.jesse.dpp.rcp.utils.exception.BaseRuntimeException;

public class RoleMenuServiceImpl implements IRoleMenuService {

    private static Log log = LogFactory.getLog(RoleMenuServiceImpl.class);

    @Autowired
    private RoleMenuDao roleMenuDao;

    @Override
    public int deleteByPrimaryKey(Integer id) {
        return 0;
    }

    @Override
    public int insert(RoleMenu roleMenu) {
        return 0;
    }

    @Override
    public int insertSelective(RoleMenu roleMenu) {
        try {
            return roleMenuDao.insertSelective(roleMenu);
        } catch (Exception e) {
            log.error(e.getMessage(), e);
            throw new BaseRuntimeException(e.getMessage());
        }
    }

    @Override
    public RoleMenu selectByPrimaryKey(Integer id) {
        return null;
    }

    @Override
    public int updateByPrimaryKeySelective(RoleMenu roleMenu) {
        return 0;
    }

    @Override
    public int updateByPrimaryKeyWithBLOBs(RoleMenu roleMenu) {
        return 0;
    }

    @Override
    public int updateByPrimaryKey(RoleMenu roleMenu) {
        return 0;
    }

    @Override
    public List<RoleMenu> selectRoleMenuListByRoleId(Integer roleId) {
        try {
            return roleMenuDao.selectRoleMenuListByRoleId(roleId);
        } catch (Exception e) {
            log.error(e.getMessage(), e);
            throw new BaseRuntimeException(e.getMessage());
        }
    }

    @Override
    public List<RoleMenu> selectRoleMenuList() {
        try {
            return roleMenuDao.selectRoleMenuList();
        } catch (Exception e) {
            log.error(e.getMessage(), e);
            throw new BaseRuntimeException(e.getMessage());
        }
    }

    @Override
    public int deleteBatchByRoleId(Integer roleId) {
        try {
            Map<String, Object> map = new HashMap<String, Object>();
            map.put("roleId", roleId);
            
            return roleMenuDao.deleteBatchByRoleId(map);
        } catch (Exception e) {
            log.error(e.getMessage(), e);
            throw new BaseRuntimeException(e.getMessage());
        }
    }
}
