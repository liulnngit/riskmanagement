package com.jesse.dpp.rcp.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang3.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;

import com.jesse.dpp.rcp.constant.Constant;
import com.jesse.dpp.rcp.dao.RoleDao;
import com.jesse.dpp.rcp.dao.SystemTypeDao;
import com.jesse.dpp.rcp.po.Account;
import com.jesse.dpp.rcp.po.Menu;
import com.jesse.dpp.rcp.po.Role;
import com.jesse.dpp.rcp.po.RoleMenu;
import com.jesse.dpp.rcp.service.IAccountRoleService;
import com.jesse.dpp.rcp.service.IAccountService;
import com.jesse.dpp.rcp.service.IMenuService;
import com.jesse.dpp.rcp.service.IRoleMenuService;
import com.jesse.dpp.rcp.service.IRoleService;
import com.jesse.dpp.rcp.utils.exception.BaseRuntimeException;
import com.jesse.dpp.rcp.vo.RoleVo;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

public class RoleServiceImpl implements IRoleService {

    private static Log log = LogFactory.getLog(RoleServiceImpl.class);

    @Autowired
    private RoleDao roleDao;

    @Autowired
    private IRoleMenuService iRoleMenuService;

    @Autowired
    private IAccountRoleService iAccountRoleService;

    @Autowired
    private SystemTypeDao systemTypeDao;

    @Autowired
    private IAccountService iAccountService;

    @Autowired
    private IMenuService iMenuService;

    @Override
    public int deleteByPrimaryKey(Integer id, String systemId) {
        try {
        	Map<String, Object> params = new HashMap<String, Object>();
        	params.put("id", id);
        	params.put("systemId", systemId);
            return roleDao.deleteByPrimaryKey(params);
        } catch (Exception e) {
            log.error(e.getMessage(), e);
            throw new BaseRuntimeException(e.getMessage());
        }
    }

    @Override
    public int insert(Role role) {
        try {
            return roleDao.insert(role);
        } catch (Exception e) {
            log.error(e.getMessage(), e);
            throw new BaseRuntimeException(e.getMessage());
        }
    }

    @Override
    public int insertSelective(Role role) {
        try {
            return roleDao.insertSelective(role);
        } catch (Exception e) {
            log.error(e.getMessage(), e);
            throw new BaseRuntimeException(e.getMessage());
        }
    }

    @Override
    public Role selectByPrimaryKey(Integer id) {
        try {
            return roleDao.selectByPrimaryKey(id);
        } catch (Exception e) {
            log.error(e.getMessage(), e);
            throw new BaseRuntimeException(e.getMessage());
        }
    }

    @Override
    public int updateByPrimaryKeySelective(Role role) {
        try {
            return roleDao.updateByPrimaryKeySelective(role);
        } catch (Exception e) {
            log.error(e.getMessage(), e);
            throw new BaseRuntimeException(e.getMessage());
        }
    }

    @Override
    public int updateByPrimaryKeyWithBLOBs(Role role) {
        try {
            return roleDao.updateByPrimaryKeyWithBLOBs(role);
        } catch (Exception e) {
            log.error(e.getMessage(), e);
            throw new BaseRuntimeException(e.getMessage());
        }
    }

    @Override
    public int updateByPrimaryKey(Role role) {
        try {
            return roleDao.updateByPrimaryKey(role);
        } catch (Exception e) {
            log.error(e.getMessage(), e);
            throw new BaseRuntimeException(e.getMessage());
        }
    }

    @Override
    public List<Role> selectRoleListByIds(String roleIDs) {
        List<String> roleIDList = new ArrayList<String>();
        try {
            if (null != roleIDs && "" != roleIDs) {
                String[] ids = roleIDs.split(",");
                for (String id : ids) {
                    roleIDList.add(id);
                }
            }
            return roleDao.selectRoleListByIds(roleIDList);
        } catch (Exception e) {
            log.error(e.getMessage(), e);
            throw new BaseRuntimeException(e.getMessage());
        }
    }

