package com.jesse.dpp.rcp.service;

import java.util.List;

import com.jesse.dpp.rcp.po.Account;
import com.jesse.dpp.rcp.po.Role;
import com.jesse.dpp.rcp.vo.RoleVo;
import com.github.pagehelper.PageInfo;

public interface IRoleService {
    int deleteByPrimaryKey(Integer id, String systemId);

    int insert(Role role);

    int insertSelective(Role role);

    Role selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(Role role);

    int updateByPrimaryKeyWithBLOBs(Role role);

    int updateByPrimaryKey(Role role);

    public List<Role> selectRoleListByIds(String roleIDs);

    public int addRole(Role role, Integer creatorId, String menuIds, String ipAddress);

    public int updateRole(Role role, Integer updaterId, String menuIds, String ipAddress);

    public List<Role> selectRoleListBySystemId(String systemId);

    public int deleteRole(Integer id, Account account, String ipAddress);

    /**
     * 分页展示
     * 
     * @param code
     * @param currentPage
     * @param limit
     * @return
     */
    public PageInfo<RoleVo> selectRoleListByPagination(String status, String systemId, int currentPage, Integer limit);
    
    public boolean checkRoleName(Role role, String systemId);
    
    public Role selectAdministrator(String systemId);
    
    public Role selectRoleByName(String roleName, String systemId);
}