package com.jesse.dpp.rcp.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.apache.commons.codec.digest.DigestUtils;
import org.apache.commons.lang3.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;

import com.jesse.dpp.rcp.constant.Constant;
import com.jesse.dpp.rcp.dao.SystemTypeDao;
import com.jesse.dpp.rcp.po.Account;
import com.jesse.dpp.rcp.po.BusinessType;
import com.jesse.dpp.rcp.po.Payclass;
import com.jesse.dpp.rcp.po.Role;
import com.jesse.dpp.rcp.po.SysParameter;
import com.jesse.dpp.rcp.po.SystemType;
import com.jesse.dpp.rcp.service.IAccountService;
import com.jesse.dpp.rcp.service.IRoleMenuService;
import com.jesse.dpp.rcp.service.IRoleService;
import com.jesse.dpp.rcp.service.ISysParameterService;
import com.jesse.dpp.rcp.service.ISystemTypeService;
import com.jesse.dpp.rcp.utils.EncryptUtil;
import com.jesse.dpp.rcp.utils.exception.BaseRuntimeException;
import com.jesse.dpp.rcp.vo.SystemTypeVo;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

public class SystemTypeServiceImpl implements ISystemTypeService {
    
    private Log log = LogFactory.getLog(SystemTypeServiceImpl.class);
    
    @Autowired
    private SystemTypeDao systemTypeDao;
    
    
    @Autowired
    private IRoleService iRoleService;
    
    @Autowired
    private IAccountService iAccountService;
    
    @Autowired
    private IRoleMenuService iRoleMenuService;
    
    @Autowired
    private ISysParameterService iSysParameterService;
    
    
    @Override
    public int deleteByPrimaryKey(String id) {
        try {
            return systemTypeDao.deleteByPrimaryKey(id);
        } catch (Exception e) {
            log.error(e.getMessage(), e);
            throw new BaseRuntimeException(e.getMessage());
        }
    }

    @Override
    public int insert(SystemType systemType) {
        try {
            return systemTypeDao.insert(systemType);
        } catch (Exception e) {
            log.error(e.getMessage(), e);
            throw new BaseRuntimeException(e.getMessage());
        }
    }

    @Override
    public int insertSelective(SystemType systemType) {
        try {
			return systemTypeDao.insertSelective(systemType);
		} catch (Exception e) {
			log.error(e.getMessage(), e);
            throw new BaseRuntimeException(e.getMessage());
		}
    }

    @Override
    public SystemType selectByPrimaryKey(String id) {
        try {
            return systemTypeDao.selectByPrimaryKey(id);
        } catch (Exception e) {
            log.error(e.getMessage(), e);
            throw new BaseRuntimeException(e.getMessage());
        }
    }

    @Override
    public int updateByPrimaryKeySelective(SystemType systemType) {
        try {
            return systemTypeDao.updateByPrimaryKeySelective(systemType);
        } catch (Exception e) {
            log.error(e.getMessage(), e);
            throw new BaseRuntimeException(e.getMessage());
        }
    }

    @Override
    public int updateByPrimaryKey(SystemType systemType) {
        try {
            return systemTypeDao.updateByPrimaryKey(systemType);
        } catch (Exception e) {
            log.error(e.getMessage(), e);
            throw new BaseRuntimeException(e.getMessage());
        }
    }

    @Override
    public List<SystemTypeVo> selectList() {
        try{
            return systemTypeDao.selectList();
        } catch(Exception e){
            log.error(e.getMessage(), e);
            throw new BaseRuntimeException(e.getMessage());
        }
    }

    @Override
    public SystemType selectByToken(String token) {
        try{
            return systemTypeDao.selectByToken(token);
        } catch(Exception e){
            log.error(e.getMessage(), e);
            throw new BaseRuntimeException(e.getMessage());
        }
    }

    @Override
    public List<SystemTypeVo> selectActiveList(String status) {
        try{
            return systemTypeDao.selectActiveList(status);
        } catch(Exception e){
            log.error(e.getMessage(), e);
            throw new BaseRuntimeException(e.getMessage());
        }
    }

