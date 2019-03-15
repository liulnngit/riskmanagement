package com.jesse.dpp.rcp.service.impl;

import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;

import com.jesse.dpp.rcp.dao.MenuDao;
import com.jesse.dpp.rcp.po.Menu;
import com.jesse.dpp.rcp.service.IMenuService;
import com.jesse.dpp.rcp.utils.exception.BaseRuntimeException;

public class MenuServiceImpl implements IMenuService {

    private static Log log = LogFactory.getLog(MenuServiceImpl.class);

    @Autowired
    private MenuDao menuDao;

    @Override
    public int deleteByPrimaryKey(Integer id) {
        return 0;
    }

    @Override
    public int insert(Menu record) {
        return 0;
    }

    @Override
    public int insertSelective(Menu record) {
        return 0;
    }

    @Override
    public Menu selectByPrimaryKey(Integer id) {
        try{
            return menuDao.selectByPrimaryKey(id);
        } catch(Exception e){
            log.error(e.getMessage(), e);
            throw new BaseRuntimeException(e.getMessage());
        }
    }

    @Override
    public int updateByPrimaryKeySelective(Menu record) {
        return 0;
    }

    @Override
    public int updateByPrimaryKey(Menu record) {
        return 0;
    }

    @Override
    public List<Menu> selectMenuList(String status) {
        try {
            return menuDao.selectMenuList(status);
        } catch (Exception e) {
            log.error(e.getMessage(), e);
            throw new BaseRuntimeException(e.getMessage());
        }
    }

    @Override
    public List<Menu> selectMenuListByIds(List<Integer> menuIds) {
        try {
            return menuDao.selectMenuListByIds(menuIds);
        } catch (Exception e) {
            log.error(e.getMessage(), e);
            throw new BaseRuntimeException(e.getMessage());
        }
    }

    @Override
    public int updateByPrimaryKeyWithBLOBs(Menu menu) {
        return 0;
    }

    @Override
    public List<Menu> selectMenuListByType(String type) {
        try{
            return menuDao.selectMenuListByType(type);
        } catch(Exception e){
            log.error(e.getMessage(), e);
            throw new BaseRuntimeException(e.getMessage());
        }
    }
}
