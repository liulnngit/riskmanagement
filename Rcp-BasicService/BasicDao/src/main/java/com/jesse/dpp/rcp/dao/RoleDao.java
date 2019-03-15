package com.jesse.dpp.rcp.dao;

import java.util.List;
import java.util.Map;

import com.jesse.dpp.rcp.po.Role;
import com.jesse.dpp.rcp.vo.RoleVo;

public interface RoleDao {
    int deleteByPrimaryKey(Map<String, Object> params);

    int insert(Role role);

    int insertSelective(Role role);

    Role selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(Role role);

    int updateByPrimaryKeyWithBLOBs(Role role);

    int updateByPrimaryKey(Role role);

    public List<Role> selectRoleListBySystemId(String systemId);

    public List<Role> selectRoleListByIds(List<String> ids);
    
    public List<RoleVo> selectRoleListByPagination(Map<String, Object> map);
    
    public List<Role> checkRoleName(Map<String, Object> map);
    
    public Role selectAdministrator(Map<String, Object> map);
    
    public Role selectRoleByName(Map<String, Object> map);
}