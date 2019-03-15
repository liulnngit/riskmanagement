package com.jesse.dpp.rcp.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;

import com.jesse.dpp.rcp.dao.AccountRoleDao;
import com.jesse.dpp.rcp.po.AccountRole;
import com.jesse.dpp.rcp.service.IAccountRoleService;
import com.jesse.dpp.rcp.utils.exception.BaseRuntimeException;

public class AccountRoleServiceImpl implements IAccountRoleService {

    private static Log log = LogFactory.getLog(AccountRoleServiceImpl.class);

    @Autowired
    private AccountRoleDao accountRoleDao;

    @Override
    public int deleteByPrimaryKey(Integer id) {
        try {
            return accountRoleDao.deleteByPrimaryKey(id);
        } catch (Exception e) {
            log.error(e.getMessage(), e);
            throw new BaseRuntimeException(e.getMessage());
        }
    }

    @Override
    public int insert(AccountRole accountRole) {
        try {
            return accountRoleDao.insert(accountRole);
        } catch (Exception e) {
            log.error(e.getMessage(), e);
            throw new BaseRuntimeException(e.getMessage());
        }
    }

    @Override
    public int insertSelective(AccountRole accountRole) {
        try {
            return accountRoleDao.insertSelective(accountRole);
        } catch (Exception e) {
            log.error(e.getMessage(), e);
            throw new BaseRuntimeException(e.getMessage());
        }
    }

    @Override
    public AccountRole selectByPrimaryKey(Integer id) {
        try {
            return accountRoleDao.selectByPrimaryKey(id);
        } catch (Exception e) {
            log.error(e.getMessage(), e);
        }
        return null;
    }

    @Override
    public int updateByPrimaryKeySelective(AccountRole accountRole) {
        try {
            return accountRoleDao.updateByPrimaryKeySelective(accountRole);
        } catch (Exception e) {
            log.error(e.getMessage(), e);
            throw new BaseRuntimeException(e.getMessage());
        }
    }

    @Override
    public int updateByPrimaryKeyWithBLOBs(AccountRole accountRole) {
        try {
            return accountRoleDao.updateByPrimaryKeyWithBLOBs(accountRole);
        } catch (Exception e) {
            log.error(e.getMessage(), e);
            throw new BaseRuntimeException(e.getMessage());
        }
    }

    @Override
    public int updateByPrimaryKey(AccountRole accountRole) {
        try {
            return accountRoleDao.updateByPrimaryKey(accountRole);
        } catch (Exception e) {
            log.error(e.getMessage(), e);
            throw new BaseRuntimeException(e.getMessage());
        }
    }

    @Override
    public List<AccountRole> selectRoleListByAccountId(Integer accountId) {
        try {
            return accountRoleDao.selectRoleListByAccountId(accountId);
        } catch (Exception e) {
            log.error(e.getMessage(), e);
            throw new BaseRuntimeException(e.getMessage());
        }
    }

    @Override
    public List<AccountRole> selectAccountListByRoleId(Integer roleId) {
        try {
            return accountRoleDao.selectAccountListByRoleId(roleId);
        } catch (Exception e) {
            log.error(e.getMessage(), e);
            throw new BaseRuntimeException(e.getMessage());
        }
    }

    @Override
    public List<AccountRole> selectByPrimaryAccountID(Integer accountID) {
        try {
            return accountRoleDao.selectByPrimaryAccountID(accountID);
        } catch (Exception e) {
            log.error(e.getMessage(), e);
            throw new BaseRuntimeException(e.getMessage());
        }
    }

    @Override
    public int deleteBatchByAccountId(Integer accountId) {
        try {
            Map<String, Object> map = new HashMap<String, Object>();
            map.put("accountId", accountId);
            return accountRoleDao.deleteBatchByAccountId(map);
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
            return accountRoleDao.deleteBatchByRoleId(map);
        } catch (Exception e) {
            log.error(e.getMessage(), e);
            throw new BaseRuntimeException(e.getMessage());
        }
    }

	@Override
	public List<AccountRole> selectAccountList() {
        try {
            return accountRoleDao.selectAccountList();
        } catch (Exception e) {
            log.error(e.getMessage(), e);
            throw new BaseRuntimeException(e.getMessage());
        }
	}
}