    @Override
    public int addSystemType(SystemType systemType, Integer creatorId, String basePath, String ipAddress, String testSystemId) {
        try {
            String systemId = UUID.randomUUID().toString().replace("-", "");
            String token = EncryptUtil.generateToken();
            if(null == token){
                String errorMsg = "generateToken error.........";
                log.error(errorMsg);
                throw new BaseRuntimeException(errorMsg);
            }
            
            systemType.setId(systemId);
            systemType.setToken(token);
            systemType.setStatus(Constant.RECORD_ACTIVE);
            systemType.setCreatorId(creatorId);
            systemType.setCreateDate(String.valueOf(System.currentTimeMillis()));
            systemType.setUpdaterId(creatorId);
            systemType.setUpdateDate(String.valueOf(System.currentTimeMillis()));
            
            log.info("addSystemType.........");
            int count = insert(systemType);
            if(count > 0){
                // init something
                count = this.initData(systemType, creatorId, basePath, ipAddress, testSystemId);
            }
            
            return count;
        } catch (Exception e) {
            log.error(e.getMessage(), e);
            throw new BaseRuntimeException(e.getMessage());
        }
    }
    
    private int initData(SystemType systemType, Integer creatorId, String basePath, String ipAddress, String testSystemId) throws Exception {
        String systemId = systemType.getId();
        
        int count1;
        try {
            //init default businessType
            BusinessType businessType = new BusinessType();
            businessType.setCode("default");
            businessType.setStatus(Constant.RECORD_SYSTEM);
            businessType.setSystemId(systemId);
            businessType.setTitle("默认行业");
            log.info("init BusinessType.........");
            
            //init role
            Role adminRole = new Role();
            adminRole.setRoleName("Admin");
            adminRole.setSystemId(systemId);
            adminRole.setStatus(Constant.RECORD_SYSTEM);
            log.info("init Role: " + adminRole.getRoleName() + "..........");
            int count2 = iRoleService.addRole(adminRole, creatorId, "23,231,232", ipAddress);
            
            Role fkManagerRole = new Role();
            fkManagerRole.setRoleName("风控经理");
            fkManagerRole.setSystemId(systemId);
            fkManagerRole.setStatus(Constant.RECORD_SYSTEM);
            log.info("init Role: " + fkManagerRole.getRoleName() + "..........");
            int count3 = iRoleService.addRole(fkManagerRole, creatorId, "", ipAddress);
            
            Role fkLeaderRole = new Role();
            fkLeaderRole.setRoleName("风控组长");
            fkLeaderRole.setSystemId(systemId);
            fkLeaderRole.setStatus(Constant.RECORD_SYSTEM);
            log.info("init Role: " + fkLeaderRole.getRoleName() + "..........");
            int count4 = iRoleService.addRole(fkLeaderRole, creatorId, "", ipAddress);
            
            Role fkCommissionerRole = new Role();
            fkCommissionerRole.setRoleName("风控专员");
            fkCommissionerRole.setSystemId(systemId);
            fkCommissionerRole.setStatus(Constant.RECORD_SYSTEM);
            log.info("init Role: " + fkCommissionerRole.getRoleName() + "..........");
            int count5 = iRoleService.addRole(fkCommissionerRole, creatorId, "", ipAddress);
            
            Role fkAuditRole = new Role();
            fkAuditRole.setRoleName("审计");
            fkAuditRole.setSystemId(systemId);
            fkAuditRole.setStatus(Constant.RECORD_SYSTEM);
            log.info("init Role: " + fkAuditRole.getRoleName() + "..........");
            int count6 = iRoleService.addRole(fkAuditRole, creatorId, "", ipAddress);
            
            Payclass payclass = new Payclass();
            payclass.setSystemId(systemId);
            payclass.setCode("default");
            payclass.setName("默认支付类型");
            payclass.setNameEn("default payclass");
            payclass.setAccessType("1");
            payclass.setStatus(Constant.RECORD_SYSTEM);
            
            
            // init admin account
            adminRole = iRoleService.selectRoleByName("Admin", systemId);
            if(null != adminRole && null != adminRole.getId()){
                String loginName = systemType.getSystemCode() + "Admin";
                Account account = new Account();
                account.setAccountType("2");
                account.setEmailAddress(systemType.getEmail());
                account.setLoginName(loginName);
                account.setLoginPwd(DigestUtils.md5Hex(Constant.SALT + loginName));
                account.setRoleId(String.valueOf(adminRole.getId()));
                account.setSystemId(systemId);
                account.setStatus(Constant.RECORD_SYSTEM);
                log.info("init Account.........");
                int count8 = iAccountService.addAccount(account, String.valueOf(adminRole.getId()), creatorId, basePath, ipAddress);
                if(count8 == 0){
                    log.error("初始化Admin用户失败");
                    throw new BaseRuntimeException("init data error");
                }
                
                // init sysParameter 
                List<SysParameter> list = iSysParameterService.selectListBySystemId(testSystemId);
                int count9 = 1;
                if(null != list && list.size() > 0){
                    for(SysParameter sysParameter : list){
                        SysParameter tmpSysParameter = new SysParameter();
                        tmpSysParameter.setDescription(sysParameter.getDescription());
                        tmpSysParameter.setParameterCode(sysParameter.getParameterCode());
                        tmpSysParameter.setParameterDefaultValue(sysParameter.getParameterDefaultValue());
                        tmpSysParameter.setParameterName(sysParameter.getParameterName());
                        tmpSysParameter.setParameterType(sysParameter.getParameterType());
                        tmpSysParameter.setSystemId(systemId);
                        log.info("init sysParameter: " + sysParameter.getParameterName() + "..........");
                        count9 = iSysParameterService.addSysParameter(tmpSysParameter, creatorId);
                        if(count9 == 0){
                            log.error("新增系统参数失败");
                            throw new BaseRuntimeException("新增系统参数失败");
                        }
                    }
                }
            } else {
                log.error("初始化角色失败");
                throw new BaseRuntimeException("init data error");
            }
            
            if( count2 == 0 || count3 == 0 || count4 == 0 || count5 == 0 || count6 == 0 ){
                log.error("初始化数据失败,count2 : " + count2 + ", count3 : " + count3 + ", count4 : " + count4 + ", count5 : " + count5 + ", count6 : " + count6);
                throw new BaseRuntimeException("init data error");
            }
        } catch (Exception e) {
            log.error(e.getMessage(), e);
            throw new BaseRuntimeException(e.getMessage());
        }
        return 1;
    }

