package com.jesse.dpp.rcp.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang3.StringUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;

import com.jesse.dpp.rcp.constant.Constant;
import com.jesse.dpp.rcp.dao.SysParameterDao;
import com.jesse.dpp.rcp.po.SysParameter;
import com.jesse.dpp.rcp.service.ISysParameterService;
import com.jesse.dpp.rcp.utils.exception.BaseRuntimeException;
import com.jesse.dpp.rcp.vo.SysParameterVo;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

public class SysParameterServiceImpl implements ISysParameterService {

    private static Log log = LogFactory.getLog(SysParameterServiceImpl.class);

    @Autowired
    private SysParameterDao sysParameterDao;
    

    @Override
    public int deleteByPrimaryKey(Integer id) {
        try {
            return sysParameterDao.deleteByPrimaryKey(id);
        } catch (Exception e) {
            log.error(e.getMessage(), e);
            throw new BaseRuntimeException(e.getMessage());
        }
    }

    @Override
    public int insert(SysParameter sysParameter) {
        try {
            return sysParameterDao.insert(sysParameter);
        } catch (Exception e) {
            log.error(e.getMessage(), e);
            throw new BaseRuntimeException(e.getMessage());
        }
    }

    @Override
    public int insertSelective(SysParameter sysParameter) {
        try {
            return sysParameterDao.insertSelective(sysParameter);
        } catch (Exception e) {
            log.error(e.getMessage(), e);
            throw new BaseRuntimeException(e.getMessage());
        }
    }

    @Override
    public SysParameter selectByPrimaryKey(Integer id) {
        try {
            return sysParameterDao.selectByPrimaryKey(id);
        } catch (Exception e) {
            log.error(e.getMessage(), e);
        }
        return null;
    }

    @Override
    public int updateByPrimaryKeySelective(SysParameter sysParameter) {
        try {
            return sysParameterDao.updateByPrimaryKeySelective(sysParameter);
        } catch (Exception e) {
            log.error(e.getMessage(), e);
            throw new BaseRuntimeException(e.getMessage());
        }
    }

    @Override
    public int updateByPrimaryKeyWithBLOBs(SysParameter sysParameter) {
        try {
            return sysParameterDao.updateByPrimaryKeyWithBLOBs(sysParameter);
        } catch (Exception e) {
            log.error(e.getMessage(), e);
            throw new BaseRuntimeException(e.getMessage());
        }
    }

    @Override
    public int updateByPrimaryKey(SysParameter sysParameter) {
        try {
            return sysParameterDao.updateByPrimaryKey(sysParameter);
        } catch (Exception e) {
            log.error(e.getMessage(), e);
            throw new BaseRuntimeException(e.getMessage());
        }
    }

    @Override
    public PageInfo<SysParameterVo> selectSysParameterListByPagination(int currentPage, Integer limit, String systemId) {
        try {
            Map<String, Object> map = new HashMap<String, Object>();
            map.put("systemId", systemId);
            
            PageHelper.startPage(currentPage, limit);
            List<SysParameterVo> sysParameters = sysParameterDao.selectSysParameterListByPagination(map);
            PageInfo<SysParameterVo> pageInfo = new PageInfo<SysParameterVo>(sysParameters);
            return pageInfo;
        } catch (Exception e) {
            log.error(e.getMessage(), e);
            throw new BaseRuntimeException(e.getMessage());
        }
    }

    @Override
    public SysParameter selectSysParameterByCode(String parameterCode, String systemId) {
        try {
            Map<String, Object> map = new HashMap<String, Object>();
            map.put("parameterCode", parameterCode);
            map.put("systemId", systemId);
            
            return sysParameterDao.selectSysParameterByCode(map);
        } catch (Exception e) {
            log.error(e.getMessage(), e);
            return null;
        }
    }

    @Override
    public int updateSysParameter(SysParameter sysParameter, Integer updaterId, String ipAddress) {
        try {
            boolean isUpdate = false;
            StringBuffer oldSbuffer = new StringBuffer();
            StringBuffer newSbuffer = new StringBuffer();
            
            SysParameter originalSysParameter = this.selectByPrimaryKey(sysParameter.getId());
            sysParameter.setUpdateDate(String.valueOf(System.currentTimeMillis()));
            sysParameter.setUpdaterId(updaterId);
            
            String oldValue = originalSysParameter.getParameterValue();
            String newValue = sysParameter.getParameterValue();
            if(StringUtils.isNotBlank(oldValue) && StringUtils.isNotBlank(newValue) && !oldValue.equals(newValue)){
                oldSbuffer.append("参数值：[").append(oldValue).append("]");
                newSbuffer.append("参数值：[").append(newValue).append("]");
                isUpdate = true;
            } else if(StringUtils.isBlank(oldValue) && StringUtils.isNotBlank(newValue)){
                oldSbuffer.append("参数值：[").append(oldValue).append("]");
                newSbuffer.append("参数值：[").append(newValue).append("]");
                isUpdate = true;
            }
            
            int count = this.updateByPrimaryKey(sysParameter);
            
            return count;
        } catch (Exception e) {
            log.error(e.getMessage(), e);
            throw new BaseRuntimeException(e.getMessage());
        }
    }

    @Override
    public List<SysParameter> selectListBySystemId(String systemId) {
        try {
            Map<String, Object> map = new HashMap<String, Object>();
            map.put("systemId", systemId);
            
            return sysParameterDao.selectListBySystemId(map);
        } catch (Exception e) {
            log.error(e.getMessage(), e);
            return null;
        }
    }

    @Override
    public int addSysParameter(SysParameter sysParameter, Integer creatorId) {
        try {
            sysParameter.setStatus(Constant.RECORD_ACTIVE);
            sysParameter.setCreatorId(creatorId);
            sysParameter.setCreateDate(String.valueOf(System.currentTimeMillis()));
            sysParameter.setUpdaterId(creatorId);
            sysParameter.setUpdateDate(String.valueOf(System.currentTimeMillis()));
            
            return sysParameterDao.insertSelective(sysParameter);
        } catch (Exception e) {
            log.error(e.getMessage(), e);
            throw new BaseRuntimeException(e.getMessage());
        }
    }
}
