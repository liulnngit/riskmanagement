package com.jesse.dpp.rcp.service.impl;

import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;

import com.jesse.dpp.rcp.dao.PermissionDao;
import com.jesse.dpp.rcp.po.Permission;
import com.jesse.dpp.rcp.service.IPermissionService;
import com.jesse.dpp.rcp.utils.exception.BaseRuntimeException;

public class PermissionServiceImpl implements IPermissionService {

    private static Log log = LogFactory.getLog(PermissionServiceImpl.class);

    @Autowired
    private PermissionDao permissionDao;

    @Override
    public int deleteByPrimaryKey(Integer id) {
        try {
            return permissionDao.deleteByPrimaryKey(id);
        } catch (Exception e) {
            log.error(e.getMessage(), e);
            throw new BaseRuntimeException(e.getMessage());
        }
    }

    @Override
    public int insert(Permission permission) {
        return 0;
    }

    @Override
    public int insertSelective(Permission permission) {
        return 0;
    }

    @Override
    public Permission selectByPrimaryKey(Integer id) {
        return null;
    }

    @Override
    public int updateByPrimaryKeySelective(Permission permission) {
        return 0;
    }

    @Override
    public int updateByPrimaryKeyWithBLOBs(Permission permission) {
        return 0;
    }

    @Override
    public int updateByPrimaryKey(Permission permission) {
        return 0;
    }

    @Override
    public List<Permission> selectPermissionList(String status) {
        try {
            return permissionDao.selectPermissionList(status);
        } catch (Exception e) {
            log.error(e.getMessage(), e);
            throw new BaseRuntimeException(e.getMessage());
        }
    }
}