    @Override
    public int addRole(Role role, Integer creatorId, String menuIds, String ipAddress) {
        try {
            role.setCreatorId(creatorId);
            role.setCreateDate(String.valueOf(System.currentTimeMillis()));
            role.setUpdaterId(role.getCreatorId());
            role.setUpdateDate(String.valueOf(System.currentTimeMillis()));
            int count = roleDao.insertSelective(role);

            RoleMenu roleMenu = new RoleMenu();
            roleMenu.setRoleId(role.getId());
            roleMenu.setMenuId(999);
            roleMenu.setStatus(Constant.RECORD_ACTIVE);
            roleMenu.setCreatorId(creatorId);
            roleMenu.setCreateDate(String.valueOf(System.currentTimeMillis()));
            roleMenu.setUpdaterId(creatorId);
            roleMenu.setUpdateDate(String.valueOf(System.currentTimeMillis()));
            iRoleMenuService.insertSelective(roleMenu);
            
            if (StringUtils.isNotBlank(menuIds)) {
                
                String[] menuArr = menuIds.split(",");
                for (String menuId : menuArr) {
                    RoleMenu tmpMtmRoleMenu = new RoleMenu();
                    tmpMtmRoleMenu.setRoleId(role.getId());
                    tmpMtmRoleMenu.setMenuId(Integer.valueOf(menuId));
                    tmpMtmRoleMenu.setStatus(Constant.RECORD_ACTIVE);
                    tmpMtmRoleMenu.setCreatorId(creatorId);
                    tmpMtmRoleMenu.setCreateDate(String.valueOf(System.currentTimeMillis()));
                    tmpMtmRoleMenu.setUpdaterId(creatorId);
                    tmpMtmRoleMenu.setUpdateDate(String.valueOf(System.currentTimeMillis()));
                    iRoleMenuService.insertSelective(tmpMtmRoleMenu);
                }
            }

            return count;
        } catch (Exception e) {
            log.error(e.getMessage(), e);
            throw new BaseRuntimeException(e.getMessage());
        }
    }

    @Override
    public int updateRole(Role role, Integer updaterId, String menuIds, String ipAddress) {
        int count = 0;
        try {
            log.info("start updateRole..........");
            boolean isUpdate = false;
            StringBuffer oldSbuffer = new StringBuffer();
            StringBuffer newSbuffer = new StringBuffer();

            Role originalRole = roleDao.selectByPrimaryKey(role.getId());
            List<RoleMenu> originRoleMenu = iRoleMenuService.selectRoleMenuListByRoleId(role.getId());
            StringBuffer tmpBuffer = new StringBuffer();
            for (RoleMenu roleMenu : originRoleMenu) {
                tmpBuffer.append(roleMenu.getMenuId()).append(",");
            }
            if (tmpBuffer.length() > 0) {
                String tmpStr = tmpBuffer.toString();
                String oldMenuIds = tmpStr.toString().substring(0, tmpStr.length() - 1);
                if (!oldMenuIds.equals(menuIds)) {
                    oldSbuffer.append("绑定菜单：[").append(this.getMenuNames(oldMenuIds)).append("] ");
                    newSbuffer.append("绑定菜单：[").append(this.getMenuNames(menuIds)).append("] ");
                    isUpdate = true;
                }
            }

            role.setUpdaterId(updaterId);
            role.setUpdateDate(String.valueOf(System.currentTimeMillis()));
            count = roleDao.updateByPrimaryKeySelective(role);

            iRoleMenuService.deleteBatchByRoleId(role.getId());

            if (StringUtils.isNotBlank(menuIds)) {
                String[] menuArr = menuIds.split(",");
                for (String menuId : menuArr) {
                    RoleMenu tmpMtmRoleMenu = new RoleMenu();
                    tmpMtmRoleMenu.setRoleId(role.getId());
                    tmpMtmRoleMenu.setMenuId(new Integer(menuId));
                    tmpMtmRoleMenu.setStatus(Constant.RECORD_ACTIVE);
                    tmpMtmRoleMenu.setCreatorId(updaterId);
                    tmpMtmRoleMenu.setCreateDate(String.valueOf(System.currentTimeMillis()));
                    tmpMtmRoleMenu.setUpdaterId(updaterId);
                    tmpMtmRoleMenu.setUpdateDate(String.valueOf(System.currentTimeMillis()));
                    iRoleMenuService.insertSelective(tmpMtmRoleMenu);
                }
            }

            List<Integer> userList = new ArrayList<Integer>();
            if (!originalRole.getRoleName().equals(role.getRoleName())) {
                oldSbuffer.append("角色名称：[").append(originalRole.getRoleName()).append("] ");
                newSbuffer.append("角色名称：[").append(role.getRoleName()).append("] ");
                isUpdate = true;

            }

            log.info("updateRole end............");
            return count;
        } catch (Exception e) {
            log.error(e.getMessage(), e);
            throw new BaseRuntimeException(e.getMessage());
        }
    }

