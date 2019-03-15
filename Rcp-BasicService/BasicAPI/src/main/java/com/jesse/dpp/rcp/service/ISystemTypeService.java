package com.jesse.dpp.rcp.service;

import java.util.List;

import com.jesse.dpp.rcp.po.SystemType;
import com.jesse.dpp.rcp.vo.SystemTypeVo;
import com.github.pagehelper.PageInfo;

public interface ISystemTypeService {
    int deleteByPrimaryKey(String id);

    int insert(SystemType systemType);

    int insertSelective(SystemType systemType);

    SystemType selectByPrimaryKey(String id);

    int updateByPrimaryKeySelective(SystemType systemType);

    int updateByPrimaryKey(SystemType systemType);
    
    List<SystemTypeVo> selectList();
    
    List<SystemTypeVo> selectActiveList(String status);
    
    SystemType selectByToken(String token);
    
    int addSystemType(SystemType systemType, Integer creatorId, String basePath, String ipAddress, String testSystemId);
    
    int updateSystemType(SystemType systemType, Integer updaterId);
    
    int changeStatus(String id, String systemId, Integer updaterId);
    
    SystemTypeVo selectSystemTypeVoById(String id);
    
    boolean checkStatusActiveById(String id);

	PageInfo<SystemTypeVo> selectListByPagination(int currentpage, Integer limit);
	
	boolean checkSystemNameValid(String systemName, String id);
	
	boolean checkSystemCodeValid(String systemCode, String id);
	
	boolean checkCompanyDomainValid(String companyDomain, String id);
	
	boolean checkPhoneNumberValid(String phoneNumber, String id);
	
	boolean checkEmailValid(String email, String id);
	
	List<SystemType> getAllAdmin();
}
