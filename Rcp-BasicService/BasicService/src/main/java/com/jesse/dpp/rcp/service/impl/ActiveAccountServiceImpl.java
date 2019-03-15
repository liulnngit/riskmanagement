package com.jesse.dpp.rcp.service.impl;

import java.util.HashMap;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;

import com.jesse.dpp.rcp.dao.ActiveAccountDao;
import com.jesse.dpp.rcp.po.ActiveAccount;
import com.jesse.dpp.rcp.service.IActiveAccountService;
import com.jesse.dpp.rcp.utils.exception.BaseRuntimeException;

public class ActiveAccountServiceImpl implements IActiveAccountService {

    private static Log log = LogFactory.getLog(ActiveAccountServiceImpl.class);
    
    @Autowired
    private ActiveAccountDao activeAccountDao;
    
    @Override
    public int deleteByPrimaryKey(Integer id) {
        try {
            return activeAccountDao.deleteByPrimaryKey(id);
        } catch (Exception e) {
            log.error(e.getMessage(), e);
            throw new BaseRuntimeException(e.getMessage());
        }
    }

    @Override
    public int insert(ActiveAccount activeAccount) {
        try {
            return activeAccountDao.insert(activeAccount);
        } catch (Exception e) {
            log.error(e.getMessage(), e);
            throw new BaseRuntimeException(e.getMessage());
        }
    }

    @Override
    public int insertSelective(ActiveAccount activeAccount) {
        try {
            return activeAccountDao.insertSelective(activeAccount);
        } catch (Exception e) {
            log.error(e.getMessage(), e);
            throw new BaseRuntimeException(e.getMessage());
        }
    }

    @Override
    public ActiveAccount selectByPrimaryKey(Integer id) {
        try {
            return activeAccountDao.selectByPrimaryKey(id);
        } catch (Exception e) {
            log.error(e.getMessage(), e);
            throw new BaseRuntimeException(e.getMessage());
        }
    }

    @Override
    public int updateByPrimaryKeySelective(ActiveAccount activeAccount) {
        try {
            return activeAccountDao.updateByPrimaryKeySelective(activeAccount);
        } catch (Exception e) {
            log.error(e.getMessage(), e);
            throw new BaseRuntimeException(e.getMessage());
        }
    }

    @Override
    public int updateByPrimaryKeyWithBLOBs(ActiveAccount activeAccount) {
        try {
            return activeAccountDao.updateByPrimaryKeyWithBLOBs(activeAccount);
        } catch (Exception e) {
            log.error(e.getMessage(), e);
            throw new BaseRuntimeException(e.getMessage());
        }
    }

    @Override
    public int updateByPrimaryKey(ActiveAccount activeAccount) {
        try {
            return activeAccountDao.updateByPrimaryKey(activeAccount);
        } catch (Exception e) {
            log.error(e.getMessage(), e);
            throw new BaseRuntimeException(e.getMessage());
        }
    }

    @Override
    public ActiveAccount selectActiveAccountBySid(String sid) {
        try {
            return activeAccountDao.selectActiveAccountBySid(sid);
        } catch (Exception e) {
            log.error(e.getMessage(), e);
            throw new BaseRuntimeException(e.getMessage());
        }
    }

    @Override
    public ActiveAccount selectActiveAccountByEmail(String email) {
        try {
            return activeAccountDao.selectActiveAccountByEmail(email);
        } catch (Exception e) {
            log.error(e.getMessage(), e);
            throw new BaseRuntimeException(e.getMessage());
        }
    }

    @Override
    public ActiveAccount selectActiveAccountByAccountId(Integer accountId) {
        try {
            Map<String, Object> map = new HashMap<String, Object>();
            map.put("accountId", accountId);
            return activeAccountDao.selectActiveAccountByAccountId(map);
        } catch (Exception e) {
            log.error(e.getMessage(), e);
            throw new BaseRuntimeException(e.getMessage());
        }
    }

}