    @Override
    public int deleteRole(Integer id, Account account, String ipAddress) {
        try {
            Role role = roleDao.selectByPrimaryKey(id);

            Map<String, Object> map = new HashMap<String, Object>();
            map.put("id", id);
            iAccountRoleService.deleteBatchByRoleId(id);
            iRoleMenuService.deleteBatchByRoleId(id);
            map.put("systemId", account.getSystemId());
            int count = roleDao.deleteByPrimaryKey(map);

            return count;
        } catch (Exception e) {
            log.error(e.getMessage(), e);
            throw new BaseRuntimeException(e.getMessage());
        }
    }

    @Override
    public PageInfo<RoleVo> selectRoleListByPagination(String status, String systemId, int currentPage,
            Integer limit) {
        try {
            Map<String, Object> map = new HashMap<String, Object>();
            map.put("status", status);
            map.put("systemId", systemId);
            PageHelper.startPage(currentPage, limit);
            List<RoleVo> roleList = roleDao.selectRoleListByPagination(map);
            PageInfo<RoleVo> pageInfo = new PageInfo<RoleVo>(roleList);
            return pageInfo;
        } catch (Exception e) {
            log.error(e.getMessage(), e);
            throw new BaseRuntimeException(e.getMessage());
        }
    }

    @Override
    public List<Role> selectRoleListBySystemId(String systemId) {
        try {
            List<Role> roleList = roleDao.selectRoleListBySystemId(systemId);
            return roleList;
        } catch (Exception e) {
            log.error(e.getMessage(), e);
            throw new BaseRuntimeException(e.getMessage());
        }
    }

    @Override
    public boolean checkRoleName(Role role, String systemId) {
        try {
            Map<String, Object> map = new HashMap<String, Object>();
            map.put("id", role.getId());
            map.put("roleName", role.getRoleName());
            map.put("systemId", systemId);
            List<Role> list = roleDao.checkRoleName(map);
            if (null != list && list.size() > 0) {
                return false;
            }
            return true;
        } catch (Exception e) {
            log.error(e.getMessage(), e);
            throw new BaseRuntimeException(e.getMessage());
        }
    }

    @Override
    public Role selectAdministrator(String systemId) {
        try {
            Map<String, Object> map = new HashMap<String, Object>();
            map.put("systemId", systemId);
            Role administrator = roleDao.selectAdministrator(map);
            return administrator;
        } catch (Exception e) {
            log.error(e.getMessage(), e);
            throw new BaseRuntimeException(e.getMessage());
        }
    }

    private String getMenuNames(String menuIds) {
        String menuNames = "";
        if(StringUtils.isNotBlank(menuIds)){
            StringBuffer sbuffer = new StringBuffer();
            String[] menuIdArr = menuIds.split(",");
            for (String menuId : menuIdArr) {
                Menu menu = iMenuService.selectByPrimaryKey(Integer.valueOf(menuId));
                if (null != menu) {
                    sbuffer.append(menu.getMenuName()).append(", ");
                }
            }
            menuNames = sbuffer.toString();
            if (menuNames.length() > 2) {
                menuNames = menuNames.substring(0, menuNames.length() - 2);
            }
        }
        return menuNames;
    }

    @Override
    public Role selectRoleByName(String roleName, String systemId) {
        try {
            Map<String, Object> map = new HashMap<String, Object>();
            map.put("systemId", systemId);
            map.put("roleName", roleName);
            Role administrator = roleDao.selectRoleByName(map);
            return administrator;
        } catch (Exception e) {
            log.error(e.getMessage(), e);
            return null;
        }
    }
}