    @Override
    public int updateSystemType(SystemType systemType, Integer updaterId) {
        try {
            systemType.setStatus(Constant.RECORD_ACTIVE);
            systemType.setUpdaterId(updaterId);
            systemType.setUpdateDate(String.valueOf(System.currentTimeMillis()));
            return systemTypeDao.updateByPrimaryKeySelective(systemType);
        } catch (Exception e) {
            log.error(e.getMessage(), e);
            throw new BaseRuntimeException(e.getMessage());
        }
    }

    @Override
    public int changeStatus(String id, String systemId, Integer updaterId) {
    	int count = 0;
        try {
            SystemType systemType = this.selectByPrimaryKey(id);
            if(null != systemType && !systemId.equals(systemType.getId())){
                if(Constant.RECORD_ACTIVE.equals(systemType.getStatus())){
                    systemType.setStatus(Constant.RECORD_INACTIVE);
                } else {
                    systemType.setStatus(Constant.RECORD_ACTIVE);
                }
                systemType.setUpdaterId(updaterId);
                systemType.setUpdateDate(String.valueOf(System.currentTimeMillis()));
                count = this.updateByPrimaryKey(systemType);
            } else {
                String errorMsg = "can not change the systemType Status by id : " + id + ", updaterId : " + updaterId;
                log.error(errorMsg);
            }
            return count;
        } catch (Exception e) {
            log.error(e.getMessage(), e);
            throw new BaseRuntimeException(e.getMessage());
        }
    }

