package com.jesse.dpp.rcp.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.jesse.dpp.rcp.constant.Constant;
import com.jesse.dpp.rcp.enums.ResponseStatus;
import com.jesse.dpp.rcp.po.Account;
import com.jesse.dpp.rcp.po.AccountRole;
import com.jesse.dpp.rcp.po.Role;
import com.jesse.dpp.rcp.service.IAccountRoleService;
import com.jesse.dpp.rcp.service.IMenuService;
import com.jesse.dpp.rcp.service.IRoleService;
import com.jesse.dpp.rcp.session.SessionContext;
import com.jesse.dpp.rcp.shiro.IFilterChainDefinitonsService;
import com.jesse.dpp.rcp.utils.Utility;
import com.jesse.dpp.rcp.vo.RoleVo;
import com.github.pagehelper.PageInfo;

/**
 * 角色管理
 * 
 * @author tsx-t171
 *
 */
@Controller
public class RoleConttroller {

    private static Log log = LogFactory.getLog(RoleConttroller.class);

    @Autowired
    private IRoleService iRoleService;

    @Autowired
    private IMenuService iMenuService;

    @Autowired
    private IAccountRoleService iAccountRoleService;

    @Autowired
    IFilterChainDefinitonsService IFilterChainDefinitonsService;

    @RequestMapping(value = "addRole", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> addRole(String ids, Role role, HttpServletRequest request) throws Exception {
        Map<String, Object> obj = new HashMap<String, Object>();
        String result = ResponseStatus.RESPONSE_STATUS_FAIL.getStatus();
        boolean isFilter = false;
        try {
            Account account = SessionContext.getAccount();
            String systemId = null;
            if (null != account) {
                systemId = account.getSystemId();
            }
            boolean isValid = iRoleService.checkRoleName(role, systemId);
            if (isValid) {
                Integer accountId = account.getId();
                role.setSystemId(account.getSystemId());
                String ipAddress = Utility.getIpAddr(request);
                role.setStatus(Constant.RECORD_ACTIVE);
                int count = iRoleService.addRole(role, accountId, ids, ipAddress);
                if (count == 1) {
                    isFilter = true;
                    result = ResponseStatus.RESPONSE_STATUS_SUCCESS.getStatus();
                }
            }
            obj.put("status", result);
            return obj;
        } catch (Exception e) {
            log.error(e.getMessage(), e);
        } finally {
            if (isFilter) {
                new Thread(new Runnable() {
                    @Override
                    public void run() {
                        IFilterChainDefinitonsService.reloadFilterChain();
                    }
                }).start();
            }
        }
        return null;
    }

    /**
     * 分页
     * 
     * @param offset
     * @param limit
     * @return
     */
    @RequestMapping(value = "getListRole", method = RequestMethod.GET)
    @ResponseBody
    private Map<String, Object> getListRole(
            @RequestParam(value = "offset", defaultValue = "0") Integer offset,
            @RequestParam(value = "limit", defaultValue = "10") Integer limit) {
        try {
            log.info("getListRole start......");
            Account account = SessionContext.getAccount();
            int currentPage = offset / limit;
            currentPage += 1;
            PageInfo<RoleVo> roleList = iRoleService.selectRoleListByPagination(Constant.RECORD_ACTIVE,
                    account.getSystemId(), currentPage, limit);
            Map<String, Object> obj = new HashMap<String, Object>();
            obj.put("total", roleList.getTotal());
            obj.put("rows", roleList.getList());
            return obj;
        } catch (Exception e) {
            log.error(e.getMessage(), e);
        }
        return null;
    }

    @RequestMapping(value = "deleteRole", method = RequestMethod.POST)
    private @ResponseBody Map<String, Object> deleteRole(Integer id, HttpServletRequest request) {
        try {
            Map<String, Object> obj = new HashMap<String, Object>();
            String status = ResponseStatus.RESPONSE_STATUS_FAIL.getStatus();
            Account account = SessionContext.getAccount();
            Role role = iRoleService.selectByPrimaryKey(id);
            if (null != role && null != account) {
                if (Constant.RECORD_SYSTEM.equals(role.getStatus())) {
                    obj.put("isSystemRole", "isSystemRole");
                    obj.put("msg", "系统角色不允许删除！");
                    return obj;
                } else if(this.checkRoleUsed(id)) {
                    obj.put("isUsed", "isUsed");
                    obj.put("msg", "请先解除该角色绑定的用户！");
                    return obj;
                } else {
                    String ipAddress = Utility.getIpAddr(request);
                    int count = iRoleService.deleteRole(id, account, ipAddress);
                    if (count == 1) {
                        status = ResponseStatus.RESPONSE_STATUS_SUCCESS.getStatus();
                    }
                    obj.put("status", status);
                    return obj;
                }
            }
            return obj;
        } catch (Exception e) {
            log.error(e.getMessage(), e);
        } finally {
            new Thread(new Runnable() {
                @Override
                public void run() {
                    IFilterChainDefinitonsService.reloadFilterChain();
                }
            }).start();
        }
        return null;
    }

    @RequestMapping(value = "toEditRolePage", method = RequestMethod.GET)
    private ModelAndView toEditPage(String roleId) {
        try {
            ModelAndView mv = new ModelAndView("editRole");
            if (null != roleId && "" != roleId) {
                Role role = iRoleService.selectByPrimaryKey(new Integer(roleId));
                mv.addObject("role", role);
            }
            return mv;
        } catch (Exception e) {
            log.error(e.getMessage(), e);
        }
        return null;
    }

    @RequestMapping(value = "editRole", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, Object> editRole(String ids, Role role, HttpServletRequest request) throws Exception {
        Map<String, Object> obj = new HashMap<String, Object>();
        String result = ResponseStatus.RESPONSE_STATUS_FAIL.getStatus();
        boolean isFilter = false;
        try {
            Account account = SessionContext.getAccount();
            boolean isValid = true;
            if (null != account) {
                isValid = iRoleService.checkRoleName(role, account.getSystemId());
            }
            role.setSystemId(account.getSystemId());
            Role selectRole = iRoleService.selectByPrimaryKey(role.getId());
            String oldRoleNam = null;
            if (null != selectRole) {
                oldRoleNam = selectRole.getRoleName();
            }
            if (Constant.RECORD_SYSTEM.equals(role.getStatus()) && !role.getRoleName().equals(oldRoleNam)) {
                obj.put("isSystemRole", "isSystemRole");
                return obj;
            } else {
                if (isValid) {
                    role.setSystemId(account.getSystemId());
                    String ipAddress = Utility.getIpAddr(request);
                    int count = iRoleService.updateRole(role, account.getId(), ids, ipAddress);
                    if (count == 1) {
                        isFilter = true;
                        result = ResponseStatus.RESPONSE_STATUS_SUCCESS.getStatus();
                    }
                }
            }
        } catch (Exception e) {
            log.error(e.getMessage(), e);
        } finally {
            if (isFilter) {
                new Thread(new Runnable() {
                    @Override
                    public void run() {
                        IFilterChainDefinitonsService.reloadFilterChain();
                    }
                }).start();
            }
        }
        obj.put("status", result);
        return obj;
    }

    @RequestMapping(value = "role/checkRoleNameValid")
    public void checkRoleName(String roleName, String id, HttpServletRequest request,
            HttpServletResponse response) {
        try {
            log.info("checkRoleNameValid start......");
            Account account = SessionContext.getAccount();
            String systemId = null;
            if (null != account) {
                systemId = account.getSystemId();
            }
            roleName = roleName.trim();
            boolean result = false;
            if (StringUtils.isNotBlank(roleName) && StringUtils.isNotBlank(id)) {
                Role role = new Role();
                role.setId(Integer.parseInt(id));
                role.setRoleName(roleName);
                result = iRoleService.checkRoleName(role, systemId);
            } else if (StringUtils.isNotBlank(roleName) && StringUtils.isBlank(id)) {
                Role role = new Role();
                role.setRoleName(roleName);
                result = iRoleService.checkRoleName(role, systemId);
            }
            response.getWriter().print(result);
        } catch (Exception e) {
            log.error(e.getMessage(), e);
        }
    }

    @RequestMapping(value = "queryRoleList", method = RequestMethod.GET)
    @ResponseBody
    public List<Role> queryRoleList() {
        try {
            Account account = SessionContext.getAccount();
            String systemId = null;
            if (null != account) {
                systemId = account.getSystemId();
            }
            List<Role> roleList = iRoleService.selectRoleListBySystemId(systemId);
            return roleList;
        } catch (Exception e) {
            log.error(e.getMessage(), e);
        }
        return null;
    }
    
    /**
     * 检查该角色是否正在使用
     * @param id
     * @param systemId
     * @return
     */
    private boolean checkRoleUsed(Integer id){
        try {
            List<AccountRole> accountRoleList = iAccountRoleService.selectAccountListByRoleId(id);
            if(null != accountRoleList && accountRoleList.size() > 0){
                return true;
            }
            return false;
        } catch (Exception e) {
            log.error(e.getMessage(), e);
            return false;
        }
    }
}
