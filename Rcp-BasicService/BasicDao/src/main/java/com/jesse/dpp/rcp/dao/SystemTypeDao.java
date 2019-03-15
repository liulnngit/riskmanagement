package com.jesse.dpp.rcp.dao;

import java.util.List;
import java.util.Map;

import com.jesse.dpp.rcp.po.SystemType;
import com.jesse.dpp.rcp.vo.SystemTypeVo;

public interface SystemTypeDao {
    int deleteByPrimaryKey(String id);

    int insert(SystemType systemType);

    int insertSelective(SystemType systemType);

    SystemType selectByPrimaryKey(String id);

    int updateByPrimaryKeySelective(SystemType systemType);

    int updateByPrimaryKeyWithBLOBs(SystemType systemType);

    int updateByPrimaryKey(SystemType systemType);
    
    public List<SystemTypeVo> selectList();
    
    public List<SystemTypeVo> selectActiveList(String status);
    
    public SystemType selectByToken(String token);
    
    public SystemTypeVo selectSystemTypeVoById(String id);
    
    public List<SystemTypeVo> selectListByPagination();
    
    public List<SystemType> checkSystemName(Map<String, Object> map);
    
    public List<SystemType> checkSystemCodeValid(Map<String, Object> map);
    
    public List<SystemType> checkCompanyDomainValid(Map<String, Object> map);
    
    public List<SystemType> checkPhoneNumberValid(Map<String, Object> map);
    
    public List<SystemType> checkEmailValid(Map<String, Object> map);
    
    public List<SystemType> getAllAdmin();
}