    @Override
    public SystemTypeVo selectSystemTypeVoById(String id) {
        try {
            return systemTypeDao.selectSystemTypeVoById(id);
        } catch (Exception e) {
            log.error(e.getMessage(), e);
            throw new BaseRuntimeException(e.getMessage());
        }
    }

    @Override
    public boolean checkStatusActiveById(String id) {
        try {
            SystemType systemType = this.selectByPrimaryKey(id);
            if(null != systemType && Constant.RECORD_ACTIVE.equals(systemType.getStatus())){
                return true;
            }
        } catch (Exception e) {
            log.error(e.getMessage(), e);
        }
        return false;
    }

	@Override
	public PageInfo<SystemTypeVo> selectListByPagination(int currentpage, Integer limit) {
		try {
			PageHelper.startPage(currentpage, limit);
			List<SystemTypeVo> list = systemTypeDao.selectListByPagination();
			PageInfo<SystemTypeVo> pageInfo = new PageInfo<SystemTypeVo>(list);
			return pageInfo;
		} catch (Exception e) {
			log.error(e.getMessage(), e);
		}
		return null;
	}

    @Override
    public boolean checkSystemNameValid(String systemName, String id) {
        try {
            Map<String, Object> map = new HashMap<String, Object>();
            map.put("id", id);
            map.put("systemName", systemName);
            
            List<SystemType> list = systemTypeDao.checkSystemName(map);
            if(null != list && list.size() > 0){
                return false;
            }
            return true;
        } catch (Exception e) {
            log.error(e.getMessage(), e);
        }
        return false;
    }

	@Override
	public boolean checkSystemCodeValid(String systemCode, String id) {
		try {
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("id", id);
			map.put("systemCode", systemCode);
			List<SystemType> systemTypes = systemTypeDao.checkSystemCodeValid(map);
			if (null != systemTypes && systemTypes.size() > 0) {
				return false;
			} else {
				return true;
			}
		} catch (Exception e) {
			log.error(e.getMessage(), e);
		}
		return false;
	}

	@Override
	public boolean checkCompanyDomainValid(String companyDomain, String id) {
		try {
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("id", id);
			map.put("companyDomain", companyDomain);
			List<SystemType> systemTypes = systemTypeDao.checkCompanyDomainValid(map);
			if (null != systemTypes && systemTypes.size() > 0) {
				return false;
			} else {
				return true;
			}
		} catch (Exception e) {
			log.error(e.getMessage(), e);
		}
		return false;
	}

	@Override
	public boolean checkPhoneNumberValid(String phoneNumber, String id) {
		try {
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("id", id);
			map.put("phoneNumber", phoneNumber);
			List<SystemType> systemTypes = systemTypeDao.checkPhoneNumberValid(map);
			if (null != systemTypes && systemTypes.size() > 0) {
				return false;
			} else {
				return true;
			}
		} catch (Exception e) {
			log.error(e.getMessage(), e);
		}
		return false;
	}

	@Override
	public boolean checkEmailValid(String email, String id) {
		try {
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("id", id);
			map.put("email", email);
			List<SystemType> systemTypes = systemTypeDao.checkEmailValid(map);
			if (null != systemTypes && systemTypes.size() > 0) {
				return false;
			} else {
			    //新增接入系统时,还需要到t_sys_account表中校验邮箱是否在使用
			    if(StringUtils.isBlank(id)){
			        boolean flag = iAccountService.checkEmailAddress(email, null);
			        return flag;
			    }
				return true;
			}
		} catch (Exception e) {
			log.error(e.getMessage(), e);
		}
		return false;
	}

	@Override
	public List<SystemType> getAllAdmin() {
		try {
			List<SystemType> list = systemTypeDao.getAllAdmin();
			return list;
		} catch (Exception e) {
			log.error(e.getMessage(), e);
		}
		return null;
	}
